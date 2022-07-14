import 'package:json_annotation/json_annotation.dart';

part 'repo_model.g.dart';
@JsonSerializable()

///Model of github issues
class Repo {

  ///Model of github repos
  Repo({
    required this.name,
    required this.openIssuesCount,
    required this.watchersCount,
    required this.stargazersCount,
    required this.language,
    required this.url,
  });
  ///Conversion of JSON into repo object
  factory Repo.fromJson(Map<String, dynamic> json) => _$RepoFromJson(json);
  ///name of repository
  final String name;
  ///number of open issues in repo
  final int openIssuesCount;
  ///number of watchers in repo
  final int watchersCount;
  ///number of star gazers in repo
  final int stargazersCount;
  ///repo's main programming language
  final String language;
  ///URL of repo
  final String url;

  ///conversion of repos into JSON
  Map<String, dynamic> toJson() => _$RepoToJson(this);
}
///Class for the repo objects displayed in the repo page
class SimpleRepo extends Comparable<dynamic>{
  ///constructor
  SimpleRepo({required this.name});
  ///name of repository
  final String name;

  @override
  int compareTo(dynamic other) {
    if(other is! SimpleRepo) {
      return 0;
    }
    final otherRepo = other;
    final myName =  name.toLowerCase().replaceAll(RegExp('[-_]'), ' ');
    final otherName =
    otherRepo.name.toLowerCase().replaceAll(RegExp('[-_]'), ' ');
    return myName.compareTo(otherName);
  }
}
