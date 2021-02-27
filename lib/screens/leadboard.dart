import 'package:flutter/material.dart';

class LeadPage extends StatefulWidget {
  final String title; // receives the value
  final List widgetList;
  LeadPage({Key key, this.title, this.widgetList}) : super(key: key);

  @override
  _LeadPageState createState() => _LeadPageState();
}

class _LeadPageState extends State<LeadPage> {
  @override
  Widget build(BuildContext context) {
    String title = widget.title;
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        centerTitle: true,
      ),
      body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: SingleChildScrollView(
              child: Column(
            children: widget.widgetList,
          ))),
    );
  }
}

class LeadCard extends StatelessWidget {
  final String name;
  final String score;
  final String time;
  final int rank;

  LeadCard({this.name, this.score, this.time, this.rank});
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.98,
      child: Card(
        color: Colors.white70,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '$name',
                style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.w900,
                    color: Colors.redAccent),
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    'Score : $score',
                    style: TextStyle(fontWeight: FontWeight.w900),
                  ),
                  Spacer(),
                  Text(
                    'time : $time',
                    style: TextStyle(fontWeight: FontWeight.w900),
                  ),
                ],
              ),
              Row(
                children: [
                  Tab(
                    icon: Image.asset(
                      'assets/images/crown.png',
                      height: 30,
                    ),
                  ),
                  Text(
                    '  $rank',
                    style: TextStyle(
                        fontWeight: FontWeight.w900, color: Colors.redAccent),
                  ),
                  SizedBox(
                    height: 10.0,
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
