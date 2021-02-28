import 'package:bench_tech/screens/home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  List<Widget> newWidgetList = [];
  void _searchFunc() {
    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection('gameList');
    collectionReference
        .doc(_searchController.text.trim().toLowerCase())
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        setState(() {
          newWidgetList = [
            HomeCard(
              firstPer: documentSnapshot.data()['winner'],
              gameName: documentSnapshot.data()['gameName'],
              highScr: documentSnapshot.data()['highestScore'],
              lowScr: documentSnapshot.data()['lowestScore'],
            )
          ];
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        child: Column(
          children: [
            TextFormField(
              controller: _searchController,
              validator: (value) {
                if (value.length >= 3) {
                  // print();
                  return null;
                } else
                  return 'Username should be of atleast 3 characters.';
              },
              decoration: InputDecoration(
                // prefixIcon: Icon(Icons.lock),
                hintText: 'Username',

                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    borderSide: BorderSide(color: Colors.blueAccent, width: 3)),
                errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    borderSide: BorderSide(color: Colors.red, width: 3)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    borderSide: BorderSide(color: Colors.redAccent, width: 3)),
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Container(
              width: size.width * 0.5,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(40),
                child: FlatButton(
                  padding: EdgeInsets.symmetric(
                    vertical: 12.0,
                  ),
                  onPressed: _searchFunc,
                  child: Text(
                    'Search Game',
                    style: TextStyle(
                      fontSize: size.width * 0.044,
                      color: Colors.white,
                    ),
                  ),
                  color: Colors.redAccent,
                ),
              ),
            ),
            Column(
              children: newWidgetList,
            )
          ],
        ),
      ),
    );
  }
}
