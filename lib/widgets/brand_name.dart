import 'package:flutter/material.dart';

class BrandName extends StatelessWidget {
  const BrandName({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        Text(
          ' ChillPill ',
          style: TextStyle(
            backgroundColor: Colors.orangeAccent,
            color: Color(0xff151A23),
          ),
        ),
        Text(
          ' App',
          style: TextStyle(
            color: Colors.orangeAccent,
          ),
        )
      ],
    );
  }
}
