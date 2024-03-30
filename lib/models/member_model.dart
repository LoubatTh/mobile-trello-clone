class MemberModel {
  String? id;
  String? avatarUrl;
  String fullName;
  String? username;
  List<dynamic>? idOrganizations;
  List<dynamic>? idBoards;

  MemberModel({
    this.id,
    this.avatarUrl,
    required this.fullName,
    this.username,
    this.idOrganizations,
    this.idBoards,
  });

  factory MemberModel.fromJson(Map<String, dynamic> json) {
    return MemberModel(
      id: json['id'],
      avatarUrl: json['avatarUrl'],
      fullName: json['fullName'],
      username: json['username'],
      idOrganizations: json['idOrganizations'],
      idBoards: json['idBoards'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'fullname': fullName,
    };
  }
}
