import 'package:flutter/material.dart';

appBar(String title, String rightTitle, VoidCallback rightButtonClick) {
  return AppBar(
    backgroundColor: Colors.deepOrangeAccent,
    centerTitle: true,
    titleSpacing: 0,
    title: Text(
      title,
      style: const TextStyle(fontSize: 18),
    ),
    actions: [
      InkWell(
        onTap: rightButtonClick,
        child: Container(
          padding: const EdgeInsets.only(left: 15, right: 15),
          alignment: Alignment.center,
          child: Text(
            rightTitle,
            style: TextStyle(fontSize: 18, color: Colors.grey[500]),
            textAlign: TextAlign.center,
          ),
        ),
      )
    ],
  );
}
