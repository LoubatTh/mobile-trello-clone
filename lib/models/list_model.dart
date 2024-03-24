class ListModel {
  String? id;
  String name;
  bool? closed;
  // ignore: prefer_typing_uninitialized_variables
  var pos;
  String? softLimit;
  String? idBoard;

  ListModel({
    this.id,
    required this.name,
    this.closed,
    required this.pos,
    this.softLimit,
    this.idBoard,
  });

  factory ListModel.fromJson(Map<String, dynamic> json) {
    return ListModel(
      id: json['id'] as String,
      name: json['name'] as String,
      closed: json['closed'] as bool,
      pos: json['pos'],
      softLimit: json['softLimit'] as String,
      idBoard: json['idBoard'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'pos': pos,
    };
  }
}
