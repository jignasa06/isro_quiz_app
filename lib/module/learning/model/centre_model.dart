class Centre {
  final int id;
  final String name;
  final String place;
  final String state;

  Centre({
    required this.id,
    required this.name,
    required this.place,
    required this.state,
  });

  factory Centre.fromJson(Map<String, dynamic> json) {
    return Centre(
      id: json['id'],
      name: json['name'],
      place: json['Place'],
      state: json['State'],
    );
  }
}
