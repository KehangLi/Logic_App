import 'dart:core';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChoiceChangeNotifier extends Notifier <List<MaterialAccentColor>> {

  bool continueEnable = false;

  List<MaterialAccentColor> build(){
    return state = [Colors.greenAccent,Colors.greenAccent,Colors.greenAccent,Colors.greenAccent];
  }

  reset (){
    state = [Colors.greenAccent,Colors.greenAccent,Colors.greenAccent,Colors.greenAccent];
  }

  int changeChoice(int index){
    return index;
  }

  List<MaterialAccentColor> selectedA(){
    continueEnable = true;
    return state = [Colors.redAccent,Colors.greenAccent,Colors.greenAccent,Colors.greenAccent];
  }

  List<MaterialAccentColor> selectedB(){
    continueEnable = true;
    return state = [Colors.greenAccent,Colors.redAccent,Colors.greenAccent,Colors.greenAccent];
  }

  List<MaterialAccentColor> selectedC(){
    continueEnable = true;
    return state = [Colors.greenAccent,Colors.greenAccent,Colors.redAccent,Colors.greenAccent];
  }

  List<MaterialAccentColor> selectedD(){
    continueEnable = true;
    return state = [Colors.greenAccent,Colors.greenAccent,Colors.greenAccent,Colors.redAccent];
  }

  resetColor(){
    return state = [Colors.greenAccent,Colors.greenAccent,Colors.greenAccent,Colors.greenAccent];
  }

  resetContinue() {
    continueEnable = false;
  }

}


