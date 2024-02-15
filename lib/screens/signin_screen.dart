// ignore_for_file: prefer_const_constructors

import 'package:chat_me/screens/chat_screen.dart';
import 'package:chat_me/widgets/my_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class SignInScreen extends StatefulWidget {
//this is the key we use to call this screen, look at routes in main.dart
  static const String screenRoute='signin_screen';//static const to not rebuild every time
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _auth=FirebaseAuth.instance;

  late String email;
  late String password;
  bool showSpinner=false;
  void showErrorMessage(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
    ),
  );
}
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // ignore: sized_box_for_whitespace
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
                  email=value;
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
                  password= value;
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
                color: Colors.amber,//Color.fromARGB(255, 13, 82, 185), 
                title: 'Signin', 
                onPressed: ()async{
                  setState(() {
                    showSpinner=true;
                  });
                   try {
                      final user = await  _auth.signInWithEmailAndPassword(
                        email: email, password: password);
                      if (user!= null){
                        Navigator.pushNamed(context, ChatScreen.screenRoute);
                        setState(() {
                          showSpinner=false;
                        });
                      }
                    } catch (e) {
                    print(e);
                    showErrorMessage(context, 'Invalid user name or password');
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