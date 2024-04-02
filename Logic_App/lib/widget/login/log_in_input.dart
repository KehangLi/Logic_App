import 'package:flutter/material.dart';

class LoginInput extends StatefulWidget {
  final String title;
  final String hint;
  final ValueChanged<String>? onChanged;
  final ValueChanged<bool>? focusChanged;
  final bool lineStretch;
  final bool obscureText;
  final TextInputType? keyboardType;

  const LoginInput(this.title, this.hint,
      {Key? key,
        this.onChanged,
        this.focusChanged,
        this.lineStretch = true,
        this.obscureText = false,
        this.keyboardType})
      : super(key: key);

  @override
  State<LoginInput> createState() => _LoginInputState();
}

class _LoginInputState extends State<LoginInput> {


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.only(left: 15),
              width: 100,
              child: Text(
                widget.title,
                style: const TextStyle(fontSize: 16),
              ),
            ),
            _input()
          ],
        )
      ],
    );
  }

  _input() {
    return Expanded(
        child: TextField(
          onChanged: widget.onChanged,
          obscureText: widget.obscureText,
          keyboardType: widget.keyboardType,
          autofocus: !widget.obscureText,
          cursorColor: Colors.lightGreenAccent,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w300),
          decoration: InputDecoration(
              contentPadding: const EdgeInsets.only(left: 20, right: 20),
              border: InputBorder.none,
              hintText: widget.hint,
              hintStyle: const TextStyle(fontSize: 15, color: Colors.grey)),
        ));
  }

}


// ref: https://juejin.cn/post/6844903831294181390?searchId=202403270503470246A7A942DF024C38E7