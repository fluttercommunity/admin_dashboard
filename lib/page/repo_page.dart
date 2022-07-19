import 'package:admin_dashboard/dto/admin_dashboard_cache_model.dart';
import 'package:admin_dashboard/dto/constant.dart';
import 'package:admin_dashboard/dto/repo_model.dart';
import 'package:admin_dashboard/page/drawer_widget.dart';
import 'package:admin_dashboard/service/fire_base.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';


///state of the repo page
class RepoPage extends StatefulWidget {
  ///repo page constructor
  const RepoPage({
    Key? key,
    required this.cache,
    //required this.fire,
    required this.firebaseApp,
  }) : super(key: key);

  ///Instance of firebaseApp
  final FirebaseApp firebaseApp;

  ///cache where the logged in user's ID is stored
  final AdminDashboardCache cache;
  ///instance to handle firebase services
  //final BasicServiceInterface fire;

  @override
  State<RepoPage> createState() => _RepoPageState(cache, //fire,
      firebaseApp,);
}

class _RepoPageState extends State<RepoPage> {
  _RepoPageState(this.cache, //this.fire,
      this.firebaseApp,);
  late Future<List<SimpleRepo>> myTitleList;
  AdminDashboardCache cache;
  //BasicServiceInterface fire;
  FirebaseApp firebaseApp;

  @override
  void initState() {
    super.initState();
    myTitleList = printRepos(context);
  }
  @override
  Widget build(BuildContext context) {
    printRepos(context);
    return  Scaffold(
      drawer: DrawerWidget(cache, //fire,
          firebaseApp,),
      appBar: AppBar(
        backgroundColor: Colors.blue,
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
    final result = <Widget>[];
    for (final simpleRepo in list) {
      final element = SimpleRepoElement(simpleRepo, cache);
      result.add(element);
    }
    return result;
  }
}

///Our repository object that is used in the repository page
class SimpleRepoElement extends StatelessWidget {
  ///SimpleRepo constructor
  const SimpleRepoElement(this.simpleRepo, this.cache, {Key? key})
  : super(key: key);
  ///Our cache that is used throughout the application, the list of retrieved
  ///repositories gets stored in the cache
  final AdminDashboardCache cache;
  ///SimpleRepo object that is used in the repository page
  final SimpleRepo simpleRepo;
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return ElevatedButton(
      onPressed: () {  },
      style: ElevatedButton.styleFrom(
          primary: Colors.blue, // background (button) color
        onPrimary: Colors.black,// background (text) color
        maximumSize: Size(width*0.7, 80),
     ), child: Text(' ${simpleRepo.name}'),);
  }
}
