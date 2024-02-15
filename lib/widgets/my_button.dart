import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  //thi is the constructor
MyButton({required this.color, required this.title, required this.onPressed});
// the properities
final Color color;
final String title;
final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Material(
        elevation: 7,//the shaddow 
        color: color,// form the constructor
        borderRadius: BorderRadius.circular(10),
        child: MaterialButton(
          onPressed:  onPressed,//from the construtor
        minWidth: 200,
        height: 45,
        child: Text(
          title, //from the constructor
          style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}