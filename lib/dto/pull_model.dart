import 'package:json_annotation/json_annotation.dart';

part 'pull_model.g.dart';

@JsonSerializable()
class Pull { //model of github issue
  final int userId;
  final String state;
  final String title;
  final DateTime logged_at;
  final DateTime? closed_at;
  final String? closed_by;
  final int? commentsNumber;
  final String repository;

  Pull({ required this.userId, required this.state, required this.title, required this.logged_at, required this.closed_at,
    required this.closed_by, required this.commentsNumber
    , required this.repository
  });

  factory Pull.fromJson(Map<String, dynamic> json) => _$PullFromJson(json); //Conversion of JSON into object issue
  Map<String, dynamic> toJson() => _$PullToJson(this); //conversion of issues into JSON
}