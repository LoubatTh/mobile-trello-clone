class Label {
  String id;
  String name;
  String color;

  Label({
    required this.id,
    required this.name,
    required this.color,
  });

  factory Label.fromJson(Map<String, dynamic> json) {
    return Label(
      id: json['id'],
      name: json['name'],
      color: json['color'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'color': color,
    };
  }
}
