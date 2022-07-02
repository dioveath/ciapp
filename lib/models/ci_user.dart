import 'package:ciapp/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CIUser {
  String? doc_id; // doc_id == uid
  String? first_name;
  String? last_name;
  String? rank;
  String? address;
  String? profile_URL;

  int? phone_number;
  int? exp_points;
  int? level;
  int? hearts;
  int? profileVisits;

  DateTime? joinedAt;

  Map<String, dynamic>? roles;

  static final List<String> levelNames = [
    "Bronze",
    "Silver",
    "Gold",
    "Platinum",
    "Diamond",
    "God",
  ];

  static final List<int> levelPoints = [100, 300, 900, 2700, 8100];
  static final List<Color> levelColor = [
    Colors.blueGrey,
    Colors.grey,
    Colors.amber,
    kPrimaryAccentColor,
    kSecondaryColor,
    Colors.red,
  ];
  static final List<IconData> levelIcons = [
    FontAwesomeIcons.egg,
    FontAwesomeIcons.crow,
    FontAwesomeIcons.dove,
    FontAwesomeIcons.earlybirds,
    FontAwesomeIcons.featherAlt,
  ];

  static CIUser defaultUser = CIUser(
    doc_id: "NA",
    first_name: "Charicha",
    last_name: "Institute",
    rank: "Unranked",
    address: "Address",
    profile_URL:
        "https://scontent.fbir2-1.fna.fbcdn.net/v/t1.6435-9/186245676_328614285276080_2606505843490955899_n.png?_nc_cat=108&ccb=1-3&_nc_sid=09cbfe&_nc_ohc=3YWbXntm4qUAX_uf7Oa&_nc_ht=scontent.fbir2-1.fna&oh=59614bcfb8ccbcd3bc7ba4721cad4b5a&oe=60D4B9CA",
    phone_number: 9817388966,
    exp_points: 1,
    level: 1,
    hearts: 1,
    profileVisits: 1,
    joinedAt: DateTime.now(),
    roles: {
      "default": true,
    },
  );

  static CIUser get DefaultUser {
    return defaultUser;
  }

  CIUser({
    this.doc_id,
    this.first_name,
    this.last_name,
    this.rank,
    this.address,
    this.profile_URL,
    this.phone_number,
    this.exp_points,
    this.level,
    this.hearts,
    this.profileVisits,
    this.joinedAt,
    this.roles,
  });

  factory CIUser.fromFirestore(DocumentSnapshot doc) {
    if (doc == null) debugPrint("docsnap null");
    Map data = doc.data() as Map<dynamic, dynamic>;

    var expPoints = data['exp_points'] ?? 1;
    var calculatedLevel = 1;

    for (int i = 0; i < levelPoints.length; i++) {
      if (expPoints < levelPoints[i]) {
        calculatedLevel = i + 1;
        break;
      } else if (i >= levelPoints.length - 1) {
        // calculatedLevel =
        calculatedLevel = levelPoints.length;
      }
    }

    // debugPrint(data.toString());
    return CIUser(
      doc_id: doc.id,
      first_name: data['first_name'] ?? 'No First Name',
      last_name: data['last_name'] ?? 'No Last Name',
      rank: data['rank'] ?? 'Unranked',
      address: data['address'] ?? "Illuminati",
      profile_URL: data['profile_URL'] ?? "",
      phone_number: data['phone_number'] ?? 9817388966,
      exp_points: data['exp_points'] ?? 0,
      level:
          calculatedLevel, // we're calculating here, so we don't have to relai on database func
      hearts: data['hearts'] ?? 0,
      profileVisits: data['profileVisits'] ?? 0,
      joinedAt: DateTime.fromMicrosecondsSinceEpoch(
          data['joinedAt'].microsecondsSinceEpoch),
      roles: data['roles'] ?? {},
    );
  }

  Map<String, dynamic> toUpdatableFieldOnlyMap() {
    // NOTE: calculate level before sending
    return {
      "first_name": first_name,
      "last_name": last_name,
      // "rank" : rank,
      "address": address,
      "profile_URL": profile_URL,
      "phone_number": phone_number,
      "exp_points": exp_points,
      "level": level,
      "hearts": hearts,
      "profileVisits": profileVisits,
      // "joinedAt" : Timestamp.fromDate(joinedAt),
      // "roles" : roles,
    };
  }

  double getCurrentLevelCompletionPercent() {
    int minLevel = level! <= 1 ? 0 : CIUser.levelPoints[level! - 2];
    int maxLevel = level! < CIUser.levelPoints.length
        ? CIUser.levelPoints[level! - 1]
        : CIUser.levelPoints[CIUser.levelPoints.length - 1];
    int range = maxLevel - minLevel;
    int current = exp_points! - minLevel;
    return current / range;
  }
}
