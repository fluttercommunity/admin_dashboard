
abstract class PullProviderInterface {
  Future<int> getTotalPull();
  Future<int> getTotalClosedPull();
  Future<int> getTagNumberPull();
  Future<int> getTotalDormantPull();
  Future<int> getRecentPull();
  Future<int> getOldPull();
  Future<String> totalPullTitle();
  Future<String> dormantPullTitle();
  Future<String> pullsHighActivity();
  Future<String> pullsLowActivity();
  Future<String> pullsLabeled();
  Future<String> pullsOldTitle();
  Future<PullSummaryInformation> getPullSummaryInformation();

}

class PullSummaryInformation {
  String totalPull = "...";
  String totalClosedPull = "...";
  String tagNumberPull = "...";
  String totalDormantPull = "...";
  String recentPull = "...";
  String oldPull = "...";
  String dormantPullTitle = '...';
  String totalIPullTitle = '...';
  String pullsLabeled = '...';
  String pullsHighActivity = '...';
  String pullsLowActivity = '...';
  String pullsOldTitle = '...';
}

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
  Future<int> getTagNumberPull() async {
    return 3;
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
    return "PRs with high activity";

  }

  @override
  Future<String> pullsLabeled() async {
    return "PRs grouped by label";

  }

  @override
  Future<String> pullsLowActivity() async {
    return "PRs with low activity";

  }

  @override
  Future<String> pullsOldTitle() async {
    return 'PRs older than 2 months';

  }
  @override
  Future<PullSummaryInformation> getPullSummaryInformation() async {
    PullSummaryInformation info = PullSummaryInformation();
    info.oldPull = (await this.getOldPull()).toString();
    info.recentPull = (await this.getRecentPull()).toString();
    info.tagNumberPull = (await this.getTagNumberPull()).toString();
    info.totalClosedPull = (await this.getTotalClosedPull()).toString();
    info.totalDormantPull = (await this.getTotalDormantPull()).toString();
    info.totalPull = (await this.getTotalPull()).toString();
    info.dormantPullTitle = (await this.dormantPullTitle());
    info.totalIPullTitle = (await this.totalPullTitle());
    info.pullsHighActivity = (await this.pullsHighActivity());
    info.pullsLabeled = (await this.pullsLabeled());
    info.pullsLowActivity = (await this.pullsLowActivity());
    info.pullsOldTitle = (await this.pullsOldTitle());

    return info;
  }
}
