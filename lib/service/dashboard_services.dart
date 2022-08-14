import 'package:admin_dashboard/service/pull_request_service.dart';

import 'issue_service.dart';

class DashboardParameterList{
  PullSummaryInformation pullRequestSummary = PullSummaryInformation();
  IssueSummaryInformation issueSummary = IssueSummaryInformation();
}

abstract class DashboardServiceInterface {
  Future<DashboardParameterList> getDashboardParameters();
}

class DashboardServiceImplementor extends DashboardServiceInterface{
  IssueProviderInterface issueProvider;
  PullProviderInterface pullServiceProvider;

  DashboardServiceImplementor(this.issueProvider, this.pullServiceProvider);

  @override
  Future<DashboardParameterList> getDashboardParameters() async{
    var params = DashboardParameterList();
    params.issueSummary = await issueProvider.getIssueSummaryInformation();
    params.pullRequestSummary =
                    await pullServiceProvider.getPullSummaryInformation();
    return params;
  }

}