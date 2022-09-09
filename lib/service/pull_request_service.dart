///Information regarding PRs that is displayed in the repo dashboard
abstract class PullProviderInterface {
  ///Retrieves number of total PRs
  Future<int> getTotalPull();
  ///Retrieves number of total closed PRs
  Future<int> getTotalClosedPull();
  ///Retrieves number of PRs that are dormant
  Future<int> getTotalDormantPull();
  ///Retrieves number of recent PRs
  Future<int> getRecentPull();
  ///Retrieves keyword PRs older than 6 months
  Future<int> getOldPull();
  ///Retrieves the title for total PRs
  Future<String> totalPullTitle();
  ///Retrieves the title for Dormant PRs
  Future<String> dormantPullTitle();
  ///Retrieves keyword PRs with high activity
  Future<String> pullsHighActivity();
  ///Retrieves keyword PRs with low activity
  Future<String> pullsLowActivity();
  ///Retrieves keyword PRs with labels
  Future<String> pullsLabeled();
  ///Retrieves keyword PRs that are older than 6 months
  Future<String> pullsOldTitle();
  ///Contains all the information regarding PRs in the repo dashboard
  Future<PullSummaryInformation> getPullSummaryInformation();
}
///Information regarding PRs that is displayed in the repo dashboard
class PullSummaryInformation {
  ///Total number of PRs in a repo
  String totalPull = '...';
  ///Total number of closed PRs in a repo
  String totalClosedPull = '...';
  ///Total number of dormant issues
  String totalDormantPull = '...';
  ///Recent PRs
  String recentPull = '...';
  ///Old PRs
  String oldPull = '...';
  ///Title for dormant PRs
  String dormantPullTitle = '...';
  ///Title for total PRs
  String totalIPullTitle = '...';
  ///PRs grouped by label keyword
  String pullsLabeled = '...';
  ///PRs with high activity keyword
  String pullsHighActivity = '...';
  ///PRs with low activity keyword
  String pullsLowActivity = '...';
  ///PRs older than 6 months keyword
  String pullsOldTitle = '...';
}
///Dummy pull request provider that contains everything hardcoded until it
///is fully implemented
class DummyPullProvider extends PullProviderInterface {
  @override
  Future<int> getOldPull() async {
    return 8;
  }

  @override
  Future<int> getRecentPull() async {
    return 4;
  }


  @override
  Future<int> getTotalClosedPull() async {
    return 12;
  }

  @override
  Future<int> getTotalDormantPull() async {
    return 11;
  }

  @override
  Future<int> getTotalPull() async {
    return 42;
  }

  @override
  Future<String> dormantPullTitle() async {
    return 'Dormant Pull Requests: ';
  }

  @override
  Future<String> totalPullTitle() async {
    return 'Total Pull Requests: ';
  }

  @override
  Future<String> pullsHighActivity() async {
    return 'PRs with high activity';

  }

  @override
  Future<String> pullsLabeled() async {
    return 'PRs grouped by label';

  }

  @override
  Future<String> pullsLowActivity() async {
    return 'PRs with low activity';

  }

  @override
  Future<String> pullsOldTitle() async {
    return 'PRs older than 2 months';

  }
  @override
  Future<PullSummaryInformation> getPullSummaryInformation() async {
    final info = PullSummaryInformation();
    info..oldPull = (await getOldPull()).toString()
    ..recentPull = (await getRecentPull()).toString()
    ..totalClosedPull = (await getTotalClosedPull()).toString()
    ..totalDormantPull = (await getTotalDormantPull()).toString()
    ..totalPull = (await getTotalPull()).toString()
    ..dormantPullTitle = (await dormantPullTitle())
    ..totalIPullTitle = (await totalPullTitle())
    ..pullsHighActivity = (await pullsHighActivity())
    ..pullsLabeled = (await pullsLabeled())
    ..pullsLowActivity = (await pullsLowActivity())
    ..pullsOldTitle = (await pullsOldTitle());

    return info;
  }
}
