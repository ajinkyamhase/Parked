import 'dart:core';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import "package:flutter/material.dart";
import 'package:rider_app/AllScreens/loginScreen.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rider_app/AllScreens/mainscreen.dart';
import 'package:rider_app/Allwidgets/progressDialog.dart';
import 'package:rider_app/main.dart';
import 'package:rider_app/Allwidgets/Divider.dart';
class RScreen extends StatefulWidget {
  static const String idScreen = "r";

  @override
  State<RScreen> createState() => _RScreenState();
}

class _RScreenState extends State<RScreen> {
  bool On=false;

  // ignore: deprecated_member_use
  final dbR = FirebaseDatabase.instance.reference();

  TextEditingController nameTextEditingController = TextEditingController();

  TextEditingController emailTextEditingController = TextEditingController();

  TextEditingController phoneTextEditingController = TextEditingController();

  TextEditingController passwordTextEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(height: 5.0,),
              Image(
                image: AssetImage("images/images/logo.png"),
                width: 390.0,
                height: 320.0,
                alignment: Alignment.center,
              ),
              SizedBox(height: 1.0,),
              Text(
                "Register",
                style: TextStyle(fontSize: 24.0, fontFamily: "Brand Bold"),
                textAlign: TextAlign.center,
              ),
              Padding(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    SizedBox(height: 1.0,),
                    TextField(
                      controller: nameTextEditingController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          labelText: "Name",
                          labelStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 10.0,
                          )
                      ),
                      style: TextStyle(
                          fontSize: 14.0, fontFamily: "Brand Bold"),
                    ),
                    SizedBox(height: 1.0,),
                    TextField(
                      controller: emailTextEditingController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                          labelText: "Email",
                          labelStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 10.0,
                          )
                      ),
                      style: TextStyle(
                          fontSize: 14.0, fontFamily: "Brand Bold"),
                    ),
                    SizedBox(height: 1.0,),
                    TextField(
                      controller: phoneTextEditingController,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                          labelText: "Phone",
                          labelStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 10.0,
                          )
                      ),
                      style: TextStyle(
                          fontSize: 14.0, fontFamily: "Brand Bold"),
                    ),
                    SizedBox(height: 1.0,),
                    TextField(
                      controller: passwordTextEditingController,
                      obscureText: true,
                      decoration: InputDecoration(
                          labelText: "Password",
                          labelStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 10.0,
                          )
                      ),
                      style: TextStyle(
                          fontSize: 14.0, fontFamily: "Brand Bold"),
                    ),

                    SizedBox(height: 30.0,),
                    ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(Colors.blueAccent),

                          shape: MaterialStatePropertyAll
                            (
                            RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(24.0),
                            ),
                          )
                      ),
                      child: Container(
                        height: 40.0,
                        child: Center(
                          child: Text(
                            "Create Account",
                            style: TextStyle(
                                fontSize: 18.0, fontFamily: "Brand Bold"),
                          ),
                        ),
                      ),
                      onPressed: () {
                        if (nameTextEditingController.text.length < 4) {
                          displayToastMessage("name must 3", context);
                        }
                        else
                        if (!emailTextEditingController.text.contains("@")) {
                          displayToastMessage("Email not valid", context);
                        }
                        else if (phoneTextEditingController.text.isEmpty) {
                          displayToastMessage("Phone no mandatory", context);
                        }
                        else if (passwordTextEditingController.text.length <6)
                        {
                          displayToastMessage("At least 6 char", context);
                        }
                        else {
                          registerNewUser(context);
                        }
                        registerNewUser(context);
                        print("login button clicked");
                      },
                    )
                  ],
                ),
              ),
              TextButton(
                onPressed: () {

                  Navigator.pushNamedAndRemoveUntil(
                      context, LoginScreen.idScreen, (route) => false);
                },

                child: Text(
                    "Already have an account? Login Here"
                ),
              )


            ],
          ),
        ),
      ),
    );
  }

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  void registerNewUser(BuildContext context) async
  {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context)
        {
          return ProgressDialog(message: "Registering,Please Wait....",);
        }
    );

    final User? firebaseUser = (await _firebaseAuth.createUserWithEmailAndPassword(
        email: emailTextEditingController.text,
        password: passwordTextEditingController.text).catchError((errMsg) {
          Navigator.pop(context);
          displayToastMessage("error:" + errMsg.toString(), context);
        })).user;
    if (firebaseUser != null) {

      //save user info to database

      Map userDataMap = {
        "name": nameTextEditingController.text.trim(),
        "email": emailTextEditingController.text.trim(),
        "phone": phoneTextEditingController.text.trim(),
      };
      userRef.child(firebaseUser.uid).set(userDataMap);
      displayToastMessage("account created successfully", context);
      Navigator.pushNamedAndRemoveUntil(
          context, MainScreen.idScreen, (route) => false);
    }
    else {
      Navigator.pop(context);
      displayToastMessage("acc not created", context);
    }
    // final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
    // void registerNewUser(BuildContext context) async
    // {
    //   final F
    // }
  }
}
displayToastMessage(String message,BuildContext context)
{
  Fluttertoast.showToast(msg: message);
}
