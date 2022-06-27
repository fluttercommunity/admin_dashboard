// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'issue_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Issue _$IssueFromJson(Map<String, dynamic> json) => Issue(
      issueID: json['issueID'] as int,
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

Map<String, dynamic> _$IssueToJson(Issue instance) => <String, dynamic>{
      'issueID': instance.issueID,
      'state': instance.state,
      'title': instance.title,
      'logged_at': instance.logged_at.toIso8601String(),
      'closed_at': instance.closed_at?.toIso8601String(),
      'closed_by': instance.closed_by,
      'commentsNumber': instance.commentsNumber,
      'repository': instance.repository,
    };
