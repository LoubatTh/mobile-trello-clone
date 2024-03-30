class ShortBoardModel {
  String? id;
  String name;
  String? idOrganization;
  String? desc;

  ShortBoardModel({
    this.id,
    required this.name,
    this.idOrganization,
    this.desc,
  });

  factory ShortBoardModel.fromJson(Map<String, dynamic> json) {
    return ShortBoardModel(
      id: json['id'],
      name: json['name'],
      idOrganization: json['idOrganization'],
      desc: json['desc'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'idOrganization': idOrganization,
      'desc': desc != null ? '' : desc,
    };
  }
}

class BoardModel {
  String id;
  String name;
  String desc;
  String descData;
  bool closed;
  String idMemberCreator;
  String idOrganization;
  bool pinned;
  String url;
  String shortUrl;
  Prefs prefs;
  Map<String, String> labelNames;
  Limits limits;
  bool starred;
  String memberships;
  String shortLink;
  bool subscribed;
  String powerUps;
  String dateLastActivity;
  String dateLastView;
  String idTags;
  String datePluginDisable;
  String creationMethod;
  int ixUpdate;
  String templateGallery;
  bool enterpriseOwned;

  BoardModel({
    required this.id,
    required this.name,
    required this.desc,
    required this.descData,
    required this.closed,
    required this.idMemberCreator,
    required this.idOrganization,
    required this.pinned,
    required this.url,
    required this.shortUrl,
    required this.prefs,
    required this.labelNames,
    required this.limits,
    required this.starred,
    required this.memberships,
    required this.shortLink,
    required this.subscribed,
    required this.powerUps,
    required this.dateLastActivity,
    required this.dateLastView,
    required this.idTags,
    required this.datePluginDisable,
    required this.creationMethod,
    required this.ixUpdate,
    required this.templateGallery,
    required this.enterpriseOwned,
  });

  factory BoardModel.fromJson(Map<String, dynamic> json) {
    return BoardModel(
      id: json['id'],
      name: json['name'],
      desc: json['desc'],
      descData: json['descData'],
      closed: json['closed'],
      idMemberCreator: json['idMemberCreator'],
      idOrganization: json['idOrganization'],
      pinned: json['pinned'],
      url: json['url'],
      shortUrl: json['shortUrl'],
      prefs: Prefs.fromJson(json['prefs']),
      labelNames: Map<String, String>.from(json['labelNames']),
      limits: Limits.fromJson(json['limits']),
      starred: json['starred'],
      memberships: json['memberships'],
      shortLink: json['shortLink'],
      subscribed: json['subscribed'],
      powerUps: json['powerUps'],
      dateLastActivity: json['dateLastActivity'],
      dateLastView: json['dateLastView'],
      idTags: json['idTags'],
      datePluginDisable: json['datePluginDisable'],
      creationMethod: json['creationMethod'],
      ixUpdate: json['ixUpdate'],
      templateGallery: json['templateGallery'],
      enterpriseOwned: json['enterpriseOwned'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'desc': desc,
      'descData': descData,
      'closed': closed,
      'idMemberCreator': idMemberCreator,
      'idOrganization': idOrganization,
      'pinned': pinned,
      'url': url,
      'shortUrl': shortUrl,
      'prefs': prefs.toJson(),
      'labelNames': labelNames,
      'limits': limits.toJson(),
      'starred': starred,
      'memberships': memberships,
      'shortLink': shortLink,
      'subscribed': subscribed,
      'powerUps': powerUps,
      'dateLastActivity': dateLastActivity,
      'dateLastView': dateLastView,
      'idTags': idTags,
      'datePluginDisable': datePluginDisable,
      'creationMethod': creationMethod,
      'ixUpdate': ixUpdate,
      'templateGallery': templateGallery,
      'enterpriseOwned': enterpriseOwned,
    };
  }
}

class Prefs {
  String permissionLevel;
  bool hideVotes;
  String voting;
  String comments;
  bool selfJoin;
  bool cardCovers;
  bool isTemplate;
  String cardAging;
  bool calendarFeedEnabled;
  String background;
  String backgroundImage;
  List<BackgroundImageScaled> backgroundImageScaled;
  bool backgroundTile;
  String backgroundBrightness;
  String backgroundBottomColor;
  String backgroundTopColor;
  bool canBePublic;
  bool canBeEnterprise;
  bool canBeOrg;
  bool canBePrivate;
  bool canInvite;

  Prefs({
    required this.permissionLevel,
    required this.hideVotes,
    required this.voting,
    required this.comments,
    required this.selfJoin,
    required this.cardCovers,
    required this.isTemplate,
    required this.cardAging,
    required this.calendarFeedEnabled,
    required this.background,
    required this.backgroundImage,
    required this.backgroundImageScaled,
    required this.backgroundTile,
    required this.backgroundBrightness,
    required this.backgroundBottomColor,
    required this.backgroundTopColor,
    required this.canBePublic,
    required this.canBeEnterprise,
    required this.canBeOrg,
    required this.canBePrivate,
    required this.canInvite,
  });

  factory Prefs.fromJson(Map<String, dynamic> json) {
    return Prefs(
      permissionLevel: json['permissionLevel'],
      hideVotes: json['hideVotes'],
      voting: json['voting'],
      comments: json['comments'],
      selfJoin: json['selfJoin'],
      cardCovers: json['cardCovers'],
      isTemplate: json['isTemplate'],
      cardAging: json['cardAging'],
      calendarFeedEnabled: json['calendarFeedEnabled'],
      background: json['background'],
      backgroundImage: json['backgroundImage'],
      backgroundImageScaled: (json['backgroundImageScaled'] as List)
          .map((item) => BackgroundImageScaled.fromJson(item))
          .toList(),
      backgroundTile: json['backgroundTile'],
      backgroundBrightness: json['backgroundBrightness'],
      backgroundBottomColor: json['backgroundBottomColor'],
      backgroundTopColor: json['backgroundTopColor'],
      canBePublic: json['canBePublic'],
      canBeEnterprise: json['canBeEnterprise'],
      canBeOrg: json['canBeOrg'],
      canBePrivate: json['canBePrivate'],
      canInvite: json['canInvite'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'permissionLevel': permissionLevel,
      'hideVotes': hideVotes,
      'voting': voting,
      'comments': comments,
      'selfJoin': selfJoin,
      'cardCovers': cardCovers,
      'isTemplate': isTemplate,
      'cardAging': cardAging,
      'calendarFeedEnabled': calendarFeedEnabled,
      'background': background,
      'backgroundImage': backgroundImage,
      'backgroundImageScaled':
          backgroundImageScaled.map((e) => e.toJson()).toList(),
      'backgroundTile': backgroundTile,
      'backgroundBrightness': backgroundBrightness,
      'backgroundBottomColor': backgroundBottomColor,
      'backgroundTopColor': backgroundTopColor,
      'canBePublic': canBePublic,
      'canBeEnterprise': canBeEnterprise,
      'canBeOrg': canBeOrg,
      'canBePrivate': canBePrivate,
      'canInvite': canInvite,
    };
  }
}

class BackgroundImageScaled {
  int width;
  int height;
  String url;

  BackgroundImageScaled({
    required this.width,
    required this.height,
    required this.url,
  });

  factory BackgroundImageScaled.fromJson(Map<String, dynamic> json) {
    return BackgroundImageScaled(
      width: json['width'],
      height: json['height'],
      url: json['url'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'width': width,
      'height': height,
      'url': url,
    };
  }
}

class Limits {
  Attachments attachments;

  Limits({required this.attachments});

  factory Limits.fromJson(Map<String, dynamic> json) {
    return Limits(
      attachments: Attachments.fromJson(json['attachments']['perBoard']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'attachments': attachments.toJson(),
    };
  }
}

class Attachments {
  String status;
  int disableAt;
  int warnAt;

  Attachments({
    required this.status,
    required this.disableAt,
    required this.warnAt,
  });

  factory Attachments.fromJson(Map<String, dynamic> json) {
    return Attachments(
      status: json['status'],
      disableAt: json['disableAt'],
      warnAt: json['warnAt'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'disableAt': disableAt,
      'warnAt': warnAt,
    };
  }
}
