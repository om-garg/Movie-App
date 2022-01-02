import 'package:flutter/material.dart';

class PersonTile extends StatelessWidget {
  final String imgUrl;
  final String name;

  const PersonTile({
    Key? key,
    required this.imgUrl,
    required this.name,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      width: 100,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(imgUrl),
            backgroundColor: Colors.transparent,
            radius: 25,
          ),
          const SizedBox(
            height: 2,
          ),
          Wrap(direction: Axis.vertical, children: [
            Text(
              name,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 8,
                fontWeight: FontWeight.bold,
                letterSpacing: 1,
              ),
            ),
          ])
        ],
      ),
    );
  }
}
