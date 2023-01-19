import 'dart:convert';

import 'package:cfc/models/cfc_models.dart';

class FeedbackDetails {
  FeedbackDetails({
    required this.feedback,
    required this.createdBy,
    required this.id,
    required this.createdOn,
    required this.courseId,
    required this.deviceInfo,
  });

  final FeedbackAnswer feedback;
  final String createdBy;
  final String id;
  final int createdOn;
  final String courseId;
  final DeviceInfo deviceInfo;

  FeedbackDetails copyWith({
    FeedbackAnswer? feedback,
    String? createdBy,
    String? id,
    int? createdOn,
    String? courseId,
    DeviceInfo? deviceInfo,
  }) =>
      FeedbackDetails(
        feedback: feedback ?? this.feedback,
        createdBy: createdBy ?? this.createdBy,
        id: id ?? this.id,
        createdOn: createdOn ?? this.createdOn,
        courseId: courseId ?? this.courseId,
        deviceInfo: deviceInfo ?? this.deviceInfo,
      );

  factory FeedbackDetails.fromJson(String str) => FeedbackDetails.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory FeedbackDetails.fromMap(Map<String, dynamic> json) => FeedbackDetails(
        feedback: FeedbackAnswer.fromMap(json["feedback"]),
        createdBy: json["createdBy"],
        id: json["id"],
        createdOn: json["createdOn"],
        courseId: json["courseId"],
        deviceInfo: DeviceInfo.fromMap(json["deviceInfo"]),
      );

  Map<String, dynamic> toMap() => {
        "feedback": feedback.toMap(),
        "createdBy": createdBy,
        "id": id,
        "createdOn": createdOn,
        "courseId": courseId,
        "deviceInfo": deviceInfo.toMap(),
      };
}

class FeedbackAnswer {
  FeedbackAnswer({
    required this.questionOne,
    required this.questionFour,
    required this.questionThree,
    required this.questionTwo,
  });

  final int questionOne;
  final Question questionFour;
  final Question questionThree;
  final Question questionTwo;

  FeedbackAnswer copyWith({
    int? questionOne,
    Question? questionFour,
    Question? questionThree,
    Question? questionTwo,
  }) =>
      FeedbackAnswer(
        questionOne: questionOne ?? this.questionOne,
        questionFour: questionFour ?? this.questionFour,
        questionThree: questionThree ?? this.questionThree,
        questionTwo: questionTwo ?? this.questionTwo,
      );

  factory FeedbackAnswer.fromJson(String str) => FeedbackAnswer.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory FeedbackAnswer.fromMap(Map<String, dynamic> json) => FeedbackAnswer(
        questionOne: json["questionOne"],
        questionFour: Question.fromMap(json["questionFour"]),
        questionThree: Question.fromMap(json["questionThree"]),
        questionTwo: Question.fromMap(json["questionTwo"]),
      );

  Map<String, dynamic> toMap() => {
        "questionOne": questionOne,
        "questionFour": questionFour.toMap(),
        "questionThree": questionThree.toMap(),
        "questionTwo": questionTwo.toMap(),
      };
}

class Question {
  Question({
    required this.answerOne,
    required this.answerFour,
    required this.answerThree,
    required this.answerTwo,
  });

  final int answerOne;
  final int answerFour;
  final int answerThree;
  final int answerTwo;

  Question copyWith({
    int? answerOne,
    int? answerFour,
    int? answerThree,
    int? answerTwo,
  }) =>
      Question(
        answerOne: answerOne ?? this.answerOne,
        answerFour: answerFour ?? this.answerFour,
        answerThree: answerThree ?? this.answerThree,
        answerTwo: answerTwo ?? this.answerTwo,
      );

  factory Question.fromJson(String str) => Question.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Question.fromMap(Map<String, dynamic> json) => Question(
        answerOne: json["answerOne"],
        answerFour: json["answerFour"],
        answerThree: json["answerThree"],
        answerTwo: json["answerTwo"],
      );

  Map<String, dynamic> toMap() => {
        "answerOne": answerOne,
        "answerFour": answerFour,
        "answerThree": answerThree,
        "answerTwo": answerTwo,
      };
}
