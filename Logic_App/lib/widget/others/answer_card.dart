import 'package:flutter/material.dart';

Widget answerCard(String text, Color cardColor, BuildContext context) {
  return SizedBox(
    height: MediaQuery.of(context).size.height * 0.1,
    width: MediaQuery.of(context).size.width,
    child: Card(
      color: cardColor,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20))),
      elevation: 3.5,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Center(
            child: Text(
          text,
          style: const TextStyle(color: Colors.black),
          textAlign: TextAlign.center,
        )),
      ),
    ),
  );
}
