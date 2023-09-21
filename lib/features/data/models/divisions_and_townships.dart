class Township {
  final int id;
  final String name;

  Township({
    required this.id,
    required this.name,
  });

  factory Township.fromJson(Map<String, dynamic> json) {
    return Township(id: json['id'], name: json['name']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}

class MyanmarData {
  final int id;
  final String name;
  final List<Township> townships;

  MyanmarData({
    required this.id,
    required this.name,
    required this.townships,
  });

  // factory MyanmarData.fromJson(Map<String, dynamic> json) {
  //   final List<dynamic> townshipList = json['townships'];
  //   final List<String> townships =
  //       townshipList.map((e) => e['name'] as String).toList();

  factory MyanmarData.fromJson(Map<String, dynamic> json) {
    List<Township> townships = (json['townships'] as List? ?? [])
        .map((contact) => Township.fromJson(contact))
        .toList();

    return MyanmarData(
      id: json['id'],
      name: json['name'],
      townships: townships,
    );
  }
}
