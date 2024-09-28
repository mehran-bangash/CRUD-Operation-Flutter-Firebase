import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:practise_app/Widget/textfeildwidget.dart';
import 'package:practise_app/pages/home.dart';
import 'package:practise_app/services/database.dart';
import 'package:random_string/random_string.dart';

class Registration extends StatefulWidget {
  const Registration({super.key});

  @override
  State<Registration> createState() => _Registration();
}

class _Registration extends State<Registration> {
  String email = "",
      username = "",
      name = "",
      password = "",
      confirmPassword = "";
  TextEditingController namecontroller = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  TextEditingController confirmPasswordcontroller = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  registration() async {
    try {
      if (password == confirmPassword) {
        await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);
        String id = randomAlpha(10);
        username = emailcontroller.text.replaceAll("@gmail.com", "");
        Map<String, dynamic> UserInfoMap = {
          "Name": namecontroller.text,
          "Email": emailcontroller.text,
          "id": id,
          "username": username,
        };
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => Home(),
            ));
        DatabaseMethod().addUserDetail(id, UserInfoMap);
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            backgroundColor: Colors.white,
            content: Text(
              "Registration Succesfully",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                  color: Colors.orangeAccent),
            )));
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == "weak-password") {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            backgroundColor: Colors.white,
            content: Text(
              "You Provided Weak password",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                  color: Colors.orangeAccent),
            )));
      } else if (e.code == "Already-have-account") {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            backgroundColor: Colors.white,
            content: Text(
              "Already have an account",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                  color: Colors.orangeAccent),
            )));
      }
    }
  }

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
                                "Create a new Account",
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
                                  "Name",
                                  style: GoogleFonts.nunito(
                                      fontSize: 18,
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
                            controller: namecontroller,
                            validator: (p0) {
                              if (p0 == null || p0.isEmpty) {
                                return "Enter your name";
                              } else {
                                return null;
                              }
                            },
                            hintText: "Enter name",
                            keyboardType: TextInputType.name,
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
                                  "Email",
                                  style: GoogleFonts.nunito(
                                      fontSize: 18,
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
                                return "Enter your email";
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
                                      fontSize: 18,
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
                                return "Enter your password";
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
                          Padding(
                            padding: const EdgeInsets.only(left: 12),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  "Confirm Password",
                                  style: GoogleFonts.nunito(
                                      fontSize: 18,
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
                            controller: confirmPasswordcontroller,
                            validator: (p0) {
                              if (p0 == null || p0.isEmpty) {
                                return "Enter your Confirem Password";
                              } else {
                                return null;
                              }
                            },
                            hintText: "Confirm password",
                            keyboardType: TextInputType.visiblePassword,
                            obscureTextWidget: true,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10, right: 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  "Alread ready have account? ",
                                  style: GoogleFonts.nunito(
                                      fontSize: 15,
                                      color: Colors.black54,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "SignUp now",
                                  style: GoogleFonts.nunito(
                                      fontSize: 16,
                                      color: const Color.fromARGB(
                                          255, 92, 39, 176),
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
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
                              onPressed: () {
                                if (_formkey.currentState!.validate()) {
                                  setState(() {
                                    name = namecontroller.text;
                                    email = emailcontroller.text;
                                    password = passwordcontroller.text;
                                    confirmPassword =
                                        confirmPasswordcontroller.text;
                                  });
                                }
                                registration();
                              },
                              child: Text(
                                "Register now",
                                style: GoogleFonts.nunito(
                                  fontSize: 16,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 50,
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
