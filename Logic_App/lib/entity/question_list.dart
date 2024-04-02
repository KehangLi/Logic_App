import 'dart:convert';
import 'question.dart';

class QuestionsList{

  List<TestQuestions> qList = [
    TestQuestions(1, "What is the negation of the statement 'It is raining'?",
        "It is sunny", "It is snowing", "It is windy", "It is cloudy", "B", 0),
    TestQuestions(2, "If p represents 'The sky is blue' and q represent 'The grass is green', what is conjunction"
        "p and q?", "The sky is blue or the grass is green", "The sky is blue and the grass is green",
        "Either the sky is not blue or the grass is not green", "Neither the sky is blue nor the grass is green", "B", 0),
    TestQuestions(3, "What is the disjunction of the statements 'It is Monday' and 'It is Friday'?",
        "It is Monday or it is Friday", "It is Monday and it is Friday", "It is not Monday or it is not Friday", "It is neither Monday nor Friday", "A", 0),
    TestQuestions(4, "If p represents ’The car is red‘ and q represents ‘The bike is blue’, what is the negation of p or q?",
        "The car is not red or the bike is not blue", "The car is red and the bike is blue",
        "The car is red or the bike is blue", "The car is not red and the bike is not blue", "A", 0),
    TestQuestions(5, "What is the implication of the statement 'If it is raining, then the streets are wet' ",
        "It is raining and the streets are wet", "It is not raining and the streets are wet",
        "If the streets are wet, then it is raining", "If it is raining, then the streets are dry", "D", 0),
    TestQuestions(6, "Which logical operator represents 'exclusive or' ",
        "∧ (conjunction)", "∨ (disjunction)", "¬ (negation)", "⊕ (exclusive disjunction)", "D", 0),
    TestQuestions(7, "What is the contrapositive of the statement 'If it is sunny, then I will go for a walk' ",
        "If I will not go for a walk, then it is sunny", "If I will go for a walk, then it is sunny",
        "If it is not sunny, then I will not go for a walk", "If it is not sunny, then I will go for a walk", "C", 0),
    TestQuestions(8, "Which logical operator has the highest precedence?",
        "∧ (conjunction)", "∨ (disjunction)", "¬ (negation)", "⇒ (implication)", "C", 0),
    TestQuestions(9, "What is the truth value of the statement 'Either it is snowing or it is not snowing'?",
        "True", "False", "Depends on the weather forecast", "Cannot be determined", "A", 0),
    TestQuestions(10, "Which of the following is a valid tautology?",
        "p ∧ ¬q", "p ∨ ¬p", "p ⇒ ¬p", "p ⇔ ¬p", "B", 0),
  ];


  saveToQuestionList(Map<String, dynamic> response) {
    dynamic message = response['message'];
    if (message is String) {
      List<Map<String, dynamic>> messageList = (json.decode(message) as List<dynamic>)
          .cast<Map<String, dynamic>>();

      List<TestQuestions> newQuestionList = messageList
          .map((json) => TestQuestions.fromJson(json))
          .toList();

      qList = newQuestionList;
    }else {
      print("failed to save questions!");
    }
    return qList;
  }


}

