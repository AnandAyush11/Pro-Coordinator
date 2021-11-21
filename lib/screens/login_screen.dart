import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'faculty_dashboard.dart';
import 'student_dashboard.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  int i = 0;
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        height: height,
        width: width,
        margin: EdgeInsets.symmetric(
          vertical: height * 0.1,
          horizontal: width * 0.2,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: height * 0.2,
              width: width * 0.8,
              child: Column(
                children: [
                  const Center(
                    child: Text(
                      "Type of User",
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            i = 1;
                          });
                        },
                        child: const Text("Student"),
                        style: ElevatedButton.styleFrom(
                          primary: i == 1 ? Colors.blue : Colors.grey,
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            i = 2;
                          });
                        },
                        child: const Text("Faculty"),
                        style: ElevatedButton.styleFrom(
                          primary: i == 2 ? Colors.blue : Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: height * 0.4,
              width: width * 0.8,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Password',
                      ),
                      keyboardType: TextInputType.emailAddress,
                      controller: emailController,
                      onChanged: (value) {
                        emailController.text = value;
                      },
                    ),
                  ),
                  Expanded(
                    child: TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Password',
                      ),
                      keyboardType: TextInputType.visiblePassword,
                      controller: passController,
                      onChanged: (value) {
                        passController.text = value;
                      },
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: height * 0.1,
              width: width * 0.8,
              child: ElevatedButton(
                onPressed: () async {
                  await FirebaseAuth.instance
                      .signInWithEmailAndPassword(
                    email: emailController.text,
                    password: passController.text,
                  )
                      .catchError((error) {
                    Fluttertoast.showToast(msg: error);
                  }).then((value) async {
                    await FirebaseFirestore.instance
                        .collection('users')
                        .doc(value.additionalUserInfo!.providerId)
                        .set({
                      'email': emailController.text,
                      'type': i,
                    });
                  }).whenComplete(() {
                    Fluttertoast.showToast(msg: 'Login Successful');
                    i == 1
                        ? Navigator.popAndPushNamed(
                            context, StudentDashboard.routeName)
                        : Navigator.popAndPushNamed(
                            context, FacultyDashboard.routeName);
                  });
                },
                child: const Center(
                  child: Text(
                    'Login',
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
