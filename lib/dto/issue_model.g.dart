// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'issue_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Issue _$IssueFromJson(Map<String, dynamic> json) => Issue(
      issueID: json['issueID'] as int,
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

Map<String, dynamic> _$IssueToJson(Issue instance) => <String, dynamic>{
      'issueID': instance.issueID,
      'state': instance.state,
      'title': instance.title,
      'loggedAt': instance.loggedAt.toIso8601String(),
      'closedAt': instance.closedAt?.toIso8601String(),
      'closedBy': instance.closedBy,
      'commentsNumber': instance.commentsNumber,
      'repository': instance.repository,
    };
