import 'dart:io';

import 'package:covidroom/home.dart';
import 'package:covidroom/serach.dart';
import 'package:covidroom/settingreal.dart';
import 'package:covidroom/settings.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}



class MyApp extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {



  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  var _currentIndex = 0;
  var _selectedIndex=0;

  List<Widget> _widgetOptions = <Widget>[
    Home(),
    serach(),
    settingsreal(),
  ];
  @override
  void initState() {




    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      backgroundColor:Color(0xff111111),

      bottomNavigationBar:BottomNavigationBar(

          backgroundColor: Color(0xff111111),
          currentIndex: _currentIndex, // Use this to update the Bar giving a position
          onTap: (index){
            setState(() {
              _selectedIndex=index;
              _currentIndex=index;
            });


            print("Selected Index: $index");
          },
          items: [
            BottomNavigationBarItem(backgroundColor: Colors.black,title: Text('.'), icon: Icon(Icons.home_filled,color: Color(0xff309bd5),)),
            BottomNavigationBarItem(backgroundColor: Colors.black,title: Text('.'), icon: Icon(Icons.search,color: Color(0xff309bd5))),
            BottomNavigationBarItem(backgroundColor: Colors.black,title: Text('.'), icon: Icon(Icons.settings_rounded,color: Color(0xff309bd5))),
          ]
      ),
      body: Center(
        child:_widgetOptions.elementAt(_selectedIndex),
      ),
    );
  }
  checkRuntime(BuildContext context)async {



    SharedPreferences prefs=await SharedPreferences.getInstance();
    var runTime=prefs.getString("runTime");
    print("runTime");
    print(runTime);
    if(runTime!="1"){
      await Future.delayed(const Duration(milliseconds: 2000));
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => settingsreal()));
    }
    return;
  }
}
