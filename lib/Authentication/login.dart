import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:practise_app/Widget/textfeildwidget.dart';
import 'package:practise_app/pages/home.dart';
import 'package:practise_app/services/database.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String email = "", password = "", name = "", id = "", username = "";
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  login() async {
    try {
      if (passwordcontroller.text.isNotEmpty &&
          emailcontroller.text.isNotEmpty) {
        await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password);
        QuerySnapshot querySnapshot =
            await DatabaseMethod().getUserDetail(emailcontroller.text.trim());
        if (querySnapshot.docs.isNotEmpty) {
          final userdata = querySnapshot.docs[0].data();
        }
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            backgroundColor: Colors.orangeAccent,
            content: Text(
              "Login SuccessFully",
              style: TextStyle(fontSize: 20, color: Colors.black),
            )));
        Navigator.pushReplacement(
            // ignore: use_build_context_synchronously
            context,
            MaterialPageRoute(
              builder: (context) => const Home(),
            ));
      } else {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            backgroundColor: Colors.orangeAccent,
            content: Text(
              "No user found for that email",
              style: TextStyle(fontSize: 20, color: Colors.black),
            )));
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            backgroundColor: Colors.orangeAccent,
            content: Text(
              "No user found for that email",
              style: TextStyle(fontSize: 20, color: Colors.black),
            )));
      } else if (e.code == "wrong-password") {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            backgroundColor: Colors.orangeAccent,
            content: Text(
              "Wrong password",
              style: TextStyle(fontSize: 20, color: Colors.black),
            )));
      }
    }
  }

  final _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 92, 39, 176),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 100, bottom: 100),
              child: Center(
                child: Container(
                    height: MediaQuery.of(context).size.height * 0.8,
                    width: MediaQuery.of(context).size.width * 0.7,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                    ),
                    child: Form(
                      key: _formkey,
                      child: Column(
                        children: [
                          Container(
                            height: 80,
                            width: MediaQuery.of(context).size.width * 0.7,
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20),
                                  bottomLeft: Radius.elliptical(30, 20),
                                  bottomRight: Radius.elliptical(30, 20)),
                              color: Colors.blueAccent,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(top: 25),
                              child: Text(
                                textAlign: TextAlign.center,
                                "Login to your Account",
                                style: GoogleFonts.nunito(
                                    fontSize: 25,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 12),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  "Email",
                                  style: GoogleFonts.nunito(
                                      fontSize: 20,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextfieldWidget(
                            controller: emailcontroller,
                            validator: (p0) {
                              if (p0 == null || p0.isEmpty) {
                                return "Please Enter email";
                              } else {
                                return null;
                              }
                            },
                            hintText: "E.g mehran@gmail.com",
                            keyboardType: TextInputType.emailAddress,
                            obscureTextWidget: false,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 12),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  "Password",
                                  style: GoogleFonts.nunito(
                                      fontSize: 20,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextfieldWidget(
                            controller: passwordcontroller,
                            validator: (p0) {
                              if (p0 == null || p0.isEmpty) {
                                return "Please Enter Password";
                              } else {
                                return null;
                              }
                            },
                            hintText: "Enter password",
                            keyboardType: TextInputType.visiblePassword,
                            obscureTextWidget: true,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextButton(
                                  onPressed: () {},
                                  child: Text(
                                    "Forgot Password ?",
                                    style: GoogleFonts.nunito(
                                        fontSize: 16,
                                        color: const Color.fromARGB(
                                            255, 92, 39, 176),
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          SizedBox(
                            height: 50,
                            width: 270,
                            child: ElevatedButton(
                              style: ButtonStyle(
                                elevation: WidgetStateProperty.all<double>(10),
                                backgroundColor: WidgetStateProperty.all<Color>(
                                  const Color.fromARGB(255, 120, 69, 201),
                                ),
                                shape: WidgetStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50)),
                                ),
                              ),
                              onPressed: () async {
                                if (_formkey.currentState!.validate()) {
                                  setState(() {
                                    email = emailcontroller.text;
                                    password = passwordcontroller.text;
                                  });
                                }
                                await login();
                              },
                              child: Text(
                                "Login",
                                style: GoogleFonts.nunito(
                                  fontSize: 16,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10, left: 30),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Not registred yet? ",
                                  style: GoogleFonts.nunito(
                                      fontSize: 16,
                                      color: Colors.black54,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "Create an account",
                                  style: GoogleFonts.nunito(
                                      fontSize: 16,
                                      color: const Color.fromARGB(
                                          255, 92, 39, 176),
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    )),
              ),
            )
          ],
        ),
      ),
    );
  }
}
