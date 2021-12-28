import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:covidroom/ad_helper.dart';
import 'package:covidroom/settingreal.dart';
import 'package:covidroom/settings.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:titled_navigation_bar/titled_navigation_bar.dart';
import 'package:url_launcher/url_launcher.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return HomeState();
  }
}

class HomeState extends State<Home> {
  // ignore: deprecated_member_use
  BannerAd _bannerAd;
  bool _isBannerAdReady = false;

  List<Widget> listView = List<Widget>();
  var cityValue = "";
  var stateValue = "";

  Future<QuerySnapshot> data;
  FirebaseFirestore fireStore;

  @override
  void initState() {
    fireStore = FirebaseFirestore.instance;
    checkRuntime(context);
    _bannerAd = BannerAd(
      adUnitId: AdHelper.bannerAdUnitId,
      request: AdRequest(),
      size: AdSize.largeBanner,
      listener: AdListener(
        onAdLoaded: (_) {
          setState(() {
            _isBannerAdReady = true;
          });
        },
        onAdFailedToLoad: (ad, err) {
          print('Failed to load a banner ad: ${err.message}');
          _isBannerAdReady = false;
          ad.dispose();
        },
      ),
    );

    _bannerAd.load();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.help,
              color: Colors.white,
            ),
            onPressed: () {
              CoolAlert.show(
                context: context,
                type: CoolAlertType.info,
                backgroundColor: Color(0xff309bd5),
                confirmBtnColor: Color(0xff309bd5),
                text:
                    "1.The data will be refreshed automatically.\n2.The data shown here is based the location data given by you.\n3.The data given here is based on the data given by authorities.\n\n\nHint:Choose district as location for better result.",
              );
              // do something
            },
          ),
          IconButton(
            icon: Icon(
              Icons.medical_services_outlined,
              color: Colors.white,
            ),
            onPressed: () {
              CoolAlert.show(
                context: context,
                type: CoolAlertType.info,
                backgroundColor: Color(0xff309bd5),
                confirmBtnColor: Color(0xff309bd5),
                text:
                "Covidhelp\n\nHere people can request for help for things like money,oxygen cylinder etc.and people who like to help can contact them.\n\n\nThis option will be available in next update.",
              );
              // do something
            },
          ),

        ],
        elevation: 0,
        backgroundColor: Color(0xff111111),
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Text("Nearby hospitals"),
      ),
      backgroundColor: Color(0xff111111),
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('hospitals')
                          .orderBy('triageCount', descending: true)
                          .where('hospitalState', isEqualTo: stateValue)
                          .where('hospitalCity', isEqualTo: cityValue)
                          .snapshots(),
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        // ignore: missing_return
                        if (snapshot.hasData) {
                          listView.clear();
                          print("data" + snapshot.data.size.toString());
                          if (snapshot.data.size == 0) {

                            return (Column(
                              children: [Container(child: Text("No hospitals found at this location.Please update location",style: TextStyle(color: Colors.white),),),
                              RaisedButton(
                                  color:Colors.red,
                                  child:Text("Change location"),
                                  onPressed: (){
                                Navigator.push(
                                    context, MaterialPageRoute(builder: (context) => settingsreal()));
                              })
                              ],
                            ));
                          } else {
                            snapshot.data.docs.forEach((element) {
                              listView.add(
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    width:
                                        MediaQuery.of(context).size.width / 1.1,
                                    height:
                                        MediaQuery.of(context).size.height / 2.9,
                                    child: Row(
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(6),
                                          child: Container(

                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                20,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                2.9,
                                            color: Color(0xff309bd5),
                                          ),
                                        ),
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(6),
                                          child: Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  1.18,
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height /
                                                  2.9,
                                              color: Color(0xff222222),
                                              child: Column(
                                                children: [
                                                  Align(
                                                    alignment:
                                                        Alignment.topLeft,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.fromLTRB(0
                                                              ,15.0,0,0),
                                                      child: Text("  "+
                                                        element['hospitalName'],
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 20),
                                                      ),
                                                    ),
                                                  ),
                                                  Row(
                                                    children: [
                                                      Align(
                                                        alignment:
                                                            Alignment.topLeft,
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(1.0),
                                                          child: Text(
                                                            "  " +
                                                                element[
                                                                    'hospitalCity'],
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 16),
                                                          ),
                                                        ),
                                                      ),
                                                      Align(
                                                        alignment:
                                                            Alignment.topLeft,
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(1.0),
                                                          child: Text(
                                                            ',',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 16),
                                                          ),
                                                        ),
                                                      ),
                                                      Align(
                                                        alignment:
                                                            Alignment.topLeft,
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(4.0),
                                                          child: Text(
                                                            element[
                                                                'hospitalState'],
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 16),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),

                                                  Row(
                                                    children: [
                                                      Align(
                                                        alignment:
                                                        Alignment.topLeft,
                                                        child: Padding(
                                                          padding:
                                                          const EdgeInsets
                                                              .all(1.0),
                                                          child: Text(
                                                            "  Care:",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 16),
                                                          ),
                                                        ),
                                                      ),

                                                      Align(
                                                        alignment:
                                                        Alignment.topLeft,
                                                        child: Padding(
                                                          padding:
                                                          const EdgeInsets
                                                              .all(4.0),
                                                          child: Text(
                                                            element[
                                                            'hospitalPayment'],
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 16),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),

                                                  Padding(
                                                    padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                                                    child: Row(
                                                      children: [
                                                        Align(
                                                          alignment:
                                                              Alignment.topLeft,
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .fromLTRB(
                                                                    8, 12, 8, 8),
                                                            child: Text(
                                                              'Triage Count       ',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize: 20),
                                                            ),
                                                          ),
                                                        ),
                                                        Align(
                                                          alignment:
                                                              Alignment.topLeft,
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: ClipRRect(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          4),
                                                              child: Container(
                                                                  height: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .height /
                                                                      40,
                                                                  width: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width /
                                                                      10,
                                                                  color: Color(
                                                                      0xff309bd5),
                                                                  child: Align(
                                                                      alignment:
                                                                          Alignment
                                                                              .center,
                                                                      child: Text(
                                                                        element['triageCount']
                                                                            .toString(),
                                                                        style: TextStyle(
                                                                            color: Colors
                                                                                .white,
                                                                            fontSize:
                                                                                20),
                                                                      ))),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Row(
                                                    children: [
                                                      Align(
                                                        alignment:
                                                            Alignment.topLeft,
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Text(
                                                            'Covid Bed Count',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 20),
                                                          ),
                                                        ),
                                                      ),
                                                      Align(
                                                        alignment:
                                                            Alignment.topLeft,
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        4),
                                                            child: Container(
                                                                height: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .height /
                                                                    40,
                                                                width: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width /
                                                                    10,
                                                                color: Color(
                                                                    0xff309bd5),
                                                                child: Align(
                                                                    alignment:
                                                                        Alignment
                                                                            .center,
                                                                    child: Text(
                                                                      element['covidbedCount']
                                                                          .toString(),
                                                                      style: TextStyle(
                                                                          color: Colors
                                                                              .white,
                                                                          fontSize:
                                                                              20),
                                                                    ))),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: GestureDetector(
                                                      onTap: () async {
                                                        var url = "tel://" +
                                                            element[
                                                                'hospitalMobilenumber'];
                                                        if (await canLaunch(
                                                            url)) {

                                                          await launch(url);
                                                        } else {
                                                          CoolAlert.show(context: context, type: CoolAlertType.warning,text: "Unable initiate call. Call manually the number is "+element['hospitalMobilenumber']);
                                                        }
                                                      },
                                                      child: Padding(
                                                        padding: const EdgeInsets.all(10.0),
                                                        child: ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(40),
                                                          child: Container(
                                                              height: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width /
                                                                  7,
                                                              width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width /
                                                                  7,
                                                              color: Color(
                                                                  0xff309bd5),
                                                              child: Icon(
                                                                Icons.call,
                                                                color: Color(
                                                                    0xff222222),
                                                              )),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              )),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            });
                            return (Column(
                              children: listView,
                            ));
                          }
                        } else if (snapshot.hasError) {
                          return Icon(Icons.error_outline);
                        } else {
                          return CircularProgressIndicator();
                        }
                      })),
            ),
            if (_isBannerAdReady)


              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    width: _bannerAd.size.width.toDouble(),
                    height: _bannerAd.size.height.toDouble(),
                    child: AdWidget(ad: _bannerAd),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  checkRuntime(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var runTime = prefs.getString("runTime");
    print("runTime");
    print(runTime);
    if (runTime != "1") {
      await Future.delayed(const Duration(milliseconds: 2000));
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => settingsreal()));
    } else {
      setState(() {
        stateValue = prefs.getString("stateValue") ?? "";
        cityValue = prefs.getString("cityValue") ?? "";
        print(stateValue);
      });
    }
  }

  Future getData(BuildContext context) async {
    QuerySnapshot snap;

    FirebaseFirestore fireStore = FirebaseFirestore.instance;

    SharedPreferences prefs = await SharedPreferences.getInstance();
    stateValue = prefs.getString("stateValue") ?? "";
    cityValue = prefs.getString("cityValue") ?? "";
    print(stateValue);
    if (stateValue == "" || cityValue == "") {
      CoolAlert.show(
          context: context,
          type: CoolAlertType.error,
          text: "Please select location from settings");
    }
  }
}
