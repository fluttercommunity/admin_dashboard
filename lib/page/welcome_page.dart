import 'package:admin_dashboard/dto/admin_dashboard_cache_model.dart';
import 'package:admin_dashboard/dto/constant.dart';
import 'package:admin_dashboard/page/drawer_widget.dart';
import 'package:admin_dashboard/service/basic_service.dart';
import 'package:flutter/material.dart';

///Default page shown in our application
class WelcomePage extends StatefulWidget {

  ///welcome page
  const WelcomePage({
    Key? key,
    required this.cache,
    required this.fire,
  }) : super(key: key);

  ///cache where the logged in user's ID is stored
  final AdminDashboardCache cache;
  ///instance to handle firebase services
  final BasicServiceInterface fire;

  @override
  State<WelcomePage> createState() => _WelcomePageState(cache, fire);
}

class _WelcomePageState extends State<WelcomePage> {
  _WelcomePageState(this.cache, this.fire);

  AdminDashboardCache cache;
  BasicServiceInterface fire;

  @override
  Widget build(BuildContext context) => Scaffold(
    drawer: DrawerWidget(cache, fire),
    appBar:  AppBar(
      title: const Text(Constants.welcomePageTitle),
    ),
  );

}
