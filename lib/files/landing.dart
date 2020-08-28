import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sanai3i/files/reusable.dart';
import 'loginSignup.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  int bottomIndex = 1;
  double logoH = 150 ;

  @override
  Widget build(BuildContext context) {
    var screenData = MediaQuery.of(context);

    Widget _buildContent(BuildContext context) {
      switch (bottomIndex) {
        case 0:
          return SignUp();
        case 1:
          return Login();
        default:
          return Text('Error 404');
      }
    }

    return Scaffold(
      backgroundColor: Color(0xffE4E6EB),
      body: Column(
        children: <Widget>[
          SizedBox(height: screenData.size.height / 25),
          Expanded(
            child: Container(
              width: screenData.size.width ,
              margin: EdgeInsets.fromLTRB(6, 3, 6, 2),
              decoration: containerDecoration(Color(0xffF6F6F6)),
              child: Column(
                children: <Widget>[
                  FadeY(
                    delay: 1.0,
                    duration: Duration(milliseconds: 350),
                    child: AnimatedContainer(
                      width: screenData.size.width,
                      curve: Curves.easeOutBack,
                      height: logoH,
                      duration: Duration(milliseconds: 400),
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('images/sanai3i.png', ),
                          fit: BoxFit.contain
                        ),
                      ),
                    ),
                  ),
                  _buildContent(context),
                ],
              ),
            ),
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: InkWell(
                  onTap: () {
                    setState(() {
                      bottomIndex = 0;
                      logoH = 120 ;
                    });
                  },
                  child: AnimatedContainer(
                    margin: EdgeInsets.fromLTRB(10, 3, 10, 5),
                    height: 35,
                    duration: Duration(milliseconds: 450),
                    decoration: btnDecoration(bottomIndex == 0 ? kActiveBtnColor : Colors.white,30),
                    curve: Curves.easeOutBack,
                    child: Center(
                      child: Text('حساب جديد',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold,
                            color: bottomIndex == 0 ? Colors.white : Colors.black),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: InkWell(
                  onTap: () {
                    setState(() {
                      bottomIndex = 1;
                      logoH = 150 ;
                    });
                  },
                  child: AnimatedContainer(
                    margin: EdgeInsets.fromLTRB(10, 3, 10, 5),
                    height: 35,
                    duration: Duration(milliseconds: 450),
                    decoration: btnDecoration(bottomIndex == 1 ? kActiveBtnColor : Colors.white,30),
                    curve: Curves.easeOutBack,
                    child: Center(
                      child: Text('حساب حالي',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold,
                            color: bottomIndex == 1 ? Colors.white : Colors.black),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
