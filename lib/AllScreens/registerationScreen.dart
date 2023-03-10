import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:buraq/AllScreens/mainscreen.dart';
import 'package:buraq/main.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../AllWidgets/progressDialod.dart';
import 'loginScreen.dart';
import 'package:firebase_core/firebase_core.dart';
class RegisterationScreen extends StatelessWidget {
  static const String idScreen = "register";

  TextEditingController nameTextEditingController = TextEditingController();
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController phoneTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();


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
                  height: 25.0,
                ),
            SvgPicture.asset(
                'images/logosvgmain.svg',
                semanticsLabel: 'Acme Logo'
            ),
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
                  "Register as Rider",
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
                        controller: nameTextEditingController,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          labelText: "Name",
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
                        controller: phoneTextEditingController,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          labelText: "Phone",
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
                          if(nameTextEditingController.text.length<3){
                            displayToastMessage("Name must be atleast 3 characters.", context);
                          }else if(!emailTextEditingController.text.contains('@')){
                            displayToastMessage("Email address is not Valid.", context);
                          }else if(phoneTextEditingController.text.isEmpty){
                            displayToastMessage("Phone Number is mandatory.", context);
                          }else if(passwordTextEditingController.text.length<6){
                            displayToastMessage("Password must be atleast 6 characters.", context);
                          }else{
                            registerNewUser(context);
                          }

                        },
                        color: Color(0xFFc6520a),
                        textColor: Colors.white,
                        child: Container(
                          height: 50.0,
                          child: Center(
                            child: Text(
                              "Create Account",
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
                    Navigator.pushNamedAndRemoveUntil(context, LoginScreen.idScreen, (route) => false);
                  },
                  child: Text("Already have a Account? Login Here"),),
                // SizedBox(
                //   width: 250.0,
                //   child: TextLiquidFill(
                //     loadUntil: 0.5,
                //     loadDuration: Duration(seconds: 10),
                //     text: 'BURAAQ',
                //     waveColor: Color(0xFFc6520a),
                //     boxBackgroundColor: Colors.white,
                //     textStyle: TextStyle(
                //       fontSize: 60.0,
                //       fontWeight: FontWeight.bold,
                //     ),
                //     boxHeight: 300.0,
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  Future<void> registerNewUser(BuildContext context) async {

    showDialog(context: context,
        barrierDismissible: false,
        builder: (BuildContext context){
          return ProgressDialod(
            message: "Registering, Please wait",
          );
        });

    final User? firebaseUser = (await _firebaseAuth
            .createUserWithEmailAndPassword(
        email:emailTextEditingController.text,
        password:passwordTextEditingController.text,).catchError((errMsg){
          Navigator.pop(context);
      displayToastMessage("Error:"+errMsg.toString(), context);
    })).user;
    // try {
    //   UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
    //       email: emailTextEditingController.text,
    //       password: passwordTextEditingController.text,
    //   );
    // } on FirebaseAuthException catch (e) {
    //   if (e.code == 'weak-password') {
    //     print('The password provided is too weak.');
    //   } else if (e.code == 'email-already-in-use') {
    //     print('The account already exists for that email.');
    //   }
    // } catch (e) {
    //   print(e);
    // }
    if(firebaseUser!=null)//user created
    {
      //save user into to database

      Map userDataMap = {
        "name": nameTextEditingController.text.trim(),
        "email": emailTextEditingController.text.trim(),
        "phone": phoneTextEditingController.text.trim(),
      };
      userRef.child(firebaseUser.uid).set(userDataMap);
      displayToastMessage("Congratulations, your account has been created", context);

      Navigator.pushNamedAndRemoveUntil(context, LoginScreen.idScreen, (route) => false);
    }else{
      //error occured
      Navigator.pop(context);
      displayToastMessage("New user account has not been Created.", context);
    }
  }

}
displayToastMessage(String message,BuildContext context){
  Fluttertoast.showToast(msg: message);
}
