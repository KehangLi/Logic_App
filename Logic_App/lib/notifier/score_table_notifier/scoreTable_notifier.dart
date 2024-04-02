import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logic_app/entity/user_score_list.dart';
import 'package:logic_app/http_request/get_request.dart';

class HighScoreTableNotifier extends Notifier <UserScoreList> {

  @override
  UserScoreList build() => UserScoreList();

  Future<Map<String, dynamic>> getHighScoreTable() async{
    return await getHighScoreTable();
  }

  saveToUserTable(response){
    state.saveToUserTable(response);
  }


}
