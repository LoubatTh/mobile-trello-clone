class Member {
  String id;
  String avatarUrl;
  String username;
  List<dynamic>? idOrganizations;
  List<dynamic>? idBoards;

  Member({
    required this.id,
    required this.avatarUrl,
    required this.username,
    required this.idOrganizations,
    required this.idBoards,
  });

  factory Member.fromJson(Map<String, dynamic> json) {
    return Member(
      id: json['id'],
      avatarUrl: json['avatarUrl'],
      username: json['username'],
      idOrganizations: json['idOrganizations'],
      idBoards: json['idBoards'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'avatarUrl': avatarUrl,
      'username': username,
      'idOrganizations': idOrganizations,
      'idBoards': idBoards,
    };
  }
}
