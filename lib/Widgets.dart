// ignore_for_file: non_constant_identifier_names, prefer_const_constructors, file_names

import 'package:flutter/material.dart';
import 'package:timbalfinal/game.dart';

Widget TopCards(double height, double width, String card) {
  return ClipRRect(
    borderRadius: BorderRadius.circular(20),
    child: Container(child: Image.asset(card), height: height, width: width),
  );
}

Widget MiddleCard(double height, double width) {
  return ClipRRect(
    borderRadius: BorderRadius.circular(20),
    child: Container(
      height: height,
      width: width,
      child: isBack ? Image.asset(backCard) : Image.asset(guessCard),
    ),
  );
}

TextStyle scoreStyle = TextStyle(
  fontSize: 50,
  fontWeight: FontWeight.bold,
  color: Colors.white,
);

Widget Buttons(double height, double width, String txtButton) {
  return ClipRRect(
    borderRadius: BorderRadius.circular(20),
    child: Container(
      child: Center(
        child: Text(
          txtButton,
          style: TextStyle(fontSize: 20),
          textAlign: TextAlign.center,
        ),
      ),
      height: height,
      width: width,
      color: Colors.white,
    ),
  );
}

Widget miniBox() {
  return Container(
    child: Center(
      child: Text(answer,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          )),
    ),
    color: Colors.white,
    height: 40,
    width: 40,
  );
}

Widget drawerMenuItem(String text, IconData icon) {
  return ListTile(
    leading: Icon(
      icon,
      color: Color.fromARGB(255, 1, 4, 53),
      size: 30,
    ),
    title: Text(text,
        style: TextStyle(color: Color.fromARGB(255, 1, 4, 53), fontSize: 20)),
  );
}
