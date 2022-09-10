import 'package:admin_dashboard/dto/admin_dashboard_cache_model.dart';
import 'package:admin_dashboard/dto/constant.dart';
import 'package:admin_dashboard/dto/repo_model.dart';
import 'package:admin_dashboard/page/drawer_widget.dart';
import 'package:admin_dashboard/provider/provider_list.dart';
import 'package:admin_dashboard/route/routes.dart';
import 'package:admin_dashboard/service/dashboard_services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

///Repo page that is displayed on tablets/web browsers
class WideRepoPage extends ConsumerWidget {

  ///Constructor
  const WideRepoPage(this.firebaseApp, this.simpleRepo, this.myWidth,
      this.myHeight,);

  ///instance of firebaseApp
  final FirebaseApp firebaseApp;
  ///Instance of simple repo
  final SimpleRepo simpleRepo;
  ///Width of screen
  final double myWidth;
  ///Height of screen
  final double myHeight;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cache = ref.read(cacheProvider);
    final dashboardProvider = ref.read(myDashboardProvider);
    return WebSummaryDashboard( cache, firebaseApp,
        dashboardProvider,
        myWidth,
        myHeight,);

  }
}
///The repo dashboard for browsers/tablet devices
class WebSummaryDashboard extends StatefulWidget{
  ///Constructor
  const WebSummaryDashboard(this.cache, this.firebaseApp,
      this.dashboardProvider,
      this.myWidth,
      this.myHeight,);
  ///Instance of admin dashboard cache
  final AdminDashboardCache cache;
  ///Instance of firebase app
  final FirebaseApp firebaseApp;
  ///Instance of dashboard provider
  final DashboardServiceInterface dashboardProvider;
  ///Screen's width
  final double myWidth;
  ///Screen's height
  final double myHeight;

  @override
  State<StatefulWidget> createState() {
    return _WebSummaryDashboard(cache, firebaseApp,
        dashboardProvider,
        myWidth,
        myHeight,);
  }

}

class _WebSummaryDashboard extends State<WebSummaryDashboard>{
  _WebSummaryDashboard(this.cache, this.firebaseApp,
      this.dashboardProvider,
      this.myWidth,
      this.myHeight,);

  AdminDashboardCache cache;
  FirebaseApp firebaseApp;
  DashboardServiceInterface dashboardProvider;

  final double myWidth;
  final double myHeight;


  late Future<DashboardParameterList> params;


