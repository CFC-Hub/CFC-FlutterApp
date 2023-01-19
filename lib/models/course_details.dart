import 'dart:convert';

class CourseDetails {
  CourseDetails({
    required this.courseName,
    required this.createdBy,
    required this.rating,
    required this.courseUrl,
    required this.id,
    required this.courseId,
    required this.createdOn,
    required this.courseDisplayPicture,
  });

  final String courseName;
  final String createdBy;
  final double rating;
  final String courseUrl;
  final String id;
  final String courseId;
  final int createdOn;
  final String courseDisplayPicture;

  CourseDetails copyWith({
    String? courseName,
    String? createdBy,
    double? rating,
    String? courseUrl,
    String? id,
    String? courseId,
    int? createdOn,
    String? courseDisplayPicture,
  }) =>
      CourseDetails(
        courseName: courseName ?? this.courseName,
        createdBy: createdBy ?? this.createdBy,
        rating: rating ?? this.rating,
        courseUrl: courseUrl ?? this.courseUrl,
        id: id ?? this.id,
        courseId: courseId ?? this.courseId,
        createdOn: createdOn ?? this.createdOn,
        courseDisplayPicture: courseDisplayPicture ?? this.courseDisplayPicture,
      );

  factory CourseDetails.fromJson(String str) => CourseDetails.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CourseDetails.fromMap(Map<String, dynamic> json) => CourseDetails(
        courseName: json["courseName"],
        createdBy: json["createdBy"],
        rating: json["rating"].toDouble(),
        courseUrl: json["courseUrl"],
        id: json["id"],
        courseId: json["courseId"],
        createdOn: json["createdOn"],
        courseDisplayPicture: json["courseDisplayPicture"],
      );

  Map<String, dynamic> toMap() => {
        "courseName": courseName,
        "createdBy": createdBy,
        "rating": rating,
        "courseUrl": courseUrl,
        "id": id,
        "courseId": courseId,
        "createdOn": createdOn,
        "courseDisplayPicture": courseDisplayPicture,
      };
}
