class Level {
  List<String> result;
  String imageName;

  Level(this.result, this.imageName);

  factory Level.fromJson(Map<String, dynamic> json) => Level(
      (json['result'] as List<dynamic>).map((e) => e.toString()).toList(),
      json['imageName'] as String);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['result'] = result;
    data['imageName'] = imageName;
    return data;
  }
}
