import 'package:flutter_riverpod/flutter_riverpod.dart';

class RegistrationEnableNotifier extends Notifier <bool> {

  @override
  bool build(){
    return state = false;
  }

  void check(bool c){
    state = c;
  }

}
