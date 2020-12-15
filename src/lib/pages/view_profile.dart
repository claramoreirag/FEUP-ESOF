import 'package:flutter/material.dart';

class ViewProfile extends StatefulWidget {
  @override
  _ViewProfile createState() => _ViewProfile();
}

class _ViewProfile extends State<ViewProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Profile'),
          centerTitle: true,
        ),
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CircleAvatar(
                // backgroundImage: AssetImage('no'),
                radius: 50,
              ),
              Text(
                'Nome',
                style: TextStyle(
                  fontSize: 35.0,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Type of User',
                style: TextStyle(
                    fontSize: 15.0,
                    color: Colors.blueGrey,
                    letterSpacing: 2.0,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 20,
                width: 200,
                child: Divider(
                  color: Colors.blue,
                ),
              ),
              Card(
                  color: Colors.white,
                  margin:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
                  child: ListTile(
                      leading: Icon(
                        Icons.pin_drop_outlined,
                        color: Colors.black,
                      ),
                      title: Text('Location',
                          style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.black,
                          )))),
              Card(
                  color: Colors.white,
                  margin:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
                  child: ListTile(
                    leading: Icon(
                      Icons.phone,
                      color: Colors.black,
                    ),
                    title: Text(
                      'Phone Number',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20.0,
                      ),
                    ),
                  )),
              Card(
                  color: Colors.white,
                  margin:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
                  child: ListTile(
                      leading: Icon(
                        Icons.email,
                        color: Colors.black,
                      ),
                      title: Text('test@gmail.com',
                          style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.black,
                          )))),
              Card(
                  color: Colors.white,
                  margin:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
                  child: ListTile(
                      leading: Icon(
                        Icons.work_outline_rounded,
                        color: Colors.black,
                      ),
                      title: Text('LinkedIn Profile Link',
                          style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.black,
                          )))),
              Card(
                  color: Colors.white,
                  margin:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
                  child: ListTile(
                      leading: Icon(
                        Icons.picture_as_pdf_outlined,
                        color: Colors.black,
                      ),
                      title: Text('CV PDF Format',
                          style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.black,
                          )))),
            ],
          ),
        ));
  }
}
