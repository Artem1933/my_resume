import 'dart:convert';

class ProfileModel {
  final int id;
  final String fullName;
  final String position;
  final String summary;

  const ProfileModel({
    required this.id,
    required this.fullName,
    required this.position,
    required this.summary,
  });

  ProfileModel copyWith({
    int? id,
    String? fullName,
    String? position,
    String? summary,
  }) {
    return ProfileModel(
      id: id ?? this.id,
      fullName: fullName ?? this.fullName,
      position: position ?? this.position,
      summary: summary ?? this.summary,
    );
  }

  static ProfileModel empty() {
    return const ProfileModel(
      id: 0,
      fullName: '',
      position: '',
      summary: '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fullName': fullName,
      'position': position,
      'summary': summary,
    };
  }

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      id: json['id'] as int,
      fullName: json['fullName'] as String,
      position: json['position'] as String,
      summary: json['summary'] as String,
    );
  }
}