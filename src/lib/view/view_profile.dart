import 'package:flutter/material.dart';
import 'package:hello/controller/firestoreService.dart';
import 'package:hello/controller/locator.dart';
import '../model/person.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ViewProfile extends StatefulWidget {
  @override
  _ViewProfile createState() => _ViewProfile();
}

class _ViewProfile extends State<ViewProfile> {
  @override
  Widget build(BuildContext context) {
    Atendee u;

    return Scaffold(
        appBar: AppBar(
          title: Text('Profile'),
          centerTitle: true,
        ),
        body: SafeArea(
          child: FutureBuilder(
              future: locator<FirestoreService>()
                  .getUser(FirebaseAuth.instance.currentUser.uid)
                  .then((value) {
                u = value;
              }),
              builder: (_, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: Text("Loading..."),
                  );
                } else {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      CircleAvatar(
                        // backgroundImage: AssetImage('no'),
                        radius: 50,
                      ),
                      Text(
                        u.fullName,
                        style: TextStyle(
                          fontSize: 35.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        u.userRole,
                        style: TextStyle(
                            fontSize: 15.0,
                            color: Colors.red[300],
                            letterSpacing: 2.0,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 20,
                        width: 200,
                        child: Divider(
                          color: Colors.red[300],
                        ),
                      ),
                      Card(
                          color: Colors.white,
                          margin: EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 25.0),
                          child: ListTile(
                              leading: Icon(
                                Icons.pin_drop_outlined,
                                color: Colors.red[400]
                              ),
                              title: Text(u.location,
                                  style: TextStyle(
                                    fontSize: 20.0,
                                    color: Colors.black,
                                  )))),
                      Card(
                          color: Colors.white,
                          margin: EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 25.0),
                          child: ListTile(
                            leading: Icon(
                              Icons.phone,
                              color: Colors.red[400]
                            ),
                            title: Text(
                              u.phoneNumber,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20.0,
                              ),
                            ),
                          )),
                      Card(
                          color: Colors.white,
                          margin: EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 25.0),
                          child: ListTile(
                              leading: Icon(
                                Icons.email,
                                color: Colors.red[400]
                              ),
                              title: Text(u.email,
                                  style: TextStyle(
                                    fontSize: 20.0,
                                    color: Colors.black,
                                  )))),
                    ],
                  );
                }
              }),
        ));
  }
}
