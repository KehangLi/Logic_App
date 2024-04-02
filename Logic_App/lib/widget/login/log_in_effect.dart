import 'package:flutter/material.dart';

class LoginEffect extends StatelessWidget {
  const LoginEffect({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      //padding: EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
          color: Colors.grey[100],
          border: Border(bottom: BorderSide(color: Colors.grey[300]!))),
      child: const Image(
        fit: BoxFit.cover,
        image: AssetImage('r2.jpeg'),
      ),
    );
  }
}

class LoginEffect2 extends StatelessWidget {
  const LoginEffect2({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      //padding: EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
          color: Colors.grey[100],
          border: Border(bottom: BorderSide(color: Colors.grey[300]!))),
      child: const Image(
        fit: BoxFit.cover,
        image: AssetImage('gs.png'),
      ),
    );
  }
}
