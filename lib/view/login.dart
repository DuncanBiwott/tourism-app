import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:tourism/controller/Root/auth.dart';
import 'package:tourism/view/forgot_pass.dart';
import 'package:tourism/view/register.dart';

import 'home.dart';

class Login extends StatefulWidget {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Login({
    Key? key,
    required FirebaseAuth auth,
    required FirebaseFirestore firestore,
  }) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _passwordcontroller = TextEditingController();

  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Container(
            color: Colors.white,
            height: 500,
            width: 400,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Center(
                      child: Text(
                    "Login",
                    style: TextStyle(color: Colors.black, fontSize: 50),
                  )),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: _emailcontroller,
                    textAlign: TextAlign.start,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      label: Text("Email"),
                      hintText: "Email address",
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 20.0),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: _passwordcontroller,
                    textAlign: TextAlign.start,
                    decoration: const InputDecoration(
                      label: Text("Password"),
                      hintText: "Password",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 20.0),
                    ),
                    obscureText: true,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                      onPressed: () async {
                        setState(() {
                          _isLoading = true; // set loading state
                        });
                        final rvalue =
                            await Authenticate(auth: widget.auth).signIn(
                          email: _emailcontroller.text,
                          password: _passwordcontroller.text,
                        );
                        if (rvalue == "Success") {
                          _emailcontroller.clear();
                          _passwordcontroller.clear();

                          Flushbar(
                            message: "Login successful",
                            duration: Duration(seconds: 3),
                            backgroundColor: Colors.green,
                            flushbarPosition: FlushbarPosition.TOP,
                          ).show(context);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Home(
                                    auth: widget.auth,
                                    firestore: widget.firestore)),
                          );
                        } else {
                          Flushbar(
                            message: rvalue!,
                            duration: Duration(seconds: 3),
                            backgroundColor: Colors.red,
                            flushbarPosition: FlushbarPosition.TOP,
                          ).show(context);
                        }
                      },
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.black),
                      ),
                      child:_isLoading?
                      CircularProgressIndicator()
                      :
                       Padding(
                        padding: EdgeInsets.all(8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Login",
                              style: TextStyle(
                                  color: Colors.white, letterSpacing: 0.5),
                            ),
                          ],
                        ),
                      )),
                  const SizedBox(
                    height: 30,
                  ),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: TextButton(
                        onPressed: (() {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ForgotPass()),
                          );
                        }),
                        child: Text(
                          "Forgot Password?",
                          style: TextStyle(color: Colors.black),
                        )),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Row(
                    children: [
                      const Text("Don't have an account?"),
                      TextButton(
                          onPressed: (() {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignUp(
                                        auth: widget.auth,
                                        firestore: widget.firestore,
                                      )),
                            );
                          }),
                          child: Text(
                            "Register",
                            style: TextStyle(color: Colors.black),
                          )),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
