import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Utilities{
  static showErrorSnackBar(BuildContext context,String message ){
    SnackBar snackBar = SnackBar(
      backgroundColor: Colors.black,
      content: Text(
        message,
        style: const TextStyle(color: Colors.redAccent, letterSpacing: 0.5),
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);

  }
  static showSnackBar(BuildContext context,String message ){
    SnackBar snackBar = SnackBar(
      content: Text(
        message,
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}