import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyButton extends StatefulWidget {
  final String text;
  final Color color;
  final Function onTap;

  const MyButton({
    Key? key,
    required this.text,
    required this.color,
    required this.onTap,
  }) : super(key: key);

  @override
  State<MyButton> createState() => _MyButtonState();
}

class _MyButtonState extends State<MyButton> {
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      height: 50,
      padding: EdgeInsets.all(8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      onPressed: () {
        widget.onTap(); 
      },
      child: Text(
        widget.text,
        style: TextStyle(color: Colors.white, fontSize: 23),
      ), // Apply TextStyle to Text widget
      color: widget.color, // Access color from widget
    );
  }
}
