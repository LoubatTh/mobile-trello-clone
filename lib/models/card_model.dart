class ShortCard {
  String id;
  String name;
  String idList;
  String idBoard;

  ShortCard({
    required this.id,
    required this.name,
    required this.idList,
    required this.idBoard,
  });

  factory ShortCard.fromJson(Map<String, dynamic> json) {
    return ShortCard(
      id: json['id'],
      name: json['name'],
      idList: json['idList'],
      idBoard: json['idBoard'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'idList': idList,
      'idBoard': idBoard,
    };
  }
}
