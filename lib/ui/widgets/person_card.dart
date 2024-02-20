import 'package:flutter/material.dart';

import '../../models/person.dart';
import '../../utils/colors.dart';

class CardOfUsers extends StatelessWidget {
  final Person person;
  const CardOfUsers({Key? key, required this.person}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Color.fromARGB(255, 238, 238, 238),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              "https://images.unsplash.com/photo-1438761681033-6461ffad8d80?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
              fit: BoxFit.cover,
              width: 60,
              height: double.infinity,
            ),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                person.idperson.toString(),
                style: const TextStyle(fontWeight: FontWeight.w500),
              ),
              Text(
                person.username!,
                style: const TextStyle(fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 4),
              Text(
                "${person.prenom} ${person.nom}",
                style: const TextStyle(
                  fontSize: 12,
                  color: AppColors.greyTextColor,
                ),
              ),
            ],
          ),
          const Spacer(),
          Container(
            height: 50,
            width: 35,
            decoration: BoxDecoration(
              color: AppColors.backgroundColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.visibility,
                  color: Color.fromARGB(202, 248, 173, 143),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
