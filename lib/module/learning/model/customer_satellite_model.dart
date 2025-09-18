class CustomerSatellite {
  final String id;
  final String country;
  final String launchDate;
  final String mass;
  final String launcher;

  CustomerSatellite({
    required this.id,
    required this.country,
    required this.launchDate,
    required this.mass,
    required this.launcher,
  });

  factory CustomerSatellite.fromJson(Map<String, dynamic> json) {
    return CustomerSatellite(
      id: json['id'] ?? '',
      country: json['country'] ?? '',
      launchDate: json['launch_date'] ?? '',
      mass: json['mass'] ?? '',
      launcher: json['launcher'] ?? '',
    );
  }
}
