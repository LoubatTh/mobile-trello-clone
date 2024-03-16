class WorkspaceModel {
  String? id;
  String displayName;
  String desc;
  List<String>? idBoards;
  String? idMemberCreator;

  // Constructor for general use, makes most fields required.
  WorkspaceModel({
    this.id,
    required this.displayName,
    required this.desc,
    this.idBoards,
    this.idMemberCreator,
  });

  // Factory method for creation - expects only displayName, name, and desc.
  factory WorkspaceModel.forCreation(
      {required String displayName, required String desc}) {
    return WorkspaceModel(
      displayName: displayName,
      desc: desc,
    );
  }

  // Factory method for retrieving a workspace - expects all fields.
  factory WorkspaceModel.fromJson(Map<String, dynamic> json) {
    // Ensure 'idBoards' is properly cast to List<String>
    List<String> idBoards = [];
    if (json['idBoards'] != null) {
      idBoards = List<String>.from(json['idBoards']);
    }

    return WorkspaceModel(
      id: json['id'] as String?,
      displayName: json['displayName'] as String,
      desc: json['desc'] as String,
      idBoards: idBoards,
      idMemberCreator: json['idMemberCreator'] as String?,
    );
  }

  // Convert the WorkspaceModel instance into a Map. Adjust as needed for API.
  Map<String, dynamic> toJson() {
    return {
      'displayName': displayName,
      'desc': desc,
    };
  }
}
