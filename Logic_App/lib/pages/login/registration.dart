import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logic_app/widget/all_widgets.dart';
import 'package:logic_app/util/all_utils.dart';
import 'package:logic_app/providers/providers.dart';
import 'package:logic_app/http_request/all_requests.dart';

class Registration extends ConsumerWidget {
  String? userName;
  String? password;
  String? rePassword;
  bool loginEnable = false;

  Registration({super.key});

  @override
  Widget build(BuildContext context, ref) {
    return Scaffold(
      appBar: appBar("registration", "login", () {
        Navigator.pushNamed(context, 'login');
      }),
      body: Container(
        child: ListView(
          children: [
            LoginEffect(),
            LoginInput(
              "Username",
              "please enter username",
              onChanged: (text) {
                userName = text;
                checkInput();
              },
            ),
            LoginInput(
              "Password",
              "please enter password",
              obscureText: true,
              onChanged: (text) {
                password = text;
                checkInput();
              },
            ),
            LoginInput(
              "Password",
              "please enter password again",
              obscureText: true,
              onChanged: (text) {
                rePassword = text;
                checkInput();
              },
            ),
            Padding(
                padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
                child: ElevatedButton(
                  onPressed: () async {
                    if (!checkInput()) {
                      showSnackBar(context, "Please fill all the information");
                    } else if (password != rePassword) {
                      showSnackBar(context, "entered password do not match");
                    } else {
                      String mess =
                          await sendRegistration(userName!, password!);
                      showSnackBar(context, mess);
                    }
                  },
                  child: const Text("registration"),
                  style: ButtonStyle(
                    overlayColor:
                        MaterialStateProperty.all(const Color(0xff31C27C)),
                    shadowColor: MaterialStateProperty.all(Colors.red),
                    elevation: MaterialStateProperty.all(3),
                  ),
                )),
          ],
        ),
      ),
    );
  }

  bool checkInput() {
    bool enable;
    enable = ((userName?.isNotEmpty ?? false) &&
        (password?.isNotEmpty ?? false) &&
        (rePassword?.isNotEmpty ?? false));
    return enable;
  }
}
