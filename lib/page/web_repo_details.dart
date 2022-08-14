
import 'package:admin_dashboard/dto/constant.dart';
import 'package:admin_dashboard/service/issue_service.dart';
import 'package:admin_dashboard/service/pull_request_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../dto/admin_dashboard_cache_model.dart';
import '../dto/repo_model.dart';
import '../provider/provider_list.dart';
import '../service/dashboard_services.dart';
import 'drawer_widget.dart';


class WideRepoPage extends ConsumerWidget {
  final AdminDashboardCache cache;

  ///instance of firebaseApp
  final FirebaseApp firebaseApp;

  final SimpleRepo simpleRepo;
  final double myWidth;
  final double myHeight;


  WideRepoPage(this.cache, this.firebaseApp, this.simpleRepo, this.myWidth,
      this.myHeight);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    DashboardServiceInterface dashboardProvider = ref.read(myDashboardProvider);
    return WebSummaryDashboard(cache, firebaseApp,
        dashboardProvider,
        this.myWidth,
        this.myHeight);

  }
}

class WebSummaryDashboard extends StatefulWidget{
  AdminDashboardCache cache;
  FirebaseApp firebaseApp;
  DashboardServiceInterface dashboardProvider;

  final double myWidth;
  final double myHeight;
  WebSummaryDashboard(this.cache, this.firebaseApp,
      this.dashboardProvider,
      this.myWidth,
      this.myHeight);

  @override
  State<StatefulWidget> createState() {
    return _WebSummaryDashboard(this.cache, this.firebaseApp,
        this.dashboardProvider,
        this.myWidth,
        this.myHeight);
  }

}

class _WebSummaryDashboard extends State<WebSummaryDashboard>{
  AdminDashboardCache cache;
  FirebaseApp firebaseApp;
  DashboardServiceInterface dashboardProvider;

  final double myWidth;
  final double myHeight;
  _WebSummaryDashboard(this.cache, this.firebaseApp,
      this.dashboardProvider,
      this.myWidth,
      this.myHeight);

  late Future<DashboardParameterList> params;


  @override
  void initState() {
    super.initState();
    params = dashboardProvider.getDashboardParameters();

  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery
        .of(context)
        .size
        .width;
    double height = MediaQuery
        .of(context)
        .size
        .height;

    return Scaffold(
        backgroundColor: Colors.grey,
        drawer: DrawerWidget(
          cache,
          firebaseApp,
        ),
        appBar: AppBar(
          backgroundColor: Colors.deepPurpleAccent,
          title: Text(cache.simpleRepo.name),
        ),
        body:
        FutureBuilder<DashboardParameterList>(
            future: params,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData) {
                  DashboardParameterList dashboardParams = snapshot.data!;
                  return Column(children: [
                    firstRow(context, width, height, dashboardParams),
                    secondRow(context, width, height, dashboardParams),

                  ],
                  );

                } else if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                }
              }
              return const CircularProgressIndicator();
            },
        )

        ,
        bottomSheet: buildBottomSheet(context)
    );
  }

Widget buildBottomSheet(BuildContext context) {
  final dateToday = DateTime.now();
  final date = dateToday.toString().substring(0,10);
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
                child: Text(Constants.flcTitle),
              ),
              const Spacer(),
              Container(
                alignment: Alignment.center,
                child: Text( Constants.update + '$date'),
              ),
              const Spacer(),
              Container(
                alignment: Alignment.center,
                child: const Text(Constants.status,
                    style: TextStyle(
                    backgroundColor: Colors.red)),
              ),
              const Spacer(),
            ],
          )
      )
  );
}

Widget firstColumn(BuildContext context, DashboardParameterList dashboardParams) {

  return Expanded( child:
   Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    textBaseline: TextBaseline.alphabetic,
    children: [
      Container(
          margin: const EdgeInsets.only(
              bottom: 75, left: 120,
              right: 50, top: 100),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18)
          ),
          padding: EdgeInsets.all(15),
          child: Text(dashboardParams.issueSummary.issuesOldTitle)),
      Container(
          margin: const EdgeInsets.only(bottom: 75, left: 120),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18)
          ),
          padding: EdgeInsets.all(15),
          child: Text(dashboardParams.issueSummary.issuesHighActivity)),
      Container(
          margin: const EdgeInsets.only(bottom: 75, left: 120),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18)
          ),
          padding: EdgeInsets.all(15),
          child: Text(dashboardParams.issueSummary.issuesLowActivity)),
      Container(
          margin: const EdgeInsets.only(left: 120),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18)
          ),
          padding: EdgeInsets.all(15),
          child: Text(dashboardParams.issueSummary.issuesLabeled)),
    ],
  ),
  );
}

