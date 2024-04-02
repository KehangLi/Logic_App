import 'dart:convert';
import 'package:http/http.dart' as http;
import 'port_configuration.dart';


Future<Map<String, dynamic>> getHighScoreTable() async{

  var portNumber = PortConfig.getPortNumber();

  var url = Uri.parse('http://localhost:$portNumber/getHighScoreTable');
  var response = await http.get(url);
  if(response.statusCode == 200){
    print("users' score received");
  }
  var jsonResponse = json.decode(response.body);
  print("JSON response: $jsonResponse");
  return jsonResponse;
}


Future<Map<String, dynamic>> getAllQuestions(String level) async {

  var portNumber = PortConfig.getPortNumber();


  var url = Uri.parse('http://localhost:$portNumber/getQuestion/$level');

  var response = await http.get(url);
  if (response.statusCode == 200) {
    print("get the questions");
  }
  var jsonResponse = json.decode(response.body);
  print("JSON response: $jsonResponse");
  return jsonResponse;
}


void sendAnswer (List<int> currentID, String username, String level, List<String> answersList) async{

  var portNumber = PortConfig.getPortNumber();

  List<Map<String,dynamic>> sendList = [];
  for(int i =0; i<10; i++){
    sendList.add({"Id": currentID[i], "SelectedAnswer": answersList[i]});
  }
  String sendL = json.encode(sendList);
  //print(sendL);

  String url = 'http://localhost:$portNumber/sendAnswer/' + username + "/" + level;
  //print(url);

  try {
    var response = await http.post(Uri.parse(url),
        headers: {"Content-Type": "application/json"},
        body: sendL);
    // Check the response status
    if (response.statusCode == 200) {
      print('Data posted successfully');
    } else {
      print('Failed to post data. Status code: ${response.statusCode}');
    }
  } catch (e) {
    print('Failed to post data. Error: $e');
  }

}