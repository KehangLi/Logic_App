import 'package:flutter_riverpod/flutter_riverpod.dart';

class CurrentModelNotifier extends Notifier <bool>{

  @override
  bool build(){
    return state = false;
  }

  selectOnlineModel(){
    state = true;
  }

  selectOfflineModel(){
    state = false;
  }

  reset(){
    state = false;
  }



}

