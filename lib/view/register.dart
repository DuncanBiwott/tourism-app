import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../controller/Root/auth.dart';
import 'login.dart';


class SignUp extends StatefulWidget {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  SignUp({
    Key? key,
    required FirebaseAuth auth,
    required FirebaseFirestore firestore,
  }) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _passwordcontroller = TextEditingController();
  final TextEditingController _cpasswordcontroller = TextEditingController();
  final TextEditingController _namecontroller = TextEditingController();

  bool show_pass=false;
   void show_password(){
    setState(() {
      show_pass=true;
    });
  }


  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: Container(
              color: Colors.white,
              height: 700,
              
              width: 400,
              child: Padding(
                padding:const  EdgeInsets.all(20),
                
                child:  Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        
                        Center(child:  Text("Register",style: TextStyle(color: Colors.black,fontSize: 50),)),
                  
                         const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: _namecontroller,
                          textAlign: TextAlign.start,
                          keyboardType:TextInputType.text ,
                          decoration:  InputDecoration(
                            label: Text("Name",style: TextStyle(color: Colors.black),),
                            
                            border: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(8.0)),
                            ),
                            contentPadding:
                                const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                          ),
                        ),const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: _emailcontroller,
                          textAlign: TextAlign.start,
                          keyboardType:TextInputType.emailAddress ,
                          decoration:  InputDecoration(
                            label: Text("Email",style: TextStyle(color: Colors.black),),
                            
                            border: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(8.0)),
                            ),
                            contentPadding:
                                const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                          ),
                        ),const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: _passwordcontroller,
                          textAlign: TextAlign.start,
                          keyboardType:TextInputType.text ,
                          decoration:  InputDecoration(
                            label: Text("Password",style: TextStyle(color: Colors.black),),
                            
                            border: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(8.0)),
                            ),
                            contentPadding:
                                const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                          ),
                        ),const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: _cpasswordcontroller,
                          textAlign: TextAlign.start,
                          keyboardType:TextInputType.emailAddress ,
                          decoration:  InputDecoration(
                            label: Text("Confirm Password",style: TextStyle(color: Colors.black),),
                            hintText: "Confirm Password",
                            
                            border: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(8.0)),
                            ),
                            contentPadding:
                                const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                          ),
                        ),const SizedBox(
                          height: 20,
                        ),
                        
                       
                    
                        
                        
                        const SizedBox(height: 10,),
                      
                          ElevatedButton(
                            onPressed: () async {
                        String? rvalue;
                        if(_passwordcontroller.text !=_cpasswordcontroller.text){
                          rvalue="Password does not much";
                          
                          
                        }else{
                         rvalue =
                            await Authenticate(auth: widget.auth).createAccount(
                          email: _emailcontroller.text,
                          password: _passwordcontroller.text,
                        );
                        }
                        if (rvalue == "Success") {
                          _emailcontroller.clear();
                          _passwordcontroller.clear();
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) =>  Login(auth: widget.auth,firestore: widget.firestore,)),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(rvalue!)),
                          );
                        }
                      },
                      
                             style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(Colors.black),
                              ),
                            child: Padding(
                              padding: EdgeInsets.all(8),
                              child:Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Sign Up",style: TextStyle(color: Colors.white,letterSpacing: 0.5),),
                              ],
                            ),
                              )
                          ),
      
                    
                        
      
                          SizedBox(height: 8,),
      
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text("Already have an account?"),
                                
                                TextButton(onPressed: (() {
                                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Login(auth: widget.auth,firestore: widget.firestore,)));
                              
                            }), child: Text("Login",style: TextStyle(color: Colors.black,letterSpacing: 0.5),)),
                                
                                
                              ],
                            ),
                          )
                        
                          
                      ],
                    ),
                
                ),
            ),
          ),
          ),
      ),
      );


  }
}