  @override
  void initState() {
    super.initState();
    params = dashboardProvider.getDashboardParameters();

  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery
        .of(context)
        .size
        .width;
    final height = MediaQuery
        .of(context)
        .size
        .height;

    return Scaffold(
        backgroundColor: Colors.grey,
        drawer: DrawerWidget(
          firebaseApp,
        ),
        appBar: AppBar(
          backgroundColor: Colors.deepPurpleAccent,
          title: Text(
              cache.simpleRepo.name
                  .replaceAll(RegExp('/fluttercommunity/'),''),),
        ),
        body:
        FutureBuilder<DashboardParameterList>(
          future: params,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                final dashboardParams = snapshot.data!;
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
    ,);
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
                  child: const Text(Constants.flcTitle),
                ),
                const Spacer(),
                Container(
                  alignment: Alignment.center,
                  child: Text( '${Constants.update}$date'),
                ),
                const Spacer(),
                Container(
                  alignment: Alignment.center,
                  child: const Text(Constants.status,
                      style: TextStyle(
                          backgroundColor: Colors.red,),),
                ),
                const Spacer(),
              ],
            )
        ,)
    ,);
  }

  Widget firstColumn(BuildContext context,
      DashboardParameterList dashboardParams,) {

    return Expanded( child:
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      textBaseline: TextBaseline.alphabetic,
      children: [
        GestureDetector(
          onTap: () => {
            Navigator.of(context).pushReplacementNamed(
                RouteGenerator.issueDetailPage)
          },
         child:
         Container(
            margin: const EdgeInsets.only(
                bottom: 75, left: 120,
                right: 50, top: 100,),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18)
            ,),
            padding: const EdgeInsets.all(15),
            child: Text(dashboardParams.issueSummary.issuesOldTitle),),
        ),
        Container(
            margin: const EdgeInsets.only(bottom: 75, left: 120),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18)
            ,),
            padding: const EdgeInsets.all(15),
            child: Text(dashboardParams.issueSummary.issuesHighActivity),),
        Container(
            margin: const EdgeInsets.only(bottom: 75, left: 120),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18)
            ,),
            padding: const EdgeInsets.all(15),
            child: Text(dashboardParams.issueSummary.issuesLowActivity),),
        Container(
            margin: const EdgeInsets.only(left: 120),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18)
            ,),
            padding: const EdgeInsets.all(15),
            child: Text(dashboardParams.issueSummary.issuesLabeled),),
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
            height: myHeight/2,
            width: myWidth/2,
            margin: const EdgeInsets.only(top:125),
            child: MyLineChart(cache: cache,) ,
          )
        ],
      ),
    );
  }

  Widget thirdColumn(BuildContext context,
      DashboardParameterList dashboardParams,) {
    return Expanded(
      child:
      Column(
        children: [
          Container(
              margin: const EdgeInsets.only(bottom: 75, top: 100, right: 120),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18)
              ,),
              padding: const EdgeInsets.all(15),
              child: Text(dashboardParams.pullRequestSummary.pullsOldTitle),),
          Container(
              margin: const EdgeInsets.only(bottom: 75, right: 120),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18)
              ,),
              padding: const EdgeInsets.all(15),
              child: Text(
                  dashboardParams.pullRequestSummary.pullsHighActivity,),),
          Container(
              margin: const EdgeInsets.only(bottom: 75, right: 120),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18)
              ,),
              padding: const EdgeInsets.all(15),
              child: Text(
                  dashboardParams.pullRequestSummary.pullsLowActivity,),),
          Container(
              margin: const EdgeInsets.only( right: 120),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18)
              ,),
              padding: const EdgeInsets.all(15),
              child: Text(dashboardParams.pullRequestSummary.pullsLabeled),),
        ],
      ),
    );
  }

  Widget firstRow(BuildContext context, double width, double height,
      DashboardParameterList dashboardParams,) {

    return Expanded(child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18)
        ,),
        height: double.maxFinite,
        child: Row(children: [
          const Spacer(),
          SizedBox(
            width: width/4,
            child:
             GestureDetector(
              onTap: () => {
              Navigator.of(context).pushReplacementNamed(
                RouteGenerator.issueDetailPage,)
               }, child:
              Text(
              dashboardParams.issueSummary.totalIssueTitle +
                dashboardParams.issueSummary.totalIssue,),),),
          SizedBox(
            width: width/4,
            child:
            Text(
              dashboardParams.issueSummary.dormantIssueTitle +
                dashboardParams.issueSummary.totalDormantIssue,),),
          SizedBox(
            width: width/4,
            child:
            Text(
              dashboardParams.pullRequestSummary.dormantPullTitle +
                dashboardParams.pullRequestSummary.totalClosedPull,)
            ,),
          Expanded(child: Text(
              dashboardParams.pullRequestSummary.totalIPullTitle +
              dashboardParams.pullRequestSummary.totalPull,),
          ),
        ],),),
    );
  }

  Widget secondRow(BuildContext context, double width, double height,
      DashboardParameterList dashboardParams,) {
    return SizedBox(
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
///Class that creates and displays the line chart found in the repo page

class MyLineChart extends StatelessWidget{
  ///Constructor

  MyLineChart({Key? key, required this.cache}) : super(key: key);
  ///Instance of our admin dashboard cache

  final AdminDashboardCache cache;
  ///Data that is used in the chart (hardcoded for now)

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
            lineBarsData: [
              LineChartBarData(
                  spots: createPoints()
              ,)
            ],
            gridData: FlGridData(
                show: true,
                getDrawingHorizontalLine: (value){
                  return FlLine(
                    color: Colors.black,
                    strokeWidth: 1,
                  );
                }
            ,)
        ,)
    ,);
  }
  ///Creates the points used in the line chart
  List<FlSpot> createPoints() {
    ///List of spots to be used in the line chart
    final result = <FlSpot>[];
    for(final x in data.keys)
    {
      result.add(FlSpot(x, data[x]??0));
    }
    return result;
  }
}
