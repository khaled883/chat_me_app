// ignore_for_file: prefer_const_constructors, unused_local_variable

import 'package:chat_me/screens/chat_screen.dart';
import 'package:chat_me/widgets/my_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class RegistrationScreen extends StatefulWidget {

  static const String screenRoute='registration_screen';//this is the route we use to call the screen
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  late String email;
  late String password;
  bool showSpinner= false;
  final _auth = FirebaseAuth.instance;
  // these are the variables to get and store the values from text fields
  // and they are late because they are not initialized yet
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,//the parameter that controles the progress hud
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                height: 180,
                child: Image.asset('images/chat-icon.png')
              ),
              SizedBox(height: 70,),
              TextField(
                keyboardType: TextInputType.emailAddress,
                //macking the keyboard rteady to enter the email,i.e showing the (@)button 
                //and (.com) button
                textAlign: TextAlign.center,
                onChanged: (value){
                  email=value;//storing the value from the field in the variable
                },
                decoration: InputDecoration(
                  hintText: 'Enter your E-mail',
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 15,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  enabledBorder: OutlineInputBorder(
                    //enabled border when the field is not selected
                    borderSide: BorderSide(color: Colors.amber,width:1,),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    //focused border when the field is selected
                    borderSide: BorderSide(color: Color.fromARGB(255, 13, 82, 185),width:3,),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              SizedBox(height: 10,),
              TextField(
                obscureText: true,
                textAlign: TextAlign.center,
                onChanged: (value){
                  password=value;
                  //storing the value of text field in the variable to handle it
                },
                decoration: InputDecoration(
                  hintText: 'Enter your Password',
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 15,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  enabledBorder: OutlineInputBorder(
                    //enabled border when the field is not selected
                    borderSide: BorderSide(color: Colors.amber,width:1,),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    //focused border when the field is selected
                    borderSide: BorderSide(color: Color.fromARGB(255, 13, 82, 185),width:3,),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              MyButton(
                color: Color.fromARGB(255, 13, 82, 185), 
                title: 'Register', 
                onPressed: () async {
                  //print(email);
                  //print(Password);
                 setState(() {
                   showSpinner=true;
                 });
                 try {
                  
                   final newUser = await _auth.createUserWithEmailAndPassword
                    (email: email, password: password);
                    
                    Navigator.pushNamed(context, ChatScreen.screenRoute);
                    setState(() {
                      showSpinner=false;
                    });
                    
                 } catch (e) {
                   print(e);
                   setState(() {
                     showSpinner=false;
                   });
                 }
                },
                )
            ],
          ),
        ),
      ),
    );
  }
}