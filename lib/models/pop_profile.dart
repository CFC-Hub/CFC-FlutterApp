import 'dart:convert';

import 'package:hive/hive.dart';

part 'pop_profile.g.dart';

@HiveType(typeId: 1)
class PopProfile {
  PopProfile({
    required this.createdOn,
    required this.createdBy,
    required this.firstName,
    required this.lastName,
    required this.emailAddress,
    required this.isPopProfileCreated,
    required this.organisation,
    required this.questions,
    required this.tagline,
    required this.aboutCfcProject,
    required this.deviceInfo,
    required this.isVerifiedOnChain,
    required this.metamaskAccountAddress,
    required this.modifiedOn,
  });

  @HiveField(0)
  final int createdOn;
  @HiveField(1)
  final String createdBy;
  @HiveField(2)
  final String firstName;
  @HiveField(3)
  final String lastName;
  @HiveField(4)
  final String emailAddress;
  @HiveField(5)
  final bool isPopProfileCreated;
  @HiveField(6)
  final String organisation;
  @HiveField(7)
  final Questions questions;
  @HiveField(8)
  final String tagline;
  @HiveField(9)
  final String aboutCfcProject;
  @HiveField(10)
  final DeviceInfo deviceInfo;
  @HiveField(11)
  final bool isVerifiedOnChain;
  @HiveField(12)
  final String metamaskAccountAddress;
  @HiveField(13)
  final int modifiedOn;

  PopProfile copyWith({
    int? createdOn,
    String? createdBy,
    String? firstName,
    String? lastName,
    String? emailAddress,
    bool? isPopProfileCreated,
    String? organisation,
    Questions? questions,
    String? tagline,
    String? aboutCfcProject,
    DeviceInfo? deviceInfo,
    bool? isVerifiedOnChain,
    String? metamaskAccountAddress,
    int? modifiedOn,
  }) =>
      PopProfile(
        createdOn: createdOn ?? this.createdOn,
        createdBy: createdBy ?? this.createdBy,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        emailAddress: emailAddress ?? this.emailAddress,
        isPopProfileCreated: isPopProfileCreated ?? this.isPopProfileCreated,
        organisation: organisation ?? this.organisation,
        questions: questions ?? this.questions,
        tagline: tagline ?? this.tagline,
        aboutCfcProject: aboutCfcProject ?? this.aboutCfcProject,
        deviceInfo: deviceInfo ?? this.deviceInfo,
        isVerifiedOnChain: isVerifiedOnChain ?? this.isVerifiedOnChain,
        metamaskAccountAddress: metamaskAccountAddress ?? this.metamaskAccountAddress,
        modifiedOn: modifiedOn ?? this.modifiedOn,
      );

  factory PopProfile.fromJson(String str) => PopProfile.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PopProfile.fromMap(Map<String, dynamic> json) => PopProfile(
        createdOn: json["createdOn"],
        createdBy: json["createdBy"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        emailAddress: json["emailAddress"],
        isPopProfileCreated: json["isPopProfileCreated"],
        organisation: json["organisation"],
        questions: Questions.fromMap(json["questions"]),
        tagline: json["tagline"],
        aboutCfcProject: json["aboutCFCProject"],
        deviceInfo: DeviceInfo.fromMap(json["deviceInfo"]),
        isVerifiedOnChain: json["isVerifiedOnChain"],
        metamaskAccountAddress: json["metamaskAccountAddress"],
        modifiedOn: json["modifiedOn"],
      );

  Map<String, dynamic> toMap() => {
        "createdOn": createdOn,
        "createdBy": createdBy,
        "firstName": firstName,
        "lastName": lastName,
        "emailAddress": emailAddress,
        "isPopProfileCreated": isPopProfileCreated,
        "organisation": organisation,
        "questions": questions.toMap(),
        "tagline": tagline,
        "aboutCFCProject": aboutCfcProject,
        "deviceInfo": deviceInfo.toMap(),
        "isVerifiedOnChain": isVerifiedOnChain,
        "metamaskAccountAddress": metamaskAccountAddress,
        "modifiedOn": modifiedOn,
      };

  factory PopProfile.emptyValues() {
    return PopProfile(
      createdOn: 0,
      createdBy: '',
      firstName: '',
      lastName: '',
      emailAddress: '',
      isPopProfileCreated: false,
      organisation: '',
      questions: Questions(
        isFoodProducer: false,
        inLogistics: false,
        inPublicAdministration: false,
        inAgriFoodResearch: false,
        inTechnologyAgriFood: false,
      ),
      tagline: '',
      aboutCfcProject: '',
      deviceInfo: DeviceInfo(
        platform: '',
        version: '',
        deviceName: '',
        isPhysicalDevice: '',
      ),
      isVerifiedOnChain: false,
      metamaskAccountAddress: '',
      modifiedOn: 0,
    );
  }
}

@HiveType(typeId: 2)
class DeviceInfo {
  DeviceInfo({
    required this.platform,
    required this.version,
    required this.deviceName,
    required this.isPhysicalDevice,
  });

