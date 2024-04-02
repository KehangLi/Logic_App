import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logic_app/providers/providers.dart';

class LoginGuest extends ConsumerWidget {
  const LoginGuest({super.key});

  @override
  Widget build(BuildContext context,ref) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Align(
        alignment: Alignment.centerRight,
        child: TextButton(
            onPressed: (){
              Navigator.of(context).pushNamedAndRemoveUntil('selectDifficultyOffline', (route) => false);
              ref.read(currentModelNotifierProvider.notifier).selectOfflineModel();
            },
            child: const Text(
              "Login As Guest",
              style: TextStyle(fontSize: 14, color: Colors.grey),
            )
        ),
      ),
    );
  }
}


