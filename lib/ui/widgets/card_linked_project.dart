import 'package:flutter/material.dart';
import 'package:interviewapp/models/projectperson.dart';

import '../../models/person.dart';
import '../../utils/colors.dart';

class LinedProjectCard extends StatelessWidget {
  final ProjectPerson project;
  const LinedProjectCard({Key? key, required this.project}) : super(key: key);

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
            child: Container(
              color: Color.fromARGB(118, 206, 206, 206),
              height: 80,
              width: 80,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                 const Icon(Icons.calendar_month,size: 28,),
                 const SizedBox(height: 5,),
                 Text(project.projecto.date.substring(1,10))
                ],
              ),
            )
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Project ID: ${project.id.idpro.toString()} | Person ID: ${project.id.idperson.toString()}",
                style: const TextStyle(fontWeight: FontWeight.w500),
              ),
               const SizedBox(height: 4),
              Text(
                "Project taken by : ${project.persono.username}",
                style: const TextStyle(fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 4),
              Text(
                project.projecto.description,
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
