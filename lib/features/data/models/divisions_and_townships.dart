class MyanmarData {
  final int id;
  final String name;
  final List<String> townships;

  MyanmarData({
    required this.id,
    required this.name,
    required this.townships,
  });

  factory MyanmarData.fromJson(Map<String, dynamic> json) {
    final List<dynamic> townshipList = json['townships'];
    final List<String> townships =
        townshipList.map((e) => e['name'] as String).toList();

    return MyanmarData(
      id: json['id'] as int,
      name: json['name'] as String,
      townships: townships,
    );
  }
}
