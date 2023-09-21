class Picture {
  final int? id;
  final String? url;

  Picture({
    this.id,
    this.url,
  });

  factory Picture.fromJson(Map<String, dynamic> json) {
    return Picture(
      id: json['id'] != null ? json['id'] as int : null,
      url: json['url'] != null ? json['url'] as String : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'url': url,
    };
  }
}
