import 'package:admin_dashboard/dto/table_data.dart';
import 'package:admin_dashboard/service/github_service.dart';
import 'package:admin_dashboard/service/table_data_service.dart';

///Model of issue that is displayed in our application
class SimpleIssue{
  ///Simple Issue constructor
  SimpleIssue({required this.title, required this.url, required this.state,
    required this.comments, required this.createdAt,
    required this.updatedAt,});

  ///title of issue
  final String title;
  ///URL of issue
  final String url;
  ///State of the issue (Open or closed)
  final String state;
  ///Number of comments the issue has
  final int comments;
  ///Date the issue was created
  final DateTime createdAt;
  ///Last time the issue was updated (new comments, change of state, etc)
  final DateTime updatedAt;

  @override
  String toString() {
    return 'SimpleIssue{title: $title, url: $url, state: $state, '
        'comments: $comments, '
        'createdAt: ${createdAt.month}/${createdAt.day}/${createdAt.year},'
        ' updatedAt: ${updatedAt.month}/${updatedAt.day}/${updatedAt.year} }';
  }
}

///List of issues in a repo to be displayed in the table
class SimpleIssueList{
  ///Constructor
  SimpleIssueList(this.repoName);
  ///Name of the repository
  String repoName;
  ///List of issues to be displayed in the table
  List<SimpleIssue> data = <SimpleIssue>[];
  ///method to add issues to the SimpleIssueList
  void add(SimpleIssue issue) {
    data.add(issue);
  }

  @override
  String toString() {
    return 'SimpleIssueList{data: $data}';
  }
  ///List of issues opened within the last six months
  Future<List<SimpleIssue>> getOpenInLastSixMonths() async{
    if(data.isEmpty){
      final service = GithubService();
      data = await service.getAllIssuesOfRepo(repoName);
    }

    final result = <SimpleIssue>[];
    for(final issue in data){
      if(issue.state != 'open') {
        continue;
      }
      if(issue.createdAt.difference(DateTime.now()).
      compareTo(const Duration(days: 180))>0) {
        continue;
      }
      result.add(issue);
    }

    return result;
  }
}
///The actual github table provider that fetches data from github
class GithubTableDataProvider extends TableDataProviderInterface {
  ///Create a simple issue list where the repoName is set
  GithubTableDataProvider(String repoName) :
        simpleIssueList = SimpleIssueList(repoName), super(repoName);
  ///Object that contains the list of issues that are displayed in the
  ///issue details page for a specific repo
  SimpleIssueList simpleIssueList;
  @override
  Future<TableData> getOpenInLastSixMonths() async{
    final data = await simpleIssueList.getOpenInLastSixMonths();
    final result = TableData();
    for(final issue in data){
      result.add(TableDataRow().addValue('Title', issue.title)
          .addValue('Created', ' ${issue.createdAt.month}/'
          '${issue.createdAt.day}/${issue.createdAt.year},',)
          .addValue('Last Update', ' ${issue.updatedAt.month}/'
          '${issue.updatedAt.day}/${issue.updatedAt.year},',)
          .addValue('Comments', issue.comments.toString()),
      );
    }
    return result;
  }

  @override
  Future<TableData> getSecondTable() async{
    return TableData().add(TableDataRow().addValue('Name', 'Bug fix').
    addValue('Open', '3 days'),)
        .add(TableDataRow().addValue('Name', 'Enhancement').
    addValue('Open', '7 days'),)
        .add(TableDataRow().addValue('Name', 'Feature').
    addValue('Open', '1 month'),)
        .add(TableDataRow().addValue('Name', 'Help wanted').
    addValue('Open', '4 months'),);
  }
}
