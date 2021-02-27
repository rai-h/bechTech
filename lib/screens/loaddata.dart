import 'package:bench_tech/screens/leadboard.dart';
import 'package:bench_tech/sortingdata.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class LoadData extends StatefulWidget {
  final String title; // receives the value

  LoadData({Key key, this.title}) : super(key: key);
  @override
  _LoadDataState createState() => _LoadDataState();
}

class _LoadDataState extends State<LoadData> {
  Sorting sorting = Sorting();

  dataList(title) async {
    var documents = await FirebaseFirestore.instance
        .collection('gameData')
        .doc(title)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      return documentSnapshot.data();
    });
    var list = sorting.sortData(documents);
    return list;
  }

  void widgetList(title) async {
    var datalist = await dataList(title);

    List<Widget> widgetList = [];
    int count = 0;
    for (var i in datalist) {
      widgetList.add(LeadCard(
        name: i['name'],
        score: i['score'],
        time: i['time'],
        rank: count,
      ));
      count = count + 1;
      if (count == 10) {
        break;
      }
      Navigator.pop(context);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => LeadPage(
            title: title,
            widgetList: widgetList,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    widgetList(widget.title);
    return Scaffold(
      body: Center(
        child: Container(
          child: Text('Please Wait....'),
        ),
      ),
    );
  }
}
