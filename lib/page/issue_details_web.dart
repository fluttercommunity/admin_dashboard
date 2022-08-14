
import 'package:admin_dashboard/service/issue_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../dto/admin_dashboard_cache_model.dart';
import '../dto/issue_model.dart';
import '../dto/repo_model.dart';
import '../provider/provider_list.dart';
import '../service/fire_base.dart';
import 'drawer_widget.dart';

class WideIssuePage extends  ConsumerWidget{
  final AdminDashboardCache cache;

  ///instance of firebaseApp
  final FirebaseApp firebaseApp;
  final SimpleRepo simpleRepo;
  final double myWidth;
  final double myHeight;

  WideIssuePage(this.cache, this.firebaseApp, this.simpleRepo, this.myWidth,
      this.myHeight);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double width = MediaQuery
        .of(context)
        .size
        .width;
    double height = MediaQuery
        .of(context)
        .size
        .height;

    final issueProviderImplementor = ref.read(issueProvider);

    return Scaffold(
        backgroundColor: Colors.grey,
        drawer: DrawerWidget(
          cache,
          firebaseApp,
        ),
        appBar: AppBar(
          backgroundColor: Colors.deepPurpleAccent,
        ),
        // body: buildIssueTable(context),
        body: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          verticalDirection: VerticalDirection.down,
          children: <Widget>[
            Center(
              child:buildIssueTable(issueProviderImplementor),
            )
          ],
        ),
        bottomSheet: buildBottomSheet(context)
    );
  }

  Widget buildBottomSheet(BuildContext context) {
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
                  child: Text(cache.simpleRepo.name),
                ),
                const Spacer(),
                Container(
                  alignment: Alignment.center,
                  child: const Text('Status'),
                ),
                const Spacer(),
                Container(
                  alignment: Alignment.center,
                  child: const Text('Owner'),
                ),
                const Spacer(),
              ],
            )
        )
    );
  }
  DataTable buildIssueTable(IssueProviderInterface issueProviderImplementor){
    List<String> issues;
    issues = ["testtesttest"];
    return DataTable(
        columns: [
          DataColumn(label: Text("Test"),
          numeric: false,
          ),
          DataColumn(label: Text("label"),
            numeric: false,
          ),

        ],
        rows:[]
    );
  }
//   Widget buildIssueTable(BuildContext context){
//     final columns = ['Placeholder 1', 'Placeholder 2', 'Place holder 3'];
//     return DataTable(
//         columns: getColumns(columns),
//         rows: getRows(issues),
//     );
//   }
//   List<DataColumn> getColumns(List<String> columns){
//     return columns.map((String column){
//       return DataColumn(
//         label: Text(column),);
//
//     }).toList();
//   }
//   List<DataRow> getRows(List<Issue> issues) => issues.map((Issue issue)){
//   FireBaseService firebaseService;
//     final issues = firebaseService.getAllRepoIssues;
//
// };
}
