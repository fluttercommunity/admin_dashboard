// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pull_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Pull _$PullFromJson(Map<String, dynamic> json) => Pull(
      userId: json['userId'] as int,
      state: json['state'] as String,
      title: json['title'] as String,
      loggedAt: DateTime.parse(json['loggedAt'] as String),
      closedAt: json['closedAt'] == null
          ? null
          : DateTime.parse(json['closedAt'] as String),
      closedBy: json['closedBy'] as String?,
      commentsNumber: json['commentsNumber'] as int?,
      repository: json['repository'] as String,
    );

Map<String, dynamic> _$PullToJson(Pull instance) => <String, dynamic>{
      'userId': instance.userId,
      'state': instance.state,
      'title': instance.title,
      'loggedAt': instance.loggedAt.toIso8601String(),
      'closedAt': instance.closedAt?.toIso8601String(),
      'closedBy': instance.closedBy,
      'commentsNumber': instance.commentsNumber,
      'repository': instance.repository,
    };
