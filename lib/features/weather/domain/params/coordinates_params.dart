class CoordinatesParams {
  final double lat;
  final double lon;

  /// OpenWeather response language (descriptions, city names).
  final String lang;

  const CoordinatesParams({
    required this.lat,
    required this.lon,
    required this.lang,
  });

  Map<String, dynamic> toJson() => {'lat': lat, 'lon': lon, 'lang': lang};
}
