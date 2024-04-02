import 'dart:convert';
import 'user_score.dart';

class UserScoreList {

  List<UserScore> userScoreTableInfo = [];


  saveToUserTable(Map<String, dynamic> response) {
    dynamic message = response['message'];


    List<Map<String, dynamic>> messageList = (json.decode(message) as List<dynamic>)
        .cast<Map<String, dynamic>>();

    List<UserScore> newQuestionList = messageList
        .map((json) => UserScore.fromJson(json))
        .toList();
    userScoreTableInfo = newQuestionList;
    //print(userScoreTableInfo);

  }


}