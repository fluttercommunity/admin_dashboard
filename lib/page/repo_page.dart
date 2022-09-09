import 'package:admin_dashboard/dto/admin_dashboard_cache_model.dart';
import 'package:admin_dashboard/dto/constant.dart';
import 'package:admin_dashboard/dto/repo_model.dart';
import 'package:admin_dashboard/page/drawer_widget.dart';
import 'package:admin_dashboard/page/repo_list_element.dart';
import 'package:admin_dashboard/provider/provider_list.dart';
import 'package:admin_dashboard/service/fire_base.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

///Repository page where a list of all repos in an org is displayed
class RepoPage extends ConsumerWidget{
  ///Constructor
  const RepoPage( {required this.firebaseApp});
  ///Instance of firebase App
  final FirebaseApp firebaseApp;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cache = ref.read(cacheProvider);
    return RepoPageWidget(firebaseApp: firebaseApp, cache: cache);
  }

}

///state of the repo page
class RepoPageWidget extends StatefulWidget {
  ///repo page constructor
  const RepoPageWidget({
    Key? key,
    //required this.fire,
    required this.firebaseApp,
    required this.cache,
  }) : super(key: key);

  ///Instance of firebaseApp
  final FirebaseApp firebaseApp;
  ///Instance of the admin dashboard cache
  final AdminDashboardCache cache;

  @override
  State<RepoPageWidget> createState() => _RepoPageWidgetState(
      firebaseApp,cache,);
}

class _RepoPageWidgetState extends State<RepoPageWidget> {
  _RepoPageWidgetState( //this.fire,
      this.firebaseApp, this.cache,);
  late Future<List<SimpleRepo>> myTitleList;

  //BasicServiceInterface fire;
  FirebaseApp firebaseApp;
  final AdminDashboardCache cache;

  @override
  void initState() {
    super.initState();
    myTitleList = printRepos(context);
  }
  @override
  Widget build(BuildContext context) {
    printRepos(context);
    return  Scaffold(
      drawer: DrawerWidget(//fire,
        firebaseApp,),
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: const Text(Constants.repoTitle),
      ),
      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(8),
        child: FutureBuilder<List<SimpleRepo>>(
          future: myTitleList,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                return ListView(
                  children: _buildList(snapshot.data!.toList()),
                );
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }
            }
            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }
  Future<List<SimpleRepo>> printRepos(BuildContext context) async {
    if(cache.myTitleList.isNotEmpty) {
      return cache.myTitleList;
    }
    FireBaseService fireBaseService;
    fireBaseService = FireBaseService(firebaseApp);
    final list = await fireBaseService.getAllRepos(
      context,
      cache,
    );
    cache.myTitleList = list;
    return list;
  }

  List<Widget> _buildList(List<SimpleRepo> list) {
    list.sort();
    var index = 0;
    final result = <Widget>[];
    for (final simpleRepo in list) {
      final element = SimpleRepoElement(index,simpleRepo, cache);
      index++;
      result.add(element);
    }
    return result;
  }
}

///Our repository object that is used in the repository page
class SimpleRepoElement extends StatelessWidget {
  ///SimpleRepo constructor
  const SimpleRepoElement(this.index,this.simpleRepo, this.cache, {Key? key})
      : super(key: key);
  ///Our cache that is used throughout the application, the list of retrieved
  ///repositories gets stored in the cache
  final AdminDashboardCache cache;
  ///SimpleRepo object that is used in the repository page
  final SimpleRepo simpleRepo;
  ///Index used in the repo page to know which repo has been selected by the
  ///user
  final int index;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final element = RepoListElement(simpleRepo, width, index);
    return element.build(context, cache);
  }
}
