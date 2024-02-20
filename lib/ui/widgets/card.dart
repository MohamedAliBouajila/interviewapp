import 'package:flutter/material.dart';
import 'package:interviewapp/utils/colors.dart';

class CardWidget extends StatelessWidget {
  final String cardName;
  final String imagePath;

  CardWidget(this.cardName, this.imagePath);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Color.fromARGB(255, 233, 231, 231),
      elevation: 0,
      child: SizedBox(
        height: 150,
        width: 150,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              imagePath,
              height: 50,
              width: 50,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                cardName,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
