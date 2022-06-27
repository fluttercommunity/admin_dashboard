// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pull_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Pull _$PullFromJson(Map<String, dynamic> json) => Pull(
      userId: json['userId'] as int,
      state: json['state'] as String,
      title: json['title'] as String,
      logged_at: DateTime.parse(json['logged_at'] as String),
      closed_at: json['closed_at'] == null
          ? null
          : DateTime.parse(json['closed_at'] as String),
      closed_by: json['closed_by'] as String?,
      commentsNumber: json['commentsNumber'] as int?,
      repository: json['repository'] as String,
    );

Map<String, dynamic> _$PullToJson(Pull instance) => <String, dynamic>{
      'userId': instance.userId,
      'state': instance.state,
      'title': instance.title,
      'logged_at': instance.logged_at.toIso8601String(),
      'closed_at': instance.closed_at?.toIso8601String(),
      'closed_by': instance.closed_by,
      'commentsNumber': instance.commentsNumber,
      'repository': instance.repository,
    };
