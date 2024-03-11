class WorkspaceModel {
  String id;
  String displayName;
  String desc;
  String name;
  String website;

  WorkspaceModel({
    required this.id,
    required this.displayName,
    required this.desc,
    required this.name,
    required this.website,
  });

  // Convert a Map (or JSON) into a WorkspaceModel instance
  factory WorkspaceModel.fromJson(Map<String, dynamic> json) {
    return WorkspaceModel(
      id: json['id'],
      displayName: json['displayName'],
      desc: json['desc'],
      name: json['name'],
      website: json['website'],
    );
  }

  // Convert the WorkspaceModel instance into a Map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'displayName': displayName,
      'desc': desc,
      'name': name,
      'website': website,
    };
  }
}
