import 'package:json_annotation/json_annotation.dart';

part 'issue_model.g.dart';

@JsonSerializable()
class Issue { //model of github issue
  final int issueID;
  final String state;
  final String title;
  final DateTime logged_at;
  final DateTime? closed_at;
  final String? closed_by;
  final int? commentsNumber;
  final String repository;
  //final List<Label> labels;


  Issue({ required this.issueID, required this.state, required this.title, required this.logged_at, required this.closed_at,
    required this.closed_by, required this.commentsNumber
    , required this.repository
    //,this.labels
  });

  factory Issue.fromJson(Map<String, dynamic> json) => _$IssueFromJson(json); //Conversion of JSON into object issue
  Map<String, dynamic> toJson() => _$IssueToJson(this); //conversion of issues into JSON
 }

class Label{ //Array of labels for an issue

}
