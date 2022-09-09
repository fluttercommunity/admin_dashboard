///Information regarding issues that is displayed in repo dashboard
abstract class IssueProviderInterface {
  ///Retrieves total issues in a repo
  Future<int> getTotalIssue();
  ///Retrieves total closed issues in a repo
  Future<int> getTotalClosedIssue();
  ///Retrieves number of labeled issues in a repo
  Future<int> getTagNumberIssue();
  ///Retrieves number of dormant issues in a repo
  Future<int> getTotalDormantIssue();
  ///Retrieves number of issues that have been recently opened
  Future<int> getRecentIssue();
  ///Retrieves number of issues older than 6 months
  Future<int> getOldIssue();
  ///Retrieves number of total issues
  Future<String> totalIssueTitle();
  ///Retrieves Dormant issues keyword
  Future<String> dormantIssueTitle();
  ///Retrieves issues with high activity keyword
  Future<String> issuesHighActivity();
  ///Retrieves issues with low activity keyword
  Future<String> issuesLowActivity();
  ///Retrieves issues grouped by label keyword
  Future<String> issuesLabeled();
  ///Retrieves issues older than 6 months keyword
  Future<String> issuesOldTitle();
  ///contains all the info regarding issues in the repo dashboard
  Future<IssueSummaryInformation> getIssueSummaryInformation();

}
///Information regarding issues that is displayed in repo dashboard
class IssueSummaryInformation {
  ///number of total issues
  String totalIssue = '...';
  ///number of closed issues
  String totalClosedIssue = '...';
  ///number of dormant issues
  String totalDormantIssue = '...';
  ///number of recent issues
  String recentIssue = '...';
  ///number of old issues
  String oldIssue = '...';
  ///Dormant issues keyword
  String dormantIssueTitle = '...';
  ///Total issues keyword
  String totalIssueTitle = '...';
  ///Issues with label keyword where the user can then see issues with
  ///certain labels
  String issuesLabeled = '...';
  ///Issues with high activity where a user clicks and then sees a list of
  ///issues with high activity
  String issuesHighActivity = '...';
  ///Issues with low activity where a user clicks and then sees a list of
  ///issues with low activity
  String issuesLowActivity = '...';
  /// issues older than 6 months key word
  String issuesOldTitle = '...';
}

///Dummy issue provider that contains all hardcoded info until they are
///fully implemented
class DummyIssueProvider extends IssueProviderInterface {
  @override
  Future<int> getOldIssue() async {
    return 13;
  }

  @override
  Future<int> getRecentIssue() async {
    return 2;
  }

  @override
  Future<int> getTagNumberIssue() async {
    return 9;
  }

  @override
  Future<int> getTotalClosedIssue() async {
    return 4;
  }

  @override
  Future<int> getTotalDormantIssue() async {
    return 7;
  }

  @override
  Future<int> getTotalIssue() async {
    return 5;
  }

  @override
  Future<String> dormantIssueTitle() async {
    return 'Dormant Issues: ';
  }

  @override
  Future<String> totalIssueTitle() async {
    return 'Total Issues: ';
  }

  @override
  Future<String> issuesHighActivity() async {
    return 'Open issues with high activity ';
  }

  @override
  Future<String> issuesLabeled() async {
    return 'Open issues grouped by label ';
  }

  @override
  Future<String> issuesLowActivity() async {
    return 'Open issues with no activity';

  }

  @override
  Future<String> issuesOldTitle() async {
    return 'Open issues older than 6 months';
  }

  @override
  Future<IssueSummaryInformation> getIssueSummaryInformation() async {
    ///info contains all the information regarding the issue dummy provider
    final info = IssueSummaryInformation();
    info..oldIssue = (await getOldIssue()).toString()
    ..recentIssue = (await getRecentIssue()).toString()
    ..totalClosedIssue = (await getTotalClosedIssue()).toString()
    ..totalDormantIssue = (await getTotalDormantIssue()).toString()
    ..totalIssue = (await getTotalIssue()).toString()
    ..dormantIssueTitle = (await dormantIssueTitle())
    ..totalIssueTitle = (await totalIssueTitle())
    ..issuesHighActivity = (await issuesHighActivity())
    ..issuesLabeled = (await issuesLabeled())
    ..issuesLowActivity = (await issuesLowActivity())
    ..issuesOldTitle = (await issuesOldTitle());
    return info;
  }
}
