import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LightDarkModelNotifier extends Notifier <List<bool>>{

  @override
  List<bool> build(){
    return state = [true,false];
  }

  selectLightOrDark(int index){
    if(index == 0 ){
      state = [true,false];
    }else {
      state = [false, true];
    }
  }
}

