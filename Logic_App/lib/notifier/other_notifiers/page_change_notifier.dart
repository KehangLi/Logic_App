import 'package:flutter_riverpod/flutter_riverpod.dart';

class PageChangeNotifier extends Notifier <int> {

  @override
  int build(){
    return state = 0;
  }

  void changePage(int index){
    if(index != state){
      state = index;
    }
  }

  //go back to statistics
  void goToStatistics(){
    state = 1;
  }

  void goToQuiz(){
    state = 0;
  }

}
