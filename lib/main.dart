import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sanai3i/files/database.dart';
import 'files/mainNavigation.dart';
import 'package:sanai3i/files/landing.dart';

void main() => runApp(Sanai3i());

class Sanai3i extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: (){
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasFocus) {
          currentFocus.unfocus();
        }
      },
      child: StreamProvider<FirebaseUser>.value(
        value: DatabaseService().userState,
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(fontFamily: 'TajawalRegular'),
          home: Wrapper(),
        ),
      ),
    );
  }
}

class Wrapper extends StatefulWidget {
  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {

  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

      final userState = Provider.of<FirebaseUser>(context);
      if (userState == null) {  return LoginScreen();    }
      if (userState != null) {  return MainNavigation(); }

    return Material(
      child: Container(
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Center(
              child: Image.asset('images/logo.png'),),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Center(
                child: CircularProgressIndicator(),),
            ),
            Center(
              child: Text('تأكد من اتصالك'),),
          ],
        ),
      ),
    );
  }
}
