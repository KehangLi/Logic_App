import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logic_app/entity/question_list.dart';

class QuestionsNotifier extends Notifier <QuestionsList> {

  @override
  QuestionsList build() => QuestionsList();


  saveQuestion(response){
    state.saveToQuestionList(response);
  }
}
