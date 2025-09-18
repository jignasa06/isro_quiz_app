class Launcher {
  final String id;
  final String name;

  Launcher({required this.id, required this.name});

  factory Launcher.fromJson(Map<String, dynamic> json) {
    return Launcher(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
    );
  }
}
