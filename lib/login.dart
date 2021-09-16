// ignore_for_file: file_names

import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:the_road_not_taken/main.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;
  final googleSignIn = GoogleSignIn();
  bool isLoading = false;

  Future googleLogin() async {
    setState(() {
      isLoading = true;
    });
    try {
      final user = await googleSignIn.signIn();
      if (user == null) {
        setState(() {
          isLoading = false;
        });
        return;
      } else {
        final googleAuth = await user.authentication;
        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
        await auth.signInWithCredential(credential).then((value) async {
          debugPrint("User is New = ${value.additionalUserInfo!.isNewUser}");

          await createUser(value.user!);
        });
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      debugPrint(e.toString());
      Get.snackbar("Error", "Error, please try again later..!!");
    }
  }

  Future createUser(User user) async {
    var db = await FirebaseFirestore.instance
        .collection("users")
        .doc(user.uid)
        .get();
    if (db.exists) {
    } else {
      Map<String, dynamic> data = {
        "name": user.displayName,
        "email": user.email,
        "photoUrl": user.photoURL,
      };

      await firebaseFirestore.collection("accounts").doc(user.uid).set(data);
    }
    Get.off(() => const HomePage());
  }

  @override
  Widget build(BuildContext context) {
    Widget loginButton() {
      return RawMaterialButton(
        onPressed: () {
          googleLogin();
        },
        child: Center(
          child: Container(
              decoration: BoxDecoration(
                  color: Colors.blueGrey,
                  borderRadius:
                      BorderRadius.all(Radius.circular(isLoading ? 60 : 30))),
              child: isLoading
                  ? const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.white)),
                    )
                  : Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 13, vertical: 17),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Icon(Icons.google),
                            // wbox10,
                            Text("Get Started",
                                style: GoogleFonts.montserrat(
                                    color: Colors.white,
                                    fontSize: 17,
                                    fontWeight: FontWeight.w600)),
                          ],
                        ),
                      ),
                    )),
        ),
      );
    }

    return Scaffold(
        body: Container(
      height: context.height,
      width: double.maxFinite,
      padding: EdgeInsets.all(20),
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage("assets/images/loginBG.jpg"), fit: BoxFit.cover),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: <Color>[Colors.transparent, Colors.black],
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Spacer(),
          Container(
            padding: EdgeInsets.symmetric(horizontal: context.width / 10),
            child: Column(
              children: [
                Container(
                  alignment: Alignment.bottomLeft,
                  child: Text("The Road",
                      style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.w900,
                          fontSize: 40,
                          color: Colors.white)),
                ),
                Container(
                  alignment: Alignment.bottomRight,
                  child: Text("Not Taken",
                      style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.w900,
                          fontSize: 40,
                          color: Colors.white)),
                )
              ],
            ),
          ),
          Spacer(
            flex: 4,
          ),
          loginButton(),
        ],
      ),
    ));
  }
}
