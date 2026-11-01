/// POST /suggest-outfit — what to wear for the next hours.
class OutfitSuggestionModel {
  final String top;
  final String bottom;
  final String shoes;

  /// Null when it's warm enough to go without one.
  final String? jacket;
  final bool umbrella;
  final bool sunscreen;
  final String reason;

  /// False when the LLM was down and the service used its rule-based fallback.
  final bool fromLlm;

  const OutfitSuggestionModel({
    required this.top,
    required this.bottom,
    required this.shoes,
    required this.jacket,
    required this.umbrella,
    required this.sunscreen,
    required this.reason,
    required this.fromLlm,
  });

  factory OutfitSuggestionModel.fromJson(Map<String, dynamic> json) {
    final jacket = json['jacket']?.toString().trim();
    return OutfitSuggestionModel(
      top: json['top']?.toString() ?? '',
      bottom: json['bottom']?.toString() ?? '',
      shoes: json['shoes']?.toString() ?? '',
      jacket: (jacket == null || jacket.isEmpty) ? null : jacket,
      umbrella: json['umbrella'] == true,
      sunscreen: json['sunscreen'] == true,
      reason: json['reason']?.toString() ?? '',
      fromLlm: json['source'] == 'llm',
    );
  }
}
