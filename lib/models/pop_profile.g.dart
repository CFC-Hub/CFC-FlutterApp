// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pop_profile.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PopProfileAdapter extends TypeAdapter<PopProfile> {
  @override
  final int typeId = 1;

  @override
  PopProfile read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PopProfile(
      createdOn: fields[0] as int,
      createdBy: fields[1] as String,
      firstName: fields[2] as String,
      lastName: fields[3] as String,
      emailAddress: fields[4] as String,
      isPopProfileCreated: fields[5] as bool,
      organisation: fields[6] as String,
      questions: fields[7] as Questions,
      tagline: fields[8] as String,
      aboutCfcProject: fields[9] as String,
      deviceInfo: fields[10] as DeviceInfo,
      isVerifiedOnChain: fields[11] as bool,
      metamaskAccountAddress: fields[12] as String,
      modifiedOn: fields[13] as int,
    );
  }

  @override
  void write(BinaryWriter writer, PopProfile obj) {
    writer
      ..writeByte(14)
      ..writeByte(0)
      ..write(obj.createdOn)
      ..writeByte(1)
      ..write(obj.createdBy)
      ..writeByte(2)
      ..write(obj.firstName)
      ..writeByte(3)
      ..write(obj.lastName)
      ..writeByte(4)
      ..write(obj.emailAddress)
      ..writeByte(5)
      ..write(obj.isPopProfileCreated)
      ..writeByte(6)
      ..write(obj.organisation)
      ..writeByte(7)
      ..write(obj.questions)
      ..writeByte(8)
      ..write(obj.tagline)
      ..writeByte(9)
      ..write(obj.aboutCfcProject)
      ..writeByte(10)
      ..write(obj.deviceInfo)
      ..writeByte(11)
      ..write(obj.isVerifiedOnChain)
      ..writeByte(12)
      ..write(obj.metamaskAccountAddress)
      ..writeByte(13)
      ..write(obj.modifiedOn);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PopProfileAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class DeviceInfoAdapter extends TypeAdapter<DeviceInfo> {
  @override
  final int typeId = 2;

  @override
  DeviceInfo read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DeviceInfo(
      platform: fields[0] as String,
      version: fields[1] as String,
      deviceName: fields[2] as String,
      isPhysicalDevice: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, DeviceInfo obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.platform)
      ..writeByte(1)
      ..write(obj.version)
      ..writeByte(2)
      ..write(obj.deviceName)
      ..writeByte(3)
      ..write(obj.isPhysicalDevice);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DeviceInfoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class QuestionsAdapter extends TypeAdapter<Questions> {
  @override
  final int typeId = 3;

  @override
  Questions read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Questions(
      isFoodProducer: fields[0] as bool,
      inLogistics: fields[1] as bool,
      inPublicAdministration: fields[2] as bool,
      inAgriFoodResearch: fields[3] as bool,
      inTechnologyAgriFood: fields[4] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, Questions obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.isFoodProducer)
      ..writeByte(1)
      ..write(obj.inLogistics)
      ..writeByte(2)
      ..write(obj.inPublicAdministration)
      ..writeByte(3)
      ..write(obj.inAgriFoodResearch)
      ..writeByte(4)
      ..write(obj.inTechnologyAgriFood);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is QuestionsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
