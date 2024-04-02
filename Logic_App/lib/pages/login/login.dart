import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logic_app/widget/all_widgets.dart';
import 'package:logic_app/util/all_utils.dart';
import 'package:logic_app/providers/providers.dart';
import 'package:logic_app/http_request/all_requests.dart';

class Login extends ConsumerWidget {
  String? userName;
  String? password;
  String? rePassword;
  bool loginEnable = false;

  Login({super.key});

  @override
  Widget build(BuildContext context, ref) {
    return Scaffold(
      appBar: appBar("login", "registration", () {
        Navigator.of(context)
            .pushNamedAndRemoveUntil('registration', (route) => false);
      }),
      body: Container(
        child: ListView(
          children: [
            const LoginEffect2(),
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
            Padding(
                padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
                child: ElevatedButton(
                  onPressed: () async {
                    if (!checkInput()) {
                      showSnackBar(context, "Please fill all the information");
                    } else {
                      var loginResponse =
                          await loginRequest(userName!, password!);
                      showSnackBar(context, loginResponse);

                      if (loginResponse == "Login successful") {
                        ref
                            .read(currentUserNotifierProvider.notifier)
                            .getUser(userName!);
                        ref
                            .read(currentModelNotifierProvider.notifier)
                            .selectOnlineModel();
                        Navigator.of(context).pushNamedAndRemoveUntil(
                            'selectDifficulty', (route) => false);
                      }
                    }
                  },
                  child: const Text("login"),
                  style: ButtonStyle(
                    overlayColor:
                        MaterialStateProperty.all(const Color(0xff31C27C)),
                    shadowColor: MaterialStateProperty.all(Colors.red),
                    elevation: MaterialStateProperty.all(3),
                  ),
                )),
            const LoginGuest(),
          ],
        ),
      ),
    );
  }

  bool checkInput() {
    bool enable;

    enable =
        ((userName?.isNotEmpty ?? false) && (password?.isNotEmpty ?? false));

    return enable;
  }
}
