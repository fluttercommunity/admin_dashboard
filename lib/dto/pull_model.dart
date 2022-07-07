import 'package:json_annotation/json_annotation.dart';

part 'pull_model.g.dart';

@JsonSerializable()
///model of github PR
class Pull {
  ///Model of PR
  Pull({
    required this.userId,
    required this.state,
    required this.title,
    required this.loggedAt,
    required this.closedAt,
    required this.closedBy,
    required this.commentsNumber,
    required this.repository,
  });
  ///Conversion of JSON into PR object
  factory Pull.fromJson(Map<String, dynamic> json) => _$PullFromJson(json);
  ///user that created PR's ID
  final int userId;
  ///state of PR
  final String state;
  ///title of PR
  final String title;
  ///time PR was logged
  final DateTime loggedAt;
  ///time PR was closed
  final DateTime? closedAt;
  ///user who closed PR
  final String? closedBy;
  ///number of comments in PR
  final int? commentsNumber;
  ///repository in which PR resides
  final String repository;

  ///conversion of PR into JSON
  Map<String, dynamic> toJson() => _$PullToJson(this);
}
