import 'package:admin_dashboard/dto/admin_dashboard_cache_model.dart';
import 'package:admin_dashboard/dto/repo_model.dart';
import 'package:admin_dashboard/page/drawer_widget.dart';
import 'package:admin_dashboard/provider/provider_list.dart';
import 'package:admin_dashboard/route/routes.dart';
import 'package:admin_dashboard/service/dashboard_services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

///Repo page that is displayed on mobile
class NarrowRepoPage extends ConsumerWidget {

  ///Constructor for narrow page
  const NarrowRepoPage(
      this.firebaseApp, this.simpleRepo, this.myWidth, this.myHeight,);

  ///instance of firebaseApp
  final FirebaseApp firebaseApp;

  ///Instance of simple repo
  final SimpleRepo simpleRepo;

  ///Width of the screen
  final double myWidth;
  ///Height of the screen
  final double myHeight;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cache = ref.read(cacheProvider);
    final dashboardProvider = ref.read(myDashboardProvider);
    return MobileSummaryDashboard(
        cache, firebaseApp, dashboardProvider, myWidth, myHeight,);
  }
}

///The dashboard for mobile devices
class MobileSummaryDashboard extends StatefulWidget {

  ///Constructor for mobile summary page
  const MobileSummaryDashboard(this.cache, this.firebaseApp,
      this.dashboardProvider,
      this.myWidth, this.myHeight,);

  ///Instance of admin dashboard cache
  final AdminDashboardCache cache;
  ///Instance of firebase app
  final FirebaseApp firebaseApp;
  ///Instance of dashboard provider
  final DashboardServiceInterface dashboardProvider;
  ///Width of the screen
  final double myWidth;
  ///Height of the screen
  final double myHeight;


  @override
  State<StatefulWidget> createState() {
    return _MobileSummaryDashboard(cache, firebaseApp,
        dashboardProvider, myWidth, myHeight,);
  }
}

class _MobileSummaryDashboard extends State<MobileSummaryDashboard> {
  _MobileSummaryDashboard(this.cache, this.firebaseApp, this.dashboardProvider,
      this.myWidth, this.myHeight,);

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
    return Scaffold(
        drawer: DrawerWidget(
          firebaseApp,
        ),
        appBar: AppBar(
          backgroundColor: Colors.deepPurpleAccent,
        ),
        body:  FutureBuilder<DashboardParameterList>(
          future: params,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                final dashboardParams = snapshot.data!;
                return scrollView(context, dashboardParams);

              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }
            }
            return const CircularProgressIndicator();
          },
        )
    ,);
  }

  Widget scrollView(
      BuildContext context, DashboardParameterList dashboardParams,) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            width: double.infinity,
            height: myHeight / 10,
            color: Colors.white,
            child: GestureDetector(
              onTap: () => {
                Navigator.of(context).pushReplacementNamed(
                  RouteGenerator.issueDetailPage,)
              },
              child:
            Card(
                color: Colors.blueAccent,
                child: Center(
                    child: Text(dashboardParams.issueSummary.issuesOldTitle)
                ,)
            ,),
           ),
          ),
          Container(
            width: double.infinity,
            height: myHeight / 10,
            color: Colors.white,
            child: Card(
                color: Colors.deepPurpleAccent,
                child: Center(
                  child: Text(dashboardParams.issueSummary.issuesHighActivity),
                ),),
          ),
          Container(
            width: double.infinity,
            height: myHeight / 10,
            color: Colors.white,
            child: Card(
                color: Colors.blueAccent,
                child: Center(
                  child: Text(dashboardParams.issueSummary.issuesLowActivity),
                ),),
          ),
          Container(
            width: double.infinity,
            height: myHeight / 10,
            color: Colors.white,
            child: Card(
                color: Colors.deepPurpleAccent,
                child: Center(
                  child: Text(dashboardParams.issueSummary.issuesLabeled),
                ),),
          ),
          Container(
            width: double.infinity,
            height: myHeight / 2,
            color: Colors.white,
            child: Card(
                color: Colors.white,
                child: MyLineChart(
                  cache: cache,
                ),),
          ),
          Container(
            width: double.infinity,
            height: myHeight / 10,
            color: Colors.white,
            child: Card(
              color: Colors.blueAccent,
              child: Center(child: Center(
                child: Text(dashboardParams.pullRequestSummary.pullsOldTitle),
              ),
              ),
            ),
          ),
          Container(
            width: double.infinity,
            height: myHeight / 10,
            color: Colors.white,
            child: Card(
                color: Colors.deepPurpleAccent,
                child: Center(child: Text(
                    dashboardParams.pullRequestSummary.pullsHighActivity,),),),
          ),
          Container(
            width: double.infinity,
            height: myHeight / 10,
            color: Colors.white,
            child: Card(
                color: Colors.blueAccent,
                child: Center(child: Text(
                    dashboardParams.pullRequestSummary.pullsLowActivity,),),),
          ),
          Container(
            width: double.infinity,
            height: myHeight / 10,
            color: Colors.white,
            child: GestureDetector(
              onTap: () =>{
                Navigator.of(context).pushReplacementNamed(
                    RouteGenerator.issueDetailPage,)
              },
              child: Card(
                  color: Colors.deepPurpleAccent,
                  child: Center(child: Text(
                      dashboardParams.pullRequestSummary.pullsLabeled,),),),
            ),
          ),
        ],
      ),
    );
  }
}
///Class that creates and displays the line chart found in the repo page
class MyLineChart extends StatelessWidget {
  ///Constructor
  MyLineChart({Key? key, required this.cache}) : super(key: key);

  ///Instance of our admin dashboard cache
  final AdminDashboardCache cache;

  ///Data that is used in the chart (hardcoded for now)
  final data = <double, double>{
    0: 0, 1: 0.75, 2: 3, 3: 1.2, 4: 1, 5: 5
  };

  @override
  Widget build(BuildContext context) {
    return LineChart(LineChartData(
        minX: 0,
        maxX: 5,
        minY: 0,
        maxY: 5,
        lineBarsData: [LineChartBarData(spots: createPoints())],
        gridData: FlGridData(
            show: true,
            getDrawingHorizontalLine: (value) {
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
    for (final x in data.keys) {
      result.add(FlSpot(x, data[x] ?? 0));
    }
    return result;
  }
}
