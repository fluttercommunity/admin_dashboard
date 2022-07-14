// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'repo_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Repo _$RepoFromJson(Map<String, dynamic> json) => Repo(
      name: json['name'] as String,
      openIssuesCount: json['openIssuesCount'] as int,
      watchersCount: json['watchersCount'] as int,
      stargazersCount: json['stargazersCount'] as int,
      language: json['language'] as String,
      url: json['url'] as String,
    );

Map<String, dynamic> _$RepoToJson(Repo instance) => <String, dynamic>{
      'name': instance.name,
      'openIssuesCount': instance.openIssuesCount,
      'watchersCount': instance.watchersCount,
      'stargazersCount': instance.stargazersCount,
      'language': instance.language,
      'url': instance.url,
    };
