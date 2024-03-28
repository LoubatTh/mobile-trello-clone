class ShortCard {
  String id;
  String name;
  String desc;
  String idList;
  String idBoard;
  List<String>? idMembers = [];
  List<Member>? members = [];
  List<String>? idChecklists = [];
  List<Checklist>? checklists = [];
  Cover? cover;

  ShortCard({
    required this.id,
    required this.name,
    required this.desc,
    required this.idList,
    required this.idBoard,
    this.idMembers,
    this.members,
    this.idChecklists,
    this.checklists,
    this.cover, 
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
      idChecklists: List<String>.from(json['idChecklists']),
      checklists: json['checklists'] != null
          ? List<Checklist>.from(json['checklists'].map((x) => Checklist.fromJson(x)))
          : [],
      cover: json['cover'] != null ? Cover.fromJson(json['cover']) : null,
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
      'idChecklists': idChecklists,
      'checklists': checklists,
      'cover': cover?.toJson(), 
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

  void addChecklist(Checklist checklist) {
    checklists!.add(checklist);
  }

  Map<String, dynamic> getChecklist() {
    return {
      'checklists': checklists,
    };
  }
}

class Cover {
  String? color;
  String size;
  String brightness;

  Cover({
    this.color,
    required this.size,
    required this.brightness,
  });

  factory Cover.fromJson(Map<String, dynamic> json) {
    return Cover(
      color: json['color'],
      size: json['size'],
      brightness: json['brightness'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'color': color,
      'size': size,
      'brightness': brightness,
    };
  }
}

class Checklist {
  String id;
  String name;
  String idCard;
  List<Item> items;

  Checklist({
    required this.id,
    required this.name,
    required this.idCard,
    required this.items,
  });

  factory Checklist.fromJson(Map<String, dynamic> json) {
    return Checklist(
      id: json['id'],
      name: json['name'],
      idCard: json['idCard'],
      items: List<Item>.from(json['checkItems'].map((x) => Item.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'idCard': idCard,
      'items': items.map((item) => item.toJson()).toList(),
    };
  }

  int getItemsChecked() {
    return items.where((item) => item.state == 'complete').length;
  }
}

class Item {
  String id;
  String name;
  String idChecklist;
  String state;

  Item({
    required this.id,
    required this.name,
    required this.idChecklist,
    required this.state,
  });

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      id: json['id'],
      name: json['name'],
      idChecklist: json['idChecklist'],
      state: json['state'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'idChecklist': idChecklist,
      'state': state,
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
