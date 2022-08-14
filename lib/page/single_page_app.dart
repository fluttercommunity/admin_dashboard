// import 'package:admin_dashboard/dto/admin_dashboard_cache_model.dart';
// import 'package:admin_dashboard/page/old_welcome_page.dart';
// import 'package:admin_dashboard/provider/provider_list.dart';
// import 'package:admin_dashboard/service/basic_service.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
//
// ///Initial page that prompts user to log in, default page shown
// class MainPage extends ConsumerWidget {
//   ///Build interface using Consumer to pass AdminDashboardCache
//   /// to LoginPageDetailsBody
//   const MainPage({Key? key}) : super(key: key);
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final cache = ref.read(cacheProvider);
//     final fire = ref.read(fireBaseService);
//
//     return Scaffold(
//       body: MainPageBody(cache, fire),
//     );
//   }
// }
// ///Details of the Login page's body
// class MainPageBody extends StatelessWidget {
//   ///key
//   const MainPageBody(this.cache, this.fire, {Key? key})
//       : super(key: key);
//   ///cache where the logged in user's ID is stored
//   final AdminDashboardCache cache;
//   ///instance to handle firebase services
//   final BasicServiceInterface fire;
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: OldWelcomePage(cache: cache, fire: fire),
//     );
//   }
// }
