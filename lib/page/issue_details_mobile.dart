import 'package:admin_dashboard/dto/admin_dashboard_cache_model.dart';
import 'package:admin_dashboard/dto/constant.dart';
import 'package:admin_dashboard/dto/issue.dart';
import 'package:admin_dashboard/dto/repo_model.dart';
import 'package:admin_dashboard/dto/table_data.dart';
import 'package:admin_dashboard/page/drawer_widget.dart';
import 'package:admin_dashboard/provider/provider_list.dart';
import 'package:admin_dashboard/service/table_data_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

///Issue page displayed on mobile devices
class NarrowIssuePage extends ConsumerWidget {
  ///Constructor
  const NarrowIssuePage( this.firebaseApp, this.simpleRepo, this.myWidth,
      this.myHeight,);

  ///instance of firebaseApp
  final FirebaseApp firebaseApp;
  ///instance of simpleRepo that is used to display a list of simple repos
  final SimpleRepo simpleRepo;
  ///width of the screen
  final double myWidth;
  ///height of the screen
  final double myHeight;


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cache = ref.read(cacheProvider);
    final dataProvider = GithubTableDataProvider(cache.simpleRepo.name);
    return NarrowIssueWidget(firebaseApp, simpleRepo, myWidth,
      myHeight, cache, dataProvider,);
  }
}
///State for the mobile issue page
class NarrowIssueWidget extends StatefulWidget {
  ///Constructor
  const NarrowIssueWidget(this.firebaseApp, this.simpleRepo, this.myWidth,
      this.myHeight, this.cache, this.tableDataProvider,);

  @override
  State<StatefulWidget> createState() {
    return NarrowIssueWidgetState(
      firebaseApp, simpleRepo, myWidth, myHeight,
      cache, tableDataProvider,);
  }
  ///instance of firebaseApp
  final FirebaseApp firebaseApp;
  ///instance of simpleRepo
  final SimpleRepo simpleRepo;
  ///width of the screen
  final double myWidth;
  ///height of the screen
  final double myHeight;
  /// Instance of our Admin Dashboard's cache
  final AdminDashboardCache cache;
  ///Instance of the provider for the tableData
  final TableDataProviderInterface tableDataProvider;
}
///State for the issue page for mobile devices
class NarrowIssueWidgetState extends State<NarrowIssueWidget> {
  ///Constructor
  NarrowIssueWidgetState( this.firebaseApp, this.simpleRepo, this.myWidth,
      this.myHeight, this.cache, this.tableDataProvider,);
  ///Instance of firebase App
  final FirebaseApp firebaseApp;
  ///Instance of simple repo
  final SimpleRepo simpleRepo;
  ///Width of the screen
  final double myWidth;
  ///Height of the screen
  final double myHeight;
  ///Instance of our admin dashboard's cache
  final AdminDashboardCache cache;
  ///Instance of the provider for the table data
  final TableDataProviderInterface tableDataProvider;
  ///contains the data of all the issues for the chosen repo
  late Future<TableData> data;
  ///subset of the data of all the issues that matches the criteria chosen
  late TableData currentData;
  @override
  void initState() {
    super.initState();
    data = tableDataProvider.getOpenInLastSixMonths();
  }
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.grey,
      drawer: DrawerWidget(
        firebaseApp,
      ),
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent,
        title: Text(
          cache.simpleRepo.name.replaceAll(RegExp('/fluttercommunity/'), ''),
        ),
      ),
      body:
      ConstrainedBox(
        constraints: BoxConstraints(minWidth: width),
        child: FutureBuilder<TableData>(
          future: data,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                currentData = snapshot.data!;
                return currentData.getCustomScrollViewNarrow(this);
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }
            }
            return const LinearProgressIndicator();
          },
        ),
      ),

      bottomSheet: buildBottomSheet(context, cache,
      ),
    );
  }
  ///The widget for our application's bottom sheet
  Widget buildBottomSheet(BuildContext context, AdminDashboardCache cache,
      ) {
    return Container(
      constraints: const BoxConstraints(
        maxHeight: 30,
        maxWidth: 5000,
        minWidth: 150,
        minHeight: 20,
      ),
      child: BottomAppBar(
        color: Colors.black12,
        child: Row(
          children: <Widget>[
            const Spacer(),
            Container(
              alignment: Alignment.center,
              child: Text(
                  cache.simpleRepo.name.
                  replaceAll(RegExp('/fluttercommunity/'),''),),
            ),
            const Spacer(),
            Container(
              alignment: Alignment.center,
              child: const Text(Constants.statusKeyword),
            ),
            const Spacer(),
            Container(
              alignment: Alignment.center,
              child: const Text(Constants.ownerKeyword),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }

  ///Sort method that sorts the table by ascending
  void sort(String title) {
    setState(() {
      currentData.sort(title);
    });
  }

  ///Sort method that sorts the table by descending
  void reverseSort(String title) {
    setState(() {
      currentData.reverseSort(title);
    });
  }
}