Widget secondColumn(BuildContext context) {
  return Expanded(
    child:
    Column(
      children: [
        Container(
          alignment: Alignment.topCenter,
          height: this.myHeight/2,
          width: this.myWidth/2,
          margin: EdgeInsets.only(top:125),
          // child: Image.asset("images/pp.jpg"),
          child: MyLineChart(cache: cache,) ,
        )
      ],
    ),
  );
}

Widget thirdColumn(BuildContext context,
    DashboardParameterList dashboardParams) {
  return Expanded(
    child:
    Column(
      children: [
        Container(
            margin: const EdgeInsets.only(bottom: 75, top: 100, right: 120),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18)
            ),
            padding: EdgeInsets.all(15),
            child: Text(dashboardParams.pullRequestSummary.pullsOldTitle)),
        Container(
            margin: const EdgeInsets.only(bottom: 75, right: 120),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18)
            ),
            padding: EdgeInsets.all(15),
            child: Text(dashboardParams.pullRequestSummary.pullsHighActivity)),
        Container(
            margin: const EdgeInsets.only(bottom: 75, right: 120),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18)
            ),
            padding: EdgeInsets.all(15),
            child: Text(dashboardParams.pullRequestSummary.pullsLowActivity)),
        Container(
            margin: const EdgeInsets.only( right: 120),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18)
            ),
            padding: EdgeInsets.all(15),
            child: Text(dashboardParams.pullRequestSummary.pullsLabeled)),
      ],
    ),
  );
}

Widget firstRow(BuildContext context, double width, double height,
    DashboardParameterList dashboardParams) {

  return Expanded(child: Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18)
      ),
      height: double.maxFinite,
      child:Container(child:
      Row(children: [
        Spacer(),
        Container(
          child:
         Text( dashboardParams.issueSummary.totalIssueTitle +
             dashboardParams.issueSummary.totalIssue),
          width: width/4,),
        Container(
          child:
          Text( dashboardParams.issueSummary.dormantIssueTitle +
            dashboardParams.issueSummary.totalDormantIssue),
          width: width/4,),
        Container(
          child:
          Text( dashboardParams.pullRequestSummary.dormantPullTitle +
             dashboardParams.pullRequestSummary.totalClosedPull)
                  ,width: width/4,),
        Expanded(child: Container(
          child:
          Text( dashboardParams.pullRequestSummary.totalIPullTitle +
              dashboardParams.pullRequestSummary.totalPull),
        ),
        ),
      ],)
      )),
  );
}

Widget secondRow(BuildContext context, double width, double height,
    DashboardParameterList dashboardParams) {
  return Container(
    height: (height*4)/5,
    child:
    Row(
      children: [
        firstColumn(context, dashboardParams),
        secondColumn(context),
        thirdColumn(context, dashboardParams),
      ],
    ),
  );
}
}

class MyLineChart extends StatelessWidget{
  MyLineChart({Key? key, required this.cache}) : super(key: key);

  final AdminDashboardCache cache;

  final data = <double,double>{
    0:0, 1:0.75, 2: 3, 3: 1.2, 4:1, 5:5
  };

  @override
  Widget build(BuildContext context) {
    return LineChart(
        LineChartData(
            minX: 0,
            maxX: 5,
            minY: 0,
            maxY: 5,
            // titlesData: FlTitlesData(
            //   bottomTitles: ,
            //   leftTitles: _leftTitles,
            // ),
            lineBarsData: [
              LineChartBarData(
                  spots: createPoints()
              )
            ],
            gridData: FlGridData(
                show: true,
                getDrawingHorizontalLine: (value){
                  return FlLine(
                    color: Colors.black,
                    strokeWidth: 1,
                  );
                }
            )
        )
    );
  }

  List<FlSpot> createPoints() {
    List<FlSpot> result = [];
    for(double x in this.data.keys)
    {
      result.add(FlSpot(x, data[x]??0));
    }
    return result;
  }
}
