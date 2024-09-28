import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:practise_app/Authentication/registration.dart';
import 'package:practise_app/Widget/textfeildwidget.dart';

class Forgotpassword extends StatefulWidget {
  const Forgotpassword({super.key});

  @override
  State<Forgotpassword> createState() => _Forgotpassword();
}

class _Forgotpassword extends State<Forgotpassword> {
  String email = "";
  TextEditingController emailcontroller = TextEditingController();
  forgotpassword() async {
    try {
      if (emailcontroller.text.isNotEmpty) {
        await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            backgroundColor: Colors.orangeAccent,
            content: Text(
              "Reset password Succesfully",
              style: TextStyle(fontSize: 20, color: Colors.black),
            )));

        Navigator.push(
            context,
            PageTransition(
                child: const Registration(), type: PageTransitionType.fade));
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            backgroundColor: Colors.orangeAccent,
            content: Text(
              "No user found for that email",
              style: TextStyle(fontSize: 20, color: Colors.black),
            )));
      } else if (e.code == "network-request-failed") {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            backgroundColor: Colors.orangeAccent,
            content: Text(
              "network-request-failed",
              style: TextStyle(fontSize: 20, color: Colors.black),
            )));
      } else if (e.code == "invalid-email") {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            backgroundColor: Colors.orangeAccent,
            content: Text(
              "invalid-email",
              style: TextStyle(fontSize: 20, color: Colors.black),
            )));
      }
    }
  }

  final formkey = GlobalKey<FormState>();
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
                    width: MediaQuery.of(context).size.width * 0.7,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                    ),
                    child: Form(
                      key: formkey,
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
                                "Forgot your password ",
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
                                return "Enter password";
                              } else {
                                return null;
                              }
                            },
                            hintText: "E.g mehran@gmail.com",
                            keyboardType: TextInputType.emailAddress,
                            obscureTextWidget: false,
                          ),
                          const SizedBox(
                            height: 30,
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
                                if (formkey.currentState!.validate()) {
                                  setState(() {
                                    email = emailcontroller.text.trim();
                                  });
                                }
                                await forgotpassword();
                              },
                              child: Text(
                                "Send",
                                style: GoogleFonts.nunito(
                                  fontSize: 16,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 40,
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
