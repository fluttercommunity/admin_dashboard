import 'package:admin_dashboard/dto/admin_dashboard_cache_model.dart';
import 'package:admin_dashboard/service/dashboard_services.dart';
import 'package:admin_dashboard/service/issue_service.dart';
import 'package:admin_dashboard/service/pull_request_service.dart';
import 'package:admin_dashboard/service/table_data_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

///Provide the cache for the application
///It will store information such as the userId,
///and the token used for authentication
final cacheProvider = Provider((ref) => AdminDashboardCache());
///Provides the singleton object of the class FireBaseService
///It helps implements the DI pattern, as the implementor
///of the Interface BasicServiceInterface
final issueProvider= Provider((ref) => DummyIssueProvider());

///the dummy pull provider, returns dummy data for the repo page
final pullProvider = Provider((ref) => DummyPullProvider());

///Contains the dummy providers for the repo page
final myDashboardProvider = Provider((ref) =>
    DashboardServiceImplementor(DummyIssueProvider(),
        DummyPullProvider(),),);

///Dummy table provider for the repo/issues page
final tabledataProvider = Provider((ref) => DummyTableDataProvider('')
,);
