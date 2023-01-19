import 'dart:convert';

import 'package:cfc/models/cfc_models.dart';

class MyCourseDetails {
  MyCourseDetails({
    required this.courseName,
    required this.courseDisplayPicture,
    required this.createdBy,
    required this.courseUrl,
    required this.id,
    required this.createdOn,
    required this.courseId,
    required this.deviceInfo,
    required this.isCourseCompleted,
    required this.isQuizCompleted,
    required this.isFeedbackCompleted,
    required this.feedbackId,
    required this.quizId,
    required this.modifiedOn,
  });

  final String courseName;
  final String courseDisplayPicture;
  final String createdBy;
  final String courseUrl;
  final String id;
  final int createdOn;
  final String courseId;
  final DeviceInfo deviceInfo;
  final bool isCourseCompleted;
  final bool isQuizCompleted;
  final bool isFeedbackCompleted;
  final String feedbackId;
  final String quizId;
  final int modifiedOn;

  MyCourseDetails copyWith({
    String? courseName,
    String? courseDisplayPicture,
    String? createdBy,
    String? courseUrl,
    String? id,
    int? createdOn,
    String? courseId,
    DeviceInfo? deviceInfo,
    bool? isCourseCompleted,
    bool? isQuizCompleted,
    bool? isFeedbackCompleted,
    String? feedbackId,
    String? quizId,
    int? modifiedOn,
  }) =>
      MyCourseDetails(
        courseName: courseName ?? this.courseName,
        courseDisplayPicture: courseDisplayPicture ?? this.courseDisplayPicture,
        createdBy: createdBy ?? this.createdBy,
        courseUrl: courseUrl ?? this.courseUrl,
        id: id ?? this.id,
        createdOn: createdOn ?? this.createdOn,
        courseId: courseId ?? this.courseId,
        deviceInfo: deviceInfo ?? this.deviceInfo,
        isCourseCompleted: isCourseCompleted ?? this.isCourseCompleted,
        isQuizCompleted: isQuizCompleted ?? this.isQuizCompleted,
        isFeedbackCompleted: isFeedbackCompleted ?? this.isFeedbackCompleted,
        feedbackId: feedbackId ?? this.feedbackId,
        quizId: quizId ?? this.quizId,
        modifiedOn: modifiedOn ?? this.modifiedOn,
      );

  factory MyCourseDetails.fromJson(String str) => MyCourseDetails.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory MyCourseDetails.fromMap(Map<String, dynamic> json) => MyCourseDetails(
        courseName: json["courseName"],
        courseDisplayPicture: json["courseDisplayPicture"],
        createdBy: json["createdBy"],
        courseUrl: json["courseUrl"],
        id: json["id"],
        createdOn: json["createdOn"],
        courseId: json["courseId"],
        deviceInfo: DeviceInfo.fromMap(json["deviceInfo"]),
        isCourseCompleted: json["isCourseCompleted"],
        isQuizCompleted: json["isQuizCompleted"],
        isFeedbackCompleted: json["isFeedbackCompleted"],
        feedbackId: json["feedbackId"],
        quizId: json["quizId"],
        modifiedOn: json["modifiedOn"],
      );

  Map<String, dynamic> toMap() => {
        "courseName": courseName,
        "courseDisplayPicture": courseDisplayPicture,
        "createdBy": createdBy,
        "courseUrl": courseUrl,
        "id": id,
        "createdOn": createdOn,
        "courseId": courseId,
        "deviceInfo": deviceInfo.toMap(),
        "isCourseCompleted": isCourseCompleted,
        "isQuizCompleted": isQuizCompleted,
        "isFeedbackCompleted": isFeedbackCompleted,
        "feedbackId": feedbackId,
        "quizId": quizId,
        "modifiedOn": modifiedOn,
      };
}
