enum Gender { male, female }

enum ColdSensitivity { low, normal, high }

enum OutfitStyle { casual, formal, sporty }

/// What the AI service needs to know about the person to dress them.
/// Ranges match the backend validation (422 outside them).
class UserProfileModel {
  /// 1..120
  final int age;
  final Gender gender;

  /// 50..250
  final int heightCm;

  /// 10..300
  final int weightKg;
  final ColdSensitivity coldSensitivity;
  final OutfitStyle style;

  const UserProfileModel({
    required this.age,
    required this.gender,
    required this.heightCm,
    required this.weightKg,
    this.coldSensitivity = ColdSensitivity.normal,
    this.style = OutfitStyle.casual,
  });

  /// Used until the person fills in their own profile.
  static const defaults = UserProfileModel(
    age: 30,
    gender: Gender.male,
    heightCm: 170,
    weightKg: 70,
  );

  factory UserProfileModel.fromJson(Map<String, dynamic> json) {
    return UserProfileModel(
      age: (json['age'] as num?)?.toInt() ?? defaults.age,
      gender: _enum(Gender.values, json['gender'], defaults.gender),
      heightCm: (json['height_cm'] as num?)?.toInt() ?? defaults.heightCm,
      weightKg: (json['weight_kg'] as num?)?.toInt() ?? defaults.weightKg,
      coldSensitivity: _enum(
        ColdSensitivity.values,
        json['cold_sensitivity'],
        ColdSensitivity.normal,
      ),
      style: _enum(OutfitStyle.values, json['style'], OutfitStyle.casual),
    );
  }

  Map<String, dynamic> toJson() => {
    'age': age,
    'gender': gender.name,
    'height_cm': heightCm,
    'weight_kg': weightKg,
    'cold_sensitivity': coldSensitivity.name,
    'style': style.name,
  };

  UserProfileModel copyWith({
    int? age,
    Gender? gender,
    int? heightCm,
    int? weightKg,
    ColdSensitivity? coldSensitivity,
    OutfitStyle? style,
  }) {
    return UserProfileModel(
      age: age ?? this.age,
      gender: gender ?? this.gender,
      heightCm: heightCm ?? this.heightCm,
      weightKg: weightKg ?? this.weightKg,
      coldSensitivity: coldSensitivity ?? this.coldSensitivity,
      style: style ?? this.style,
    );
  }
}

T _enum<T extends Enum>(List<T> values, dynamic name, T fallback) =>
    values.firstWhere((e) => e.name == name, orElse: () => fallback);
