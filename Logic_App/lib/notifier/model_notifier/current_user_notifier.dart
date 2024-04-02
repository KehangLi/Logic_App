import 'package:flutter_riverpod/flutter_riverpod.dart';

class CurrentUserNotifier extends Notifier <String>{

  @override
  String build(){
    return state = "";
  }


  getUser(String user){
    state = user;
  }

  reSet(){
    state = "";
  }

}

