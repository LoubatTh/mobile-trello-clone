class ShortCard {
  String id;
  String name;
  String desc;
  String idList;
  String? listname;
  String idBoard;
  DateTime? startDate;
  DateTime? endDate;
  bool dueComplete;
  List<String>? idMembers = [];
  List<Member>? members = [];
  List<String>? idChecklists = [];
  List<Checklist>? checklists = [];
  List<String>? idLabels = [];
  List<Label>? labels = [];
  Cover? cover;

  ShortCard({
    required this.id,
    required this.name,
    required this.desc,
    required this.idList,
    this.listname,
    required this.idBoard,
    this.startDate,
    this.endDate,
    required this.dueComplete,
    this.idMembers,
    this.members,
    this.idChecklists,
    this.checklists,
    this.idLabels,
    this.labels,
    this.cover, 
  });

factory ShortCard.fromJson(Map<String, dynamic> json) {
  return ShortCard(
    id: json['id'],
    name: json['name'],
    desc: json['desc'],
    idList: json['idList'],
    listname: json['listname'],
    idBoard: json['idBoard'],
    idMembers: List<String>.from(json['idMembers']),
    members: json['members'] != null
        ? List<Member>.from(json['members'].map((x) => Member.fromJson(x)))
        : [],
    idChecklists: List<String>.from(json['idChecklists']),
    checklists: json['checklists'] != null
        ? List<Checklist>.from(json['checklists'].map((x) => Checklist.fromJson(x)))
        : [],
    idLabels: List<String>.from(json['idLabels']),
    labels: json['labels'] != null
        ? List<Label>.from(json['labels'].map((x) => Label.fromJson(x)))
        : [],
    cover: json['cover'] != null ? Cover.fromJson(json['cover']) : null,
    startDate: json['badges']['start'] != null ? DateTime.parse(json['badges']['start']) : null,
    endDate: json['badges']['due'] != null ? DateTime.parse(json['badges']['due']) : null,
    dueComplete: json['badges']['dueComplete'],
  );
}

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'desc': desc,
      'idList': idList,
      'listname': listname,
      'idBoard': idBoard,
      'idMembers': idMembers,
      'members': members,
      'startDate': startDate,
      'endDate': endDate,
      'idChecklists': idChecklists,
      'checklists': checklists,
      'idLabels': idLabels,
      'labels': labels,
      'cover': cover?.toJson(),
      'dueComplete': dueComplete,
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

  void setListName(String name) {
    listname = name;
  }
}

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