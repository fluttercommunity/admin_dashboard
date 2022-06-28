import 'package:admin_dashboard/service/basic_service.dart';
import 'package:admin_dashboard/service/fire_base.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'injection.config.dart';

final getIt = GetIt.instance;

@injectableInit
Future<void> configureInjection(String environment) async{
  $initGetIt(getIt, environment: environment);
  final gh = GetItHelper(getIt, environment);
  gh.factory<BasicServiceInterface>(() => FireBaseService());
}

abstract class Env {
  static const dev = 'dev';
  static const prod = 'prod';
}