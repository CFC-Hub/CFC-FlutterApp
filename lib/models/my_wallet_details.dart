import 'dart:convert';

import 'package:cfc/models/cfc_models.dart';

class MyWalletDetails {
  MyWalletDetails({
    required this.createdOn,
    required this.createdBy,
    required this.id,
    required this.name,
    required this.nftId,
    required this.accountAddress,
    required this.contractAddress,
    required this.signature,
    required this.deviceInfo,
  });

  final int createdOn;
  final String createdBy;
  final String id;
  final String name;
  final String nftId;
  final String accountAddress;
  final String contractAddress;
  final String signature;
  final DeviceInfo deviceInfo;

  MyWalletDetails copyWith({
    int? createdOn,
    String? createdBy,
    String? id,
    String? name,
    String? nftId,
    String? accountAddress,
    String? contractAddress,
    String? signature,
    DeviceInfo? deviceInfo,
  }) =>
      MyWalletDetails(
        createdOn: createdOn ?? this.createdOn,
        createdBy: createdBy ?? this.createdBy,
        id: id ?? this.id,
        name: name ?? this.name,
        nftId: nftId ?? this.nftId,
        accountAddress: accountAddress ?? this.accountAddress,
        contractAddress: contractAddress ?? this.contractAddress,
        signature: signature ?? this.signature,
        deviceInfo: deviceInfo ?? this.deviceInfo,
      );

  factory MyWalletDetails.fromJson(String str) => MyWalletDetails.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory MyWalletDetails.fromMap(Map<String, dynamic> json) => MyWalletDetails(
        createdOn: json["createdOn"],
        createdBy: json["createdBy"],
        id: json["id"],
        name: json["name"],
        nftId: json["nftId"],
        accountAddress: json["accountAddress"],
        contractAddress: json["contractAddress"],
        signature: json["signature"],
        deviceInfo: DeviceInfo.fromMap(json["deviceInfo"]),
      );

  Map<String, dynamic> toMap() => {
        "createdOn": createdOn,
        "createdBy": createdBy,
        "id": id,
        "name": name,
        "nftId": nftId,
        "accountAddress": accountAddress,
        "contractAddress": contractAddress,
        "signature": signature,
        "deviceInfo": deviceInfo.toMap(),
      };
}
