import 'package:cool_alert/cool_alert.dart';
import 'package:covidroom/main.dart';
import 'package:csc_picker/csc_picker.dart';
import 'package:flutter/material.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:shared_preferences/shared_preferences.dart';


class settingsreal extends StatefulWidget {
  settingsreal({Key key}) : super(key: key);

  @override
  _settingsrealState createState() {
    return _settingsrealState();
  }
}

class _settingsrealState extends State<settingsreal> {
  bool isLoading = true;
  loadData() {
    //somecode to load data
    setState(() {
      isLoading = false;//setting state to false after data loaded
    });
  }
  var _currentIndex = 2;
  final RoundedLoadingButtonController _btnControllerRegister =RoundedLoadingButtonController();
  final RoundedLoadingButtonController _btnController = RoundedLoadingButtonController();
  var stateValue="";
  var cityValue="";
  @override
  void initState() {
    loadData();

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {



    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color(0xff111111),
        title: Text("Settings",style: TextStyle(color: Colors.white),),
        centerTitle: true,
      ),

      backgroundColor:Color(0xff111111),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(

                      width: MediaQuery.of(context).size.width/1.1,
                      height:MediaQuery.of(context).size.height/2.6 ,
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(6),
                            child: Container(
                              width: MediaQuery.of(context).size.width/20,
                              height:MediaQuery.of(context).size.height/2.6 ,
                              color: Color(0xff309bd5),

                            ),
                          ),
                          ClipRRect(

                            borderRadius: BorderRadius.circular(6),
                            child: Container(

                                width: MediaQuery.of(context).size.width/1.18,
                                height:MediaQuery.of(context).size.height/2.6 ,
                                color: Color(0xff222222),
                                child:Column(
                                  children: [


                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(0,20,40,0),
                                      child: Text("Select State and district.\nYou hospital suggestion will be based on this data.\nSelect district for larger result.\nYou can change this later.",style: TextStyle(color: Colors.white),),
                                    ),

                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(0,15,0,0),
                                      child: Container(
                                        width: MediaQuery.of(context).size.width/1.35,
                                        child: CSCPicker(
                                          defaultCountry: DefaultCountry.India,
                                          onCountryChanged: (value) {
                                            setState(() {

                                            });
                                          },
                                          onStateChanged:(value) {
                                            setState(() {
                                              stateValue = value;
                                            });
                                          },
                                          onCityChanged:(value) {
                                            setState(() {
                                              cityValue = value;
                                            });
                                          },
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(12.0,35,12,12),
                                      child: RoundedLoadingButton(
                                        borderRadius: 5,
                                        color: Color(0xff309bd5),
                                        child: Text('Save', style: TextStyle(color: Colors.white)),
                                        controller: _btnController,
                                        onPressed:(){saveData(context);},
                                      ),
                                    )
                                  ],
                                )

                            ),
                          ),


                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20,),

                  Container(

                    width: MediaQuery.of(context).size.width/1.1,
                    height:MediaQuery.of(context).size.height/5.5 ,
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(6),
                          child: Container(
                            width: MediaQuery.of(context).size.width/20,
                            height:MediaQuery.of(context).size.height/5.5 ,
                            color: Color(0xff309bd5),

                          ),
                        ),
                        ClipRRect(

                          borderRadius: BorderRadius.circular(6),
                          child: Container(
                              width: MediaQuery.of(context).size.width/1.18,
                              height:MediaQuery.of(context).size.height/5.5 ,
                              color: Color(0xff222222),
                              child:Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [

                                     Padding(
                                       padding: const EdgeInsets.all(8.0),
                                       child: Text("Welcome.Please read this before you continue.\n1.Find hospitals near you which provide covid care with help of this app.\n2.Nearby hospitals is shown based on data given above.\n3.Select district and state for better result.\n4.You can change the data whenever you want.\n5.The data will be refreshed automatically and is sorted based on availability of beds.\n6.Due to rapid development you may encounter with few bugs. please report it to : macbethsoftwares@gmail.com",style: TextStyle(color: Colors.white),),
                                     ),





                                ],
                              )

                          ),
                        ),


                      ],
                    ),
                  ),

                  SizedBox(height: 20,),

                  Container(

                    width: MediaQuery.of(context).size.width/1.1,
                    height:MediaQuery.of(context).size.height/5.5 ,
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(6),
                          child: Container(
                            width: MediaQuery.of(context).size.width/20,
                            height:MediaQuery.of(context).size.height/5.5 ,
                            color: Color(0xff309bd5),

                          ),
                        ),
                        ClipRRect(

                          borderRadius: BorderRadius.circular(6),
                          child: Container(
                              width: MediaQuery.of(context).size.width/1.18,
                              height:MediaQuery.of(context).size.height/5.5 ,
                              color: Color(0xff222222),
                              child:Column(
                                children: [


                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(0,15,0,0),
                                    child: Column(
                                      children: [
                                        Text("Help Us.",style: TextStyle(color: Colors.white,fontSize: 30),


                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text("Help us to add more hospitals.Suggest our application to hospitals and together lets reduce the impact made by covid.",style: TextStyle(color: Colors.white,fontSize: 15)),
                                        ),
                                      ],
                                    ),),
                                  Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: RoundedLoadingButton(
                                      height: 30,
                                      borderRadius: 5,
                                      color: Color(0xff309bd5),
                                      child: Text('Register Hospital', style: TextStyle(color: Colors.white)),
                                      controller: _btnControllerRegister,
                                      onPressed:(){saveData(context);},
                                    ),
                                  )



                                ],
                              )

                          ),
                        ),


                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  saveData(BuildContext context)async {
    if(stateValue!="" && cityValue!="" && cityValue!=null && stateValue!=null){
      SharedPreferences prefs=await SharedPreferences.getInstance();
      prefs.setString("stateValue", stateValue);
      prefs.setString("cityValue", cityValue);
      prefs.setString("runTime", "1");
      CoolAlert.show(
        backgroundColor: Color(0xff309bd5),
        confirmBtnColor: Color(0xff309bd5),
        context: context,
        type: CoolAlertType.success,
        text: "Data saved.",

      );
      await Future.delayed(const Duration(milliseconds: 20));
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => MyHomePage()));
      _btnController.reset();
    }else{
      CoolAlert.show(
        backgroundColor: Color(0xff309d5),
        confirmBtnColor: Color(0xff309bd5),
        context: context,
        type: CoolAlertType.error,
        text: "Please enter complete data.",
      );
      _btnController.stop();
    }

  }

}



