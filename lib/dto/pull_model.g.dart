// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pull_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Pull _$PullFromJson(Map<String, dynamic> json) => Pull(
      userId: json['userId'] as int,
      state: json['state'] as String,
      title: json['title'] as String,
      loggedAt: DateTime.parse(json['logged_at'] as String),
      closedAt: json['closed_at'] == null
          ? null
          : DateTime.parse(json['closed_at'] as String),
      closedBy: json['closed_by'] as String?,
      commentsNumber: json['commentsNumber'] as int?,
      repository: json['repository'] as String,
    );

Map<String, dynamic> _$PullToJson(Pull instance) => <String, dynamic>{
      'userId': instance.userId,
      'state': instance.state,
      'title': instance.title,
      'logged_at': instance.loggedAt.toIso8601String(),
      'closed_at': instance.closedAt?.toIso8601String(),
      'closed_by': instance.closedBy,
      'commentsNumber': instance.commentsNumber,
      'repository': instance.repository,
    };
