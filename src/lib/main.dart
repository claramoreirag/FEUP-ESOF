import 'package:flutter/material.dart';
import 'add_tags.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart'; 
import 'authenticate/authentication.dart';
import 'package:provider/provider.dart';

void main(){
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  runApp(App());
} 

class App extends StatelessWidget {

  // Create the initialization Future outside of `build`:
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return  MultiProvider(
      providers: [
        Provider<Authenticator>(
          create: (_) => Authenticator(FirebaseAuth.instance),
          ),//Provider
        StreamProvider(
          create: (context) => context.read<Authenticator>().authStateChanges,
        )
      ],


      child: MaterialApp(
        title: 'Flutter Time Picker example',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: AuthenticationWrapper(),
      )

    );


    /*
    return FutureBuilder(
      // Initialize FlutterFire:
      future: _initialization,
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          return Container(
            decoration: BoxDecoration(color: Colors.red),
          );
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return Login();
        }

        // Otherwise, show something whilst waiting for initialization to complete
        return Container(
          decoration: BoxDecoration(color: Colors.deepPurple),
        );
      },
    );
    * */
  }
}

class AuthenticationWrapper extends StatelessWidget {
  const AuthenticationWrapper({Key key,}) : super(key : key);

  @override
  Widget build(BuildContext context){
    final firebaseUser =  context.watch<User>();

    if(firebaseUser != null){
      return MyApp();
    }
    return Login();
  }

}

class Login extends StatefulWidget {
  Login({Key key, this.title}) : super(key: key);

  final String title;
  @override
  _Login createState() => _Login();
}

/* 
class DatePicker extends StatefulWidget {
  DatePicker({Key key}) : super(key: key);

  @override
  _DatePickerState createState() => _DatePickerState();
}



class _TimePickerState extends State<TimePicker> {
  final timeController = TextEditingController();
  final dateController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is removed
    timeController.dispose();
    dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Center(
        children: newColumn(
          [
        children: TextField(
        readOnly: true,
        controller: timeController,
        decoration: InputDecoration(hintText: 'Pick your Time'),
        onTap: () async {
          var time = await showTimePicker(
            initialTime: TimeOfDay.now(),
            context: context,
          );
          timeController.text = time.format(context);
        },
      )])),
    );
  }
} */

class _Login extends State<Login> {
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();



  @override
  Widget build(BuildContext context) {
    final emailField = TextField(
      controller: emailController,
      obscureText: false,
      style: style,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Email",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );
    final passwordField = TextField(
      controller: passwordController,
      obscureText: true,
      style: style,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Password",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );
    final loginButton = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Color(0xff01A0C7),
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () async {
        //  Navigator.push(

            context.read<Authenticator>().signIn(
              email: emailController.text.trim(),
              password: passwordController.text.trim()
            );
            //MaterialPageRoute(builder: (context) => MyApp()),
          //);
        },
        child: Text("Login",
            textAlign: TextAlign.center,
            style: style.copyWith(
                color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );

    final forgotPassword = FlatButton(
                  onPressed: (){
                    //forgot password screen
                  },
                  textColor: Colors.blue,
                  child: Text('Forgot your password?'),
    );

    final signUp = Container(
                    child: Row(
                      children: <Widget>[
                        Text('Don\'t have an account yet?'),
                        FlatButton(
                          textColor: Colors.blue,
                          child: Text(
                            'Sign up',
                            style: TextStyle(fontSize: 20),
                          ),
                          onPressed: () {
                            //signup screen
                          },
                        )
                      ]
                    )  
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(36.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 155.0,
                  child: Image.asset(
                    "assets/logo.png",
                    fit: BoxFit.contain,
                  ),
                ),
                SizedBox(height: 45.0),
                emailField,
                SizedBox(height: 25.0),
                passwordField,
                SizedBox(
                  height: 35.0,
                ),
                loginButton,
                SizedBox(
                  height: 15.0,
                ),
                forgotPassword, 
                signUp,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
