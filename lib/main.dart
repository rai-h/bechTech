import 'package:bench_tech/screens/add_score.dart';
import 'package:bench_tech/screens/home.dart';

import 'package:bench_tech/screens/search.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(new MyApp());
  });
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  int _selectedIndex = 1;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  static List<Widget> _widgetOptions = <Widget>[
    SearchPage(),
    HomePage(),
    AddScorePage()
  ];
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          // title: _widgetTitleOptions.elementAt(_selectedIndex),
          centerTitle: true,
          backgroundColor: Colors.blueAccent,
        ),
        body: _widgetOptions.elementAt(_selectedIndex),
        bottomNavigationBar: BottomNavigationBar(
            unselectedItemColor: Colors.grey,
            showSelectedLabels: false,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                label: 'search',
                icon: Icon(Icons.search),
              ),
              BottomNavigationBarItem(
                label: 'home',
                icon: Icon(Icons.home),
              ),
              BottomNavigationBarItem(
                label: 'add',
                icon: Icon(Icons.add_circle_rounded),
              ),
            ],
            type: BottomNavigationBarType.shifting,
            currentIndex: _selectedIndex,
            selectedItemColor: Colors.blueAccent,
            onTap: _onItemTapped,
            iconSize: 30,
            elevation: 15),
      ),
    );
  }
}
