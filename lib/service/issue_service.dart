
abstract class IssueProviderInterface {
  Future<int> getTotalIssue();
  Future<int> getTotalClosedIssue();
  Future<int> getTagNumberIssue();
  Future<int> getTotalDormantIssue();
  Future<int> getRecentIssue();
  Future<int> getOldIssue();
  Future<String> totalIssueTitle();
  Future<String> dormantIssueTitle();
  Future<String> issuesHighActivity();
  Future<String> issuesLowActivity();
  Future<String> issuesLabeled();
  Future<String> issuesOldTitle();

  Future<IssueSummaryInformation> getIssueSummaryInformation();

}

class IssueSummaryInformation {
  String totalIssue = "...";
  String totalClosedIssue = "...";
  String tagNumberIssue = "...";
  String totalDormantIssue = "...";
  String recentIssue = "...";
  String oldIssue = "...";
  String dormantIssueTitle = '...';
  String totalIssueTitle = '...';
  String issuesLabeled = '...';
  String issuesHighActivity = '...';
  String issuesLowActivity = '...';
  String issuesOldTitle = '...';

}

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
    return "Open issues with high activity ";
  }

  @override
  Future<String> issuesLabeled() async {
    return "Open issues grouped by label ";
  }

  @override
  Future<String> issuesLowActivity() async {
    return "Open issues with no activity";

  }

  @override
  Future<String> issuesOldTitle() async {
    return "Open issues older than 2 months";
  }

  @override
  Future<IssueSummaryInformation> getIssueSummaryInformation() async {
    IssueSummaryInformation info = IssueSummaryInformation();
    info.oldIssue = (await this.getOldIssue()).toString();
    info.recentIssue = (await this.getRecentIssue()).toString();
    info.tagNumberIssue = (await this.getTagNumberIssue()).toString();
    info.totalClosedIssue = (await this.getTotalClosedIssue()).toString();
    info.totalDormantIssue = (await this.getTotalDormantIssue()).toString();
    info.totalIssue = (await this.getTotalIssue()).toString();
    info.dormantIssueTitle = (await this.dormantIssueTitle());
    info.totalIssueTitle = (await this.totalIssueTitle());
    info.issuesHighActivity = (await this.issuesHighActivity());
    info.issuesLabeled = (await this.issuesLabeled());
    info.issuesLowActivity = (await this.issuesLowActivity());
    info.issuesOldTitle = (await this.issuesOldTitle());

    return info;
  }



}