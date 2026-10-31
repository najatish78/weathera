import 'dart:convert';

class ErrorModel {
  ErrorModel({
    required this.code,
    required this.message,
    required this.details,
    this.validationErrors = const {},
    this.errorCode,
    this.data,
  });

  final int? code;
  final String? message;
  final String? details;

  /// Raw ABP `error.code` as sent (e.g. `AtrasLink:EventOrderProductSoldOut`).
  /// [code] only keeps numeric codes; this keeps namespaced string codes.
  final String? errorCode;

  /// ABP `error.data`, when the server attached any.
  final Map<String, dynamic>? data;

  /// ABP `validationErrors[]`, flattened from `{message, members[]}` entries
  /// into `member -> [messages]` so a form can look a field error up by name.
  final Map<String, List<String>> validationErrors;

  /// User-facing text: [details] first, then [message].
  String? get displayMessage {
    final d = details?.trim();
    if (d != null && d.isNotEmpty) return d;
    final m = message?.trim();
    if (m != null && m.isNotEmpty) return m;
    return null;
  }

  ErrorModel copyWith({int? code, String? message, String? details}) {
    return ErrorModel(
      code: code ?? this.code,
      message: message ?? this.message,
      details: details ?? this.details,
    );
  }

  factory ErrorModel.fromJson(Map<String, dynamic> json) {
    return ErrorModel(
      code: _parseCode(json['code']),
      message: (json['message'] ?? json['error_description'])?.toString(),
      details: json['details']?.toString(),
      validationErrors: _parseValidationErrors(json['validationErrors']),
      errorCode: _parseErrorCode(json['code']),
      data: json['data'] is Map
          ? Map<String, dynamic>.from(json['data'] as Map)
          : null,
    );
  }

  static String? _parseErrorCode(dynamic value) {
    final code = value?.toString().trim();
    return (code == null || code.isEmpty) ? null : code;
  }

  static Map<String, List<String>> _parseValidationErrors(dynamic raw) {
    final result = <String, List<String>>{};
    if (raw is! List) return result;
    for (final entry in raw) {
      if (entry is! Map) continue;
      final message = entry['message']?.toString() ?? '';
      final members = entry['members'];
      if (members is! List) continue;
      for (final member in members) {
        result.putIfAbsent('$member', () => <String>[]).add(message);
      }
    }
    return result;
  }

  /// Parses ABP `{ error: { ... } }`, OAuth `{ error, error_description }`, or root fields.
  factory ErrorModel.fromResponse(dynamic data) {
    final map = _asMap(data);
    if (map == null) {
      return ErrorModel(code: null, message: null, details: null);
    }

    final nested = map['error'];
    if (nested is Map) {
      return ErrorModel.fromJson(Map<String, dynamic>.from(nested));
    }

    // OAuth token errors: error is a string code, message is error_description.
    if (map.containsKey('error_description') || nested is String) {
      final description = map['error_description']?.toString().trim();
      final errorCode = nested?.toString().trim();
      return ErrorModel(
        code: null,
        message: (description != null && description.isNotEmpty)
            ? description
            : errorCode,
        details: null,
      );
    }

    return ErrorModel.fromJson(map);
  }

  static int? _parseCode(dynamic value) {
    if (value is int) return value;
    if (value is String) return int.tryParse(value);
    return null;
  }

  static Map<String, dynamic>? _asMap(dynamic data) {
    if (data is Map<String, dynamic>) return data;
    if (data is Map) return Map<String, dynamic>.from(data);
    // A request made with ResponseType.bytes (e.g. the ticket PDF download)
    // still delivers a non-2xx error body as raw bytes, not decoded JSON.
    if (data is List<int>) {
      try {
        final decoded = jsonDecode(utf8.decode(data));
        if (decoded is Map) return Map<String, dynamic>.from(decoded);
      } catch (_) {}
      return null;
    }
    if (data is String && data.trim().isNotEmpty) {
      try {
        final decoded = jsonDecode(data);
        if (decoded is Map) return Map<String, dynamic>.from(decoded);
      } catch (_) {}
    }
    return null;
  }

  Map<String, dynamic> toJson() => {
    'code': code,
    'message': message,
    'details': details,
  };

  @override
  String toString() {
    return '$code, $message, $details, ';
  }
}
