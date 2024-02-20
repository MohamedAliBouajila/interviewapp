import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:interviewapp/ui/widgets/map_image.dart';
import '../../models/project.dart';
import '../../utils/colors.dart';


class ProjectCard extends StatefulWidget {
  final Project project;

  const ProjectCard({required this.project, Key? key}) : super(key: key);

  @override
  State<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 280,
      margin: const EdgeInsets.only(left: 8, right: 8),
      child: Stack(
        children: [
          _buildCardImage(),
          _buildCardDesc(),
          Positioned(
            right: 15,
            top: 15,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 5),
            decoration:const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(15))
            ,color:  Color.fromARGB(255, 255, 255, 255)
            ),
            height: 50,
            child:Row(
              children: [
              const  Icon(Icons.calendar_month),
              SizedBox(width: 5,),
                Text(widget.project.date.substring(1,11))
              ],
            )
          )),
Container(
  decoration:BoxDecoration(color:Color.fromARGB(0, 244, 67, 54) ),
  height: 280,
  width: double.infinity,
)
        ],
      ),
    );
  }

  _buildCardImage() => Container(
        height: 280,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.circular(16),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: SizedBox(
            width: double.infinity,
           height: double.infinity,
            child: MapImageScreen(latitude: widget.project.latitude, longitude: widget.project.longitude,)),
        ),
      );

  _buildCardDesc() => Positioned(
        bottom: 15,
        right: 0,
        left: 0,
        child: Container(
          height: 60,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          margin: const EdgeInsets.symmetric(horizontal: 18),
          decoration: BoxDecoration(
              color: AppColors.whiteColor,
              borderRadius: BorderRadius.circular(12)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.project.nom,
                    style: const TextStyle(fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Text(
                        widget.project.description,
                        style: const TextStyle(
                          fontSize: 12,
                          color: AppColors.greyTextColor,
                        ),
                      )
                    ],
                  )
                ],
              ),
              Container(
                width: 30,
                height: 30,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: AppColors.primaryLightColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text("${widget.project.idpro}"),
              )
            ],
          ),
        ),
      );
}
