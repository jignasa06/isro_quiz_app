class Spacecraft {
  final String id;
  final String name;

  Spacecraft({required this.id, required this.name});

  factory Spacecraft.fromJson(Map<String, dynamic> json)
  {
    return Spacecraft(
      id: json['id'].toString(),
      name: json['name'] ?? '',
    );
  }

}