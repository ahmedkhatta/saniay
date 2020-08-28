import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sanai3i/files/bookmark.dart';
import 'package:sanai3i/files/database.dart';
import 'package:sanai3i/files/home.dart';
import 'package:sanai3i/files/profile.dart';
import 'package:sanai3i/files/reusable.dart';
import 'package:qrscan/qrscan.dart' as scanner;

int mainNavigationIndex = 1;


class MainNavigation extends StatefulWidget {

  @override
  _MainNavigationState createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> with SingleTickerProviderStateMixin{

  bool _dropdownMenuOpened = false;
  String _scannedUId;


  @override
  initState() {
    super.initState();
    loading = false;
    DatabaseService().updateMyLocation();
  }

  Future<String> scanQRCode()async {
    final scannedUID = await scanner.scan();
    setState(() {
      _scannedUId = scannedUID;
    });
    return _scannedUId;

  }

  onHomeBtnPressed(int index){
    setState(() {
      mainNavigationIndex = index ;
    });
  }


  @override
  Widget build(BuildContext context) {

    Widget _buildContent (BuildContext context) {
      switch (mainNavigationIndex){
        case 0:
          return BookmarkPage();
        case 1:
          return HomePage(onHomeBtnPressed: onHomeBtnPressed);
        case 2:
          return ProfilePage();
        case 3 :
          return CustomGridView(gridViewType: jopList);
        case 4 :
          return CustomGridView(gridViewType: shopsList);
        default :
          return Text('Error 404');
      }
    }

    return GestureDetector(
      onTap: (){
        setState(() {
          _dropdownMenuOpened = false;
        });
      },
      child: WillPopScope(
        onWillPop: () async {
          if(mainNavigationIndex == 3 || mainNavigationIndex == 4 ){
            setState(() {
              mainNavigationIndex = 1 ;
            });
            return false ;
          }
          else return true ;
        },
        child: Scaffold(
          backgroundColor:Color(0xffefefef),
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(45.0),
            child: AppBar(
              backgroundColor: kActiveBtnColor,
              elevation: 5,
              centerTitle: true,
//              leading: IconButton(icon: Icon(Icons.star), onPressed: (){
//                showRateDialog('erqRPCZ4I6emHqDulfr2vZ5cdUQ2',context);
//              }),
              title:mainNavigationIndex == 0 ? Text('المفضلة',style: TextStyle(fontSize: 16),)
                : mainNavigationIndex == 1 ? Text('الرئيسية',style: TextStyle(fontSize: 16),)
                : mainNavigationIndex == 2 ?Text('الصفحة الشخصية',style: TextStyle(fontSize: 16))
                : mainNavigationIndex == 3 ? Text('صنايعي',style: TextStyle(fontSize: 16))
                : Text('محلات و معارض',style: TextStyle(fontSize: 16)),
              actions: <Widget>[
                IconButton(
                  onPressed: () {
                    setState(()  {
                      _dropdownMenuOpened = !_dropdownMenuOpened;
                    });
                  },
                  icon: Icon(Icons.more_vert,size: 16,),
                ),
              ],
            ),
          ),
          body: Stack(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Expanded(child: Center(child: _buildContent(context))),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      boxShadow:[BoxShadow(color: Colors.black.withOpacity(.1), spreadRadius: 1, blurRadius: 2, offset: Offset(-1, -1),),],
                    ),
                    padding: EdgeInsets.fromLTRB(5, 6, 5, 6),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Expanded(
                          child: InkWell(
                            onTap: () { setState(() {mainNavigationIndex = 0;}); },
                            child: AnimatedContainer(
                              height: 35,
                              duration: Duration(milliseconds: 450),
                              curve: Curves.easeOutBack,
                              decoration: btnDecoration(mainNavigationIndex == 0 ? kActiveBtnColor : Colors.white,30),
                              child: mainNavigationIndex == 0 ? Image.asset('images/bookmark.png', scale: 4.0,) : Image.asset('images/bookmarkd.png', scale: 4.0,),
                            ),
                          ),
                        ),
                        SizedBox(width: 25,),
                        Expanded(
                          child: InkWell(
                           onTap:() {setState(() {mainNavigationIndex = 1;});},
                            child: AnimatedContainer(
                              height: 35,
                              duration: Duration(milliseconds: 450),
                              curve: Curves.easeOutBack,
                              decoration: btnDecoration(mainNavigationIndex == 1 ? kActiveBtnColor : Colors.white,30),
                              child: mainNavigationIndex == 1 ? Image.asset('images/home.png', scale: 4.0,) : Image.asset('images/homed.png', scale: 4.0,),
                            ),
                          ),
                        ),
                        SizedBox(width: 25,),
                        Expanded(
                          child: InkWell(
                            onTap: () {setState(() {mainNavigationIndex = 2;});},
                            child: AnimatedContainer(
                              height: 35,
                              duration: Duration(milliseconds: 450),
                              curve: Curves.easeOutBack,
                              decoration: btnDecoration(mainNavigationIndex == 2 ? kActiveBtnColor : Colors.white,30),
                              child: mainNavigationIndex == 2 ? Image.asset('images/profile.png', scale: 4.0,) : Image.asset('images/profiled.png', scale: 4.0,),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              mainNavigationIndex == 3  || mainNavigationIndex == 4 ?
              Positioned(
                right: 8,
                bottom: 70,
                child: PositionedBtn(
                  icon: Icons.arrow_forward,onPressed: (){
                  setState(() {
                    mainNavigationIndex = 1 ;
                  });
                },),
              ):
              SizedBox(),
              _dropdownMenuOpened ?
              Positioned(
                top: 3,
                right: 5 ,
                child: FadeY(
                  delay: 0.0,
                  duration: Duration(milliseconds: 200),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(color: Colors.black.withOpacity(.1), spreadRadius: 1.0, blurRadius: 5, offset: Offset(3, 3),),
                        BoxShadow(color: Colors.black.withOpacity(.1), spreadRadius: 1.0, blurRadius: 5, offset: Offset(-3, 3),),
                      ],
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    width: 125,
                    height: 139,
                    padding: EdgeInsets.symmetric(vertical: 2.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        DropDownMenuItem(
                          title: 'تقييم  صنايعي',
                          icon: Icons.rate_review,
                          onTap: () async {
                            setState(() {
                              _dropdownMenuOpened = false;
                            });
                            await scanQRCode();
                            if(_scannedUId != null ){
                              try{
                                showRateDialog(_scannedUId,context);
                              }catch (e){
                                Fluttertoast.showToast(
                                  msg: 'فشل 😞',
                                  gravity: ToastGravity.BOTTOM,
                                );
                              }
                            } else if (_scannedUId == null){
                              Fluttertoast.showToast(
                                msg: 'فشل 😞',
                                gravity: ToastGravity.BOTTOM,
                              );
                            }
                          },
                        ),
                        divider(),
                        DropDownMenuItem(
                          icon: Icons.location_on,
                          title: 'تحديث موقعي    ',
                          onTap: (){
                            DatabaseService().updateMyLocation();
                            setState(() {
                              _dropdownMenuOpened = false;
                            });
                            Future.delayed(Duration(milliseconds: 200)).then((value) {
                              Fluttertoast.showToast(
                                msg: 'تم تحديث موقعك',
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                              );
                            });
                          },
                        ),
                        divider(),
                        DropDownMenuItem(
                          title: 'تسجيل خروج   ',
                          icon: Icons.exit_to_app,
                          onTap: (){
                            DatabaseService().signOut();
                            _dropdownMenuOpened = false;
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ):
              SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}









