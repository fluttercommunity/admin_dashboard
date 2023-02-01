import 'package:admin_dashboard/service/issue_service.dart';
import 'package:admin_dashboard/service/pull_request_service.dart';

///For the repo page, this contains all the data and provides it to the page
///currently, dummy data is being used
class DashboardParameterList{
  ///Pull request summary contains all the info regarding PRs in the repo
  ///dashboard page
  PullSummaryInformation pullRequestSummary = PullSummaryInformation();
  ///Issue summary also contains all the info regarding issues in the
  ///repo dashboard page
  IssueSummaryInformation issueSummary = IssueSummaryInformation();
}
///Returns the parameters for all data in the repo page
abstract class DashboardServiceInterface {
  ///Returns the dashboard parameters for all data in repo page,
  ///currently contains dummy providers
  Future<DashboardParameterList> getDashboardParameters();
}

///Implements the dummy providers for the repo page
class DashboardServiceImplementor extends DashboardServiceInterface{
  ///Constructor
  DashboardServiceImplementor(this.issueProvider, this.pullServiceProvider);
  ///Instance of the issue provider
  IssueProviderInterface issueProvider;
  ///Instance of the pull request provider
  PullProviderInterface pullServiceProvider;

  @override
  Future<DashboardParameterList> getDashboardParameters() async{
    final params = DashboardParameterList();
    params.issueSummary = await issueProvider.getIssueSummaryInformation();
    params.pullRequestSummary =
    await pullServiceProvider.getPullSummaryInformation();
    return params;
  }
}
