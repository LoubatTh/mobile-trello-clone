class ShortCard {
  String id;
  String name;
  String desc;
  String idList;
  String idBoard;
  List<String>? idMembers = [];
  List<Member>? members = [];
  List<String> checklists = [];

  ShortCard({
    required this.id,
    required this.name,
    required this.desc,
    required this.idList,
    required this.idBoard,
    this.idMembers,
    this.members,
    required this.checklists,
  });

  factory ShortCard.fromJson(Map<String, dynamic> json) {
    return ShortCard(
      id: json['id'],
      name: json['name'],
      desc: json['desc'],
      idList: json['idList'],
      idBoard: json['idBoard'],
      idMembers: List<String>.from(json['idMembers']),
      members: json['members'] != null
          ? List<Member>.from(json['members'].map((x) => Member.fromJson(x)))
          : [],
      checklists: List<String>.from(json['idChecklists']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'desc': desc,
      'idList': idList,
      'idBoard': idBoard,
      'idMembers': idMembers,
      'members': members,
      'checklists': checklists,
    };
  }

  void addMember(Member member) {
    members!.add(member);
  }

  Map<String, dynamic> getMember() {
    return {
      'members': members,
    };
  }
}

class Member {
  String id;
  String fullName;
  String avatarUrl;

  Member({
    required this.id,
    required this.fullName,
    required this.avatarUrl,
  });

  factory Member.fromJson(Map<String, dynamic> json) {
    return Member(
      id: json['id'],
      fullName: json['fullName'],
      avatarUrl: json['avatarUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fullName': fullName,
      'avatarUrl': avatarUrl,
    };
  }
}

class Card {
  String id;
  String name;
  String idList;
  String idBoard;
  String desc;
  String? due;
  String? dueComplete;
  String? url;
  String? shortUrl;
  String? idAttachmentCover;
  List<String>? idMembers;
  List<String>? idLabels;
  // List<dynamic>? idChecklists;
  // List<dynamic>? idMembersVoted;
  // List<dynamic>? idShort;
  // List<dynamic>? attachments;

  Card({
    required this.id,
    required this.name,
    required this.idList,
    required this.idBoard,
    required this.desc,
    required this.due,
    required this.dueComplete,
    required this.url,
    required this.shortUrl,
    required this.idAttachmentCover,
    required this.idMembers,
    required this.idLabels,
    // required this.idChecklists,
    // required this.idMembersVoted,
    // required this.idShort,
    // required this.attachments,
  });

  factory Card.fromJson(Map<String, dynamic> json) {
    return Card(
      id: json['id'],
      name: json['name'],
      idList: json['idList'],
      idBoard: json['idBoard'],
      desc: json['desc'],
      due: json['due'],
      dueComplete: json['dueComplete'],
      url: json['url'],
      shortUrl: json['shortUrl'],
      idAttachmentCover: json['idAttachmentCover'],
      idMembers: List<String>.from(json['idMembers']),
      idLabels: List<String>.from(json['idLabels']),
      // idChecklists: List<dynamic>.from(json['idChecklists']),
      // idMembersVoted: List<dynamic>.from(json['idMembersVoted']),
      // idShort: List<dynamic>.from(json['idShort']),
      // attachments: List<dynamic>.from(json['attachments']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'idList': idList,
      'idBoard': idBoard,
      'desc': desc,
      'due': due,
      'dueComplete': dueComplete,
      'url': url,
      'shortUrl': shortUrl,
      'idAttachmentCover': idAttachmentCover,
      'idMembers': idMembers,
      'idLabels': idLabels,
      // 'idChecklists': idChecklists,
      // 'idMembersVoted': idMembersVoted,
      // 'idShort': idShort,
      // 'attachments': attachments,
    };
  }
}
