import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:buraq/AllScreens/registerationScreen.dart';
import 'package:buraq/AllWidgets/progressDialod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../main.dart';
import 'mainscreen.dart';

class LoginScreen extends StatelessWidget {
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();
  static const String idScreen = "login";
  final Widget svg = SvgPicture.asset(
      'images/logosvgmain.svg',
      semanticsLabel: 'Acme Logo'
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              children: [
                SizedBox(
                  height: 35.0,
                ),
                svg,
                // Image(
                //   image: AssetImage('images/logomain.png'),
                //   width: 390.0,
                //   height: 250.0,
                //   alignment: Alignment.center,
                // ),
                SizedBox(
                  height: 1.0,
                ),
                Text(
                    "Login as Rider",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 24.0,fontFamily: "Brand-Bold"),
                ),
                Padding(
                  padding: EdgeInsets.all(20.0),
                child: Column(
                  children: [

                    SizedBox(
                      height: 1.0,
                    ),
                    TextField(
                      controller: emailTextEditingController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: "Email",
                        labelStyle: TextStyle(
                          fontSize: 14.0,
                        ),
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 10.0,
                        ),
                      ),
                      style: TextStyle(
                        fontSize: 14.0,
                      ),
                    ),

                    SizedBox(
                      height: 1.0,
                    ),
                    TextField(
                      controller: passwordTextEditingController,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: "Password",
                        labelStyle: TextStyle(
                          fontSize: 14.0,
                        ),
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 10.0,
                        ),
                      ),
                      style: TextStyle(
                        fontSize: 14.0,
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    MaterialButton(
                        onPressed: (){
                  if(!emailTextEditingController.text.contains('@')) {
                    displayToastMessage("Email address is not Valid.", context);
                  }else if(passwordTextEditingController.text.isEmpty){
                    displayToastMessage("Password is Mandatory.", context);
                  }else{
                    loginAndAuthenticateUser(context);
                  }

                        },
                      color: Color(0xFFc6520a),
                      textColor: Colors.white,
                      child: Container(
                        height: 50.0,
                        child: Center(
                          child: Text(
                            "Login",
                            style: TextStyle(
                              fontSize: 18.0,
                              fontFamily: "Brand-Bold",
                            ),
                          ),
                        ),
                      ),
                      shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(24.0),
                      ),
                        ),
                  ],
                ),

                ),

                MaterialButton(
                    onPressed: (){
                      Navigator.pushNamedAndRemoveUntil(context, RegisterationScreen.idScreen, (route) => false);
                    },
                    child: Text("Do not have a Account? Register Here"),),
                SizedBox(
                  width: 250.0,
                  child: TextLiquidFill(
                    loadUntil: 0.5,
                    loadDuration: Duration(seconds: 10),
                    text: 'BURAAQ',
                    waveColor: Color(0xFFc6520a),
                    boxBackgroundColor: Colors.white,
                    textStyle: TextStyle(
                      fontSize: 60.0,
                      fontWeight: FontWeight.bold,
                    ),
                    boxHeight: 300.0,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  void loginAndAuthenticateUser(BuildContext context) async{

    showDialog(context: context,
        barrierDismissible: false,
        builder: (BuildContext context){
      return ProgressDialod(
        message: "Authenticating, Please wait",
      );
    });
    final User? firebaseUser = (await _firebaseAuth
        .signInWithEmailAndPassword(
      email:emailTextEditingController.text,
      password:passwordTextEditingController.text,).catchError((errMsg){
        Navigator.pop(context);
      displayToastMessage("Error:"+errMsg.toString(), context);
    })).user;
    if(firebaseUser!=null)//user
      {
      Navigator.pushNamedAndRemoveUntil(context, MainScreen.idScreen, (route) => false);
            displayToastMessage("You are logged-in", context);
    }else{
      Navigator.pop(context);
      displayToastMessage("Error Occured! cannot signIn", context);
    }
    //     {
    //   userRef.child(firebaseUser.uid).once().then((value)=>(DataSnapshot snap){
    //     if(snap.value != null){
    //       Navigator.pushNamedAndRemoveUntil(context, MainScreen.idScreen, (route) => false);
    //       displayToastMessage("You are logged-in", context);
    //     }else{
    //       _firebaseAuth.signOut();
    //       displayToastMessage("No record exists for this user. Please create a account.", context);
    //     }
    //   });
    //     }else{
    //   //error occured
    //   displayToastMessage("Error Occured! cannot signIn", context);
    // }
  }
}
