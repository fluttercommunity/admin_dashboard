import 'package:json_annotation/json_annotation.dart';

part 'issue_model.g.dart';

@JsonSerializable()

///Model of github issues
class Issue {
  //final List<Label> labels;

  ///Model of github issues
  Issue({
    required this.issueID,
    required this.state,
    required this.title,
    required this.loggedAt,
    required this.closedAt,
    required this.closedBy,
    required this.commentsNumber,
    required this.repository,
    //,this.labels
  });
  ///Conversion of JSON into issue object
  factory Issue.fromJson(Map<String, dynamic> json) => _$IssueFromJson(json);
  ///ID of issue retrieved from github API
  final int issueID;
  ///state of issue
  final String state;
  ///title of issue
  final String title;
  ///time issue was logged
  final DateTime loggedAt;
  ///time issue was closed, null if still open
  final DateTime? closedAt;
  ///username of user who closed issue, null if still open
  final String? closedBy;
  ///number of comments in issue, 0 if none
  final int? commentsNumber;
  ///repo issue belongs to
  final String repository;

  ///conversion of issues into JSON
  Map<String, dynamic> toJson() => _$IssueToJson(this);
}
///Array of labels for an issue
class Label {


}
