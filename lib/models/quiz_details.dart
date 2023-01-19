import 'dart:convert';

import 'package:cfc/models/cfc_models.dart';

class QuizDetails {
  QuizDetails({
    required this.createdBy,
    required this.answers,
    required this.id,
    required this.createdOn,
    required this.courseId,
    required this.deviceInfo,
  });

  final String createdBy;
  final Answers answers;
  final String id;
  final int createdOn;
  final String courseId;
  final DeviceInfo deviceInfo;

  QuizDetails copyWith({
    String? createdBy,
    Answers? answers,
    String? id,
    int? createdOn,
    String? courseId,
    DeviceInfo? deviceInfo,
  }) =>
      QuizDetails(
        createdBy: createdBy ?? this.createdBy,
        answers: answers ?? this.answers,
        id: id ?? this.id,
        createdOn: createdOn ?? this.createdOn,
        courseId: courseId ?? this.courseId,
        deviceInfo: deviceInfo ?? this.deviceInfo,
      );

  factory QuizDetails.fromJson(String str) => QuizDetails.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory QuizDetails.fromMap(Map<String, dynamic> json) => QuizDetails(
        createdBy: json["createdBy"],
        answers: Answers.fromMap(json["answers"]),
        id: json["id"],
        createdOn: json["createdOn"],
        courseId: json["courseId"],
        deviceInfo: DeviceInfo.fromMap(json["deviceInfo"]),
      );

  Map<String, dynamic> toMap() => {
        "createdBy": createdBy,
        "answers": answers.toMap(),
        "id": id,
        "createdOn": createdOn,
        "courseId": courseId,
        "deviceInfo": deviceInfo.toMap(),
      };
}

class Answers {
  Answers({
    required this.questionOne,
    required this.questionFour,
    required this.questionThree,
    required this.questionTwo,
  });

  final String questionOne;
  final String questionFour;
  final String questionThree;
  final String questionTwo;

  Answers copyWith({
    String? questionOne,
    String? questionFour,
    String? questionThree,
    String? questionTwo,
  }) =>
      Answers(
        questionOne: questionOne ?? this.questionOne,
        questionFour: questionFour ?? this.questionFour,
        questionThree: questionThree ?? this.questionThree,
        questionTwo: questionTwo ?? this.questionTwo,
      );

  factory Answers.fromJson(String str) => Answers.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Answers.fromMap(Map<String, dynamic> json) => Answers(
        questionOne: json["questionOne"],
        questionFour: json["questionFour"],
        questionThree: json["questionThree"],
        questionTwo: json["questionTwo"],
      );

  Map<String, dynamic> toMap() => {
        "questionOne": questionOne,
        "questionFour": questionFour,
        "questionThree": questionThree,
        "questionTwo": questionTwo,
      };
}
