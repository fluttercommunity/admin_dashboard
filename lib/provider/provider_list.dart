import 'package:admin_dashboard/dto/admin_dashboard_cache_model.dart';
import 'package:admin_dashboard/service/fire_base.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

///Provide the cache for the application
///It will store information such as the userId,
///and the token used for quthentication
final cacheProvider = Provider((ref) => AdminDashboardCache());
///Provides the singleton object of the class FireBaseService
///It helps implements the DI pattern, as the implementor
///of the Interface BasicServiceInterface
final fireBaseService = Provider((ref) => FireBaseService());
