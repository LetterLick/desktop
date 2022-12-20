import 'package:flutter/material.dart';

class Desing {
  //mail item
  Color mailListBackgroundColor = const Color(0xFFEAEAFB);
  Color mailListItemBackgroundColor = const Color(0xFFF5F5FF);
  Color mailListItemBackgroundColorHover = Color.fromARGB(17, 64, 195, 255);
  Color mailListItemBackgroundColorIsSelected =
      Color.fromARGB(66, 64, 195, 255);
  Color mailListItemIsRead = Colors.grey;
  Color mailListItemIsNotRead = Colors.blue;
  TextStyle mailListItemFromStyle = const TextStyle(
      fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black);
  TextStyle mailListItemSubjectStyle =
      const TextStyle(fontSize: 24, color: Colors.black);
  TextStyle mailListItemPreviewtStyle =
      const TextStyle(fontSize: 16, color: Color(0xFF565656));
  //end mail item
}

Desing design = Desing();
