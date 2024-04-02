import 'package:flutter_riverpod/flutter_riverpod.dart';


class SelectedAnswersNotifier extends Notifier <List<String>>{

  @override
  List<String> build(){
    return state = ["C","C","C","C","C","C","C","C","C","C"];
  }

  reset(){
    state = ["C","C","C","C","C","C","C","C","C","C"];
  }

  selectA(int i){
    state[i] = "A";
  }

  selectB(int i){
    state[i] = "B";
  }

  selectC(int i){
    state[i] = "C";
  }

  selectD(int i){
    state[i] = "D";
  }

  List<String> getCurrentAnswerList(){
    return state;
  }


}

