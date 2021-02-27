import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class FireStore {
  String _getTime() {
    String formattedDateTime =
        DateFormat('yyyy-MM-dd-kk:mm:ss').format(DateTime.now()).toString();
    return formattedDateTime;
  }

  void inspector(CollectionReference collectionReference, String collection,
      String score, String name) async {
    await collectionReference
        .doc(collection)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        print(score);
        collectionReference
            .doc(collection)
            .get()
            .then((DocumentSnapshot documentSnapshot) {
          if (int.parse(documentSnapshot.data()['highestScore']) <
              int.parse(score)) {
            collectionReference.doc(collection).update({'highestScore': score});
            collectionReference.doc(collection).update({'winner': name});
            print(score);
          } else if (int.parse(documentSnapshot.data()['lowestScore']) >
              int.parse(score)) {
            collectionReference.doc(collection).update({'lowestScore': score});
            print(score);
          }
        });
      } else {
        collectionReference.doc(collection.toLowerCase()).set({
          'highestScore': score,
          'lowestScore': score,
          'gameName': collection.toLowerCase(),
          'winner': name
        });
      }
    });
  }

  void addData(String document, String score, String data, context) async {
    bool updateToken = true;
    CollectionReference gameList =
        FirebaseFirestore.instance.collection('gameList');

    inspector(gameList, document.toLowerCase(), score, data.toLowerCase());

    CollectionReference coll =
        FirebaseFirestore.instance.collection('gameData');
    List listData = await coll
        .doc(document.toLowerCase())
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      print("<<<<<<<<< ${documentSnapshot.data()}");
      if (documentSnapshot.exists) {
        print("<<<<<<<<< ${documentSnapshot.data()}");
        List listData = documentSnapshot.data()[score];
        if (listData != null) {
          print("<<<<<<<<<< $listData");
          return listData;
        } else {
          List listData = [];
          return listData;
        }
      } else {
        List listData = [];
        updateToken = false;
        return listData;
      }
    });
    listData
        .add({'name': data.toLowerCase(), 'time': _getTime(), 'score': score});
    var jsonData = {score: listData};

    if (updateToken) {
      coll
          .doc(document.toLowerCase())
          .update(jsonData)
          .then((value) => Scaffold.of(context).showSnackBar(
              SnackBar(content: Text('Score Added Success Fully'))))
          .catchError((error) => print("Failed to add user: $error"));
    } else {
      coll
          .doc(document.toLowerCase())
          .set(jsonData)
          .then((value) => Scaffold.of(context).showSnackBar(
              SnackBar(content: Text('Score Added Success Fully'))))
          .catchError((error) => print("Failed to add user: $error"));
    }
  }
}
