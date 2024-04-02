import 'dart:convert';
import 'package:http/http.dart' as http;
import 'port_configuration.dart';

Future<String> loginRequest(String u, String p) async {

  var portNumber = PortConfig.getPortNumber();

  var url = Uri.parse('http://localhost:$portNumber/login');
  var loginResponse;

  try {
    var response = await http.post(url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({'Username': u, 'Password': p}));

    // Check the response status
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      loginResponse = data['message'];
      print(loginResponse);

    } else {
      // Parse the error response body
      var data = jsonDecode(response.body);
      loginResponse = data['message'];
      print(loginResponse);
    }
  } catch (e) {
    loginResponse = e;
    print('Failed to post data. Error: $e');
  }
  return loginResponse;

}


void sendConsumingTime (List<int> currentID, List<int> consumingTime, String username, String level) async{

  var portNumber = PortConfig.getPortNumber();

  List<Map<String,dynamic>> sendList = [];
  for(int i =0; i<10; i++){
    sendList.add({"Id": currentID[i], "ConsumingTime": consumingTime[i]});
  }
  String sendL = json.encode(sendList);
  //print(sendL);

  String url = 'http://localhost:$portNumber/sendConsumingTime/' + username + "/" + level;

  try {
    var response = await http.post(Uri.parse(url),
        headers: {"Content-Type": "application/json"},
        body: sendL);

    if (response.statusCode == 200) {
      print('Data posted successfully');
    } else {
      print('Failed to post data. Status code: ${response.statusCode}');
    }
  } catch (e) {
    print('Failed to post data. Error: $e');
  }

}



Future<String> sendRegistration(String u, String p) async {

  var portNumber = PortConfig.getPortNumber();
  var url = Uri.parse('http://localhost:$portNumber/registration');

  var mess;
  try {
    var response = await http.post(url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({'Username': u, 'Password': p}));

    // Check the response status
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      mess = data['message'];
      //print(mess);
    } else {
      var data = jsonDecode(response.body);
      mess = data['message'];
      //print(mess);
    }
  } catch (e) {
    mess = e;
    print('Failed to post data. Error: $e');
  }
  return mess;

}