  @HiveField(0)
  final String platform;
  @HiveField(1)
  final String version;
  @HiveField(2)
  final String deviceName;
  @HiveField(3)
  final String isPhysicalDevice;

  DeviceInfo copyWith({
    String? platform,
    String? version,
    String? deviceName,
    String? isPhysicalDevice,
  }) =>
      DeviceInfo(
        platform: platform ?? this.platform,
        version: version ?? this.version,
        deviceName: deviceName ?? this.deviceName,
        isPhysicalDevice: isPhysicalDevice ?? this.isPhysicalDevice,
      );

  factory DeviceInfo.fromJson(String str) => DeviceInfo.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory DeviceInfo.fromMap(Map<String, dynamic> json) => DeviceInfo(
        platform: json["platform"],
        version: json["version"],
        deviceName: json["deviceName"],
        isPhysicalDevice: json["isPhysicalDevice"],
      );

  Map<String, dynamic> toMap() => {
        "platform": platform,
        "version": version,
        "deviceName": deviceName,
        "isPhysicalDevice": isPhysicalDevice,
      };
}

@HiveType(typeId: 3)
class Questions {
  Questions({
    required this.isFoodProducer,
    required this.inLogistics,
    required this.inPublicAdministration,
    required this.inAgriFoodResearch,
    required this.inTechnologyAgriFood,
  });

  @HiveField(0)
  final bool isFoodProducer;
  @HiveField(1)
  final bool inLogistics;
  @HiveField(2)
  final bool inPublicAdministration;
  @HiveField(3)
  final bool inAgriFoodResearch;
  @HiveField(4)
  final bool inTechnologyAgriFood;

  Questions copyWith({
    bool? isFoodProducer,
    bool? inLogistics,
    bool? inPublicAdministration,
    bool? inAgriFoodResearch,
    bool? inTechnologyAgriFood,
  }) =>
      Questions(
        isFoodProducer: isFoodProducer ?? this.isFoodProducer,
        inLogistics: inLogistics ?? this.inLogistics,
        inPublicAdministration: inPublicAdministration ?? this.inPublicAdministration,
        inAgriFoodResearch: inAgriFoodResearch ?? this.inAgriFoodResearch,
        inTechnologyAgriFood: inTechnologyAgriFood ?? this.inTechnologyAgriFood,
      );

  factory Questions.fromJson(String str) => Questions.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Questions.fromMap(Map<String, dynamic> json) => Questions(
        isFoodProducer: json["isFoodProducer"],
        inLogistics: json["inLogistics"],
        inPublicAdministration: json["inPublicAdministration"],
        inAgriFoodResearch: json["inAgriFoodResearch"],
        inTechnologyAgriFood: json["inTechnologyAgriFood"],
      );

  Map<String, dynamic> toMap() => {
        "isFoodProducer": isFoodProducer,
        "inLogistics": inLogistics,
        "inPublicAdministration": inPublicAdministration,
        "inAgriFoodResearch": inAgriFoodResearch,
        "inTechnologyAgriFood": inTechnologyAgriFood,
      };
}
