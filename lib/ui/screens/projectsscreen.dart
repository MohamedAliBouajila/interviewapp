import 'package:flutter/material.dart';
import 'package:interviewapp/models/project.dart';
import 'package:interviewapp/ui/screens/addprojectscreen.dart';

import '../../models/person.dart';
import '../../services/api_services.dart';
import '../../utils/colors.dart';
import '../widgets/person_card.dart';
import '../widgets/project_card.dart';

class ProjectsScreen extends StatefulWidget {
  const ProjectsScreen({Key? key}) : super(key: key);

  @override
  State<ProjectsScreen> createState() => _ProjectsScreenState();
}

class _ProjectsScreenState extends State<ProjectsScreen> {
  final ApiServices apiService = ApiServices();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          iconTheme: const IconThemeData(
            size: 19,
            color: AppColors.primaryColor,
          ),
           leading: IconButton(
            icon:const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pushNamed("/");
            },
          ),
          shape:const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(20.0),
            ),
          ),
          title:const Text(
            "Projects",
            style: TextStyle(fontSize: 14, color: AppColors.greyColor),
          ),
        ),
        body: Container(
          padding:const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
          child: FutureBuilder<List<Project>>(
            future: apiService.fetchProjects(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Center(child: Text('No data available'));
              } else {
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    Project project = snapshot.data![index];
                    return ProjectCard(
                      project: project,
                    );
                  },
                );
              }
            },
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
              Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AddProjectScreen(
                 
                            ),
                          ),
                        );
          },
           backgroundColor: Color.fromARGB(255, 199, 138, 47),
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        ));
  }
}
