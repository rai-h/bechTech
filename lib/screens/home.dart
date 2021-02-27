import 'package:bench_tech/screens/loaddata.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  CollectionReference collectionReference =
      FirebaseFirestore.instance.collection('gameList');

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        child: StreamBuilder<QuerySnapshot>(
            stream: collectionReference.snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: Text('Loading...'),
                );
              } else {
                List documents = snapshot.data.docs;
                print(documents.length);
                return ListView.builder(
                    itemCount: documents.length,
                    itemBuilder: (_, index) {
                      return HomeCard(
                        firstPer: documents[index]['winner'],
                        highScr: documents[index]['highestScore'],
                        lowScr: documents[index]['lowestScore'],
                        gameName: documents[index]['gameName'],
                      );
                    });
              }
            }),
      ),
    );
  }
}

class HomeCard extends StatelessWidget {
  final String highScr;
  final String lowScr;
  final String firstPer;
  final String gameName;
  HomeCard({this.firstPer, this.highScr, this.lowScr, this.gameName});
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
                '$gameName',
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
                    'Highest Score : $highScr',
                    style: TextStyle(fontWeight: FontWeight.w900),
                  ),
                  Spacer(),
                  Text(
                    'Lowest Score : $lowScr',
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
                    '  $firstPer',
                    style: TextStyle(
                        fontWeight: FontWeight.w900, color: Colors.redAccent),
                  ),
                  Spacer(),
                  InkWell(
                    child: Text(
                      'See LeadersBoard >',
                      style: TextStyle(
                          fontWeight: FontWeight.w900,
                          color: Colors.blueAccent),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) => LoadData(
                            title: gameName,
                          ),
                        ),
                      );
                    },
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
