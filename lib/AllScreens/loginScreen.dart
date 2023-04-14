import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import "package:flutter/material.dart";
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rider_app/AllScreens/mainscreen.dart';
import 'package:rider_app/AllScreens/registerationScreen.dart';
import 'package:rider_app/Allwidgets/progressDialog.dart';
import 'package:rider_app/Diya_timer.dart';
import 'package:rider_app/SlotBooking.dart';
import 'package:rider_app/main.dart';
class LoginScreen extends StatelessWidget {
  static const String idScreen ="login";
  TextEditingController emailTextEditingController = TextEditingController();
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
                "Sign In",
                style: TextStyle(fontSize: 24.0, fontFamily: "Brand Bold"),
                textAlign: TextAlign.center,
              ),
              Padding(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  children: [
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
                      style:TextStyle(fontSize: 14.0,fontFamily: "Brand Bold"),
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
                      style:TextStyle(fontSize: 14.0,fontFamily: "Brand Bold"),
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
                        height:40.0,
                        child: Center(
                          child: Text(
                            "Login",
                            style: TextStyle(fontSize: 18.0,fontFamily: "Brand Bold"),
                          ),
                        ),
                      ),
                      onPressed: (){
                        if (!emailTextEditingController.text.contains("@")) {
                          displayToastMessage("Email not valid", context);
                        }
                        else if (passwordTextEditingController.text.isEmpty)
                        {
                          displayToastMessage("Password is mandatory", context);
                        }
                        else
                          {
                            loginAndAuthenticateUser(context);
                          }
                      },
                    )
                  ],
                ),
              ),
              TextButton(
                onPressed: (){
                  Navigator.pushNamedAndRemoveUntil(context, RScreen.idScreen, (route) => false);
                },
                child: Text(
                  "Do not have an account? Create one"
                ),
              )


            ],
          ),
        ),
      ),
    );
  }

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  void loginAndAuthenticateUser(BuildContext context) async
  {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context)
      {
        return ProgressDialog(message: "Authenticating,Please Wait....",);
      }
    );

    final User? firebaseUser = (await _firebaseAuth.signInWithEmailAndPassword(
        email: emailTextEditingController.text,
        password: passwordTextEditingController.text).catchError((errMsg) {
        Navigator.pop(context);
      displayToastMessage("error:" + errMsg.toString(), context);
    })).user;

    if (firebaseUser != null)
    {
      userRef.child(firebaseUser.uid).once().then((DataSnapshot){
        if(DataSnapshot!=null)
          {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => MyButtons()));
            displayToastMessage("Login Successful", context);
          }
        else
          {
            Navigator.pop(context);
            _firebaseAuth.signOut();
            displayToastMessage("No account found", context);
          }
      });

    }
    else {
      Navigator.pop(context);
      displayToastMessage("Error occured cannot login", context);
    }

  }
}
displayToastMessage(String message,BuildContext context)
{
  Fluttertoast.showToast(msg: message);
}
