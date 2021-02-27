import 'package:flutter/material.dart';
import 'package:bench_tech/firestore.dart';

class AddScorePage extends StatefulWidget {
  @override
  _AddScorePageState createState() => _AddScorePageState();
}

class _AddScorePageState extends State<AddScorePage> {
  TextEditingController _userNameController = TextEditingController();
  TextEditingController _gameNameController = TextEditingController();
  TextEditingController _scoreController = TextEditingController();
  FireStore fireStore = FireStore();
  final _loginformkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Center(
      child: Container(
        // color: Colors.amber,
        width: size.width * 0.9,
        child: Form(
          key: _loginformkey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: _gameNameController,
                validator: (value) {
                  if (value.length >= 3) {
                    // print();
                    return null;
                  } else
                    return 'Game Name should be of atleast 3 characters.';
                },
                decoration: InputDecoration(
                  // prefixIcon: Icon(Icons.lock),
                  hintText: 'Game Name',

                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                      borderSide:
                          BorderSide(color: Colors.blueAccent, width: 3)),
                  errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                      borderSide: BorderSide(color: Colors.red, width: 3)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                      borderSide:
                          BorderSide(color: Colors.redAccent, width: 3)),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: _userNameController,
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
                      borderSide:
                          BorderSide(color: Colors.blueAccent, width: 3)),
                  errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                      borderSide: BorderSide(color: Colors.red, width: 3)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                      borderSide:
                          BorderSide(color: Colors.redAccent, width: 3)),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: _scoreController,
                keyboardType: TextInputType.numberWithOptions(),
                validator: (value) {
                  if (value.length <= 3 && value.length >= 1) {
                    print('sdhaksdjhf');
                    return null;
                  } else
                    return 'Please enter a score between 0-999';
                },
                decoration: InputDecoration(
                  // prefixIcon: Icon(Icons.lock),
                  hintText: 'Score',
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                      borderSide:
                          BorderSide(color: Colors.blueAccent, width: 3)),
                  errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                      borderSide: BorderSide(color: Colors.red, width: 3)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                      borderSide:
                          BorderSide(color: Colors.redAccent, width: 3)),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                width: size.width * 0.5,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(40),
                  child: FlatButton(
                    padding: EdgeInsets.symmetric(
                      vertical: 12.0,
                    ),
                    onPressed: () async {
                      FocusScopeNode currentFocus = FocusScope.of(context);
                      if (_loginformkey.currentState.validate()) {
                        if (!currentFocus.hasPrimaryFocus) {
                          currentFocus.unfocus();
                          fireStore.addData(
                              _gameNameController.text,
                              _scoreController.text,
                              _userNameController.text,
                              context);
                          _gameNameController.clear();
                          _scoreController.clear();
                          _userNameController.clear();
                        }
                      }
                    },
                    child: Text(
                      'Add Score',
                      style: TextStyle(
                        fontSize: size.width * 0.044,
                        color: Colors.white,
                      ),
                    ),
                    color: Colors.redAccent,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
