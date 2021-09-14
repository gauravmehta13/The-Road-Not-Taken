// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
    return Scaffold(
        body: SafeArea(
      child: ElevatedButton(
          onPressed: () {
            googleLogin();
          },
          child: const Text("data")),
    ));
  }
}
