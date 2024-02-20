import 'package:flutter/material.dart';
import 'package:interviewapp/models/project.dart';
import 'package:interviewapp/models/projectperson.dart';
import 'package:interviewapp/ui/screens/linkedprojectdetails.dart';
import 'package:interviewapp/ui/widgets/card_linked_project.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import '../../models/person.dart';
import '../../services/api_services.dart';
import '../../utils/colors.dart';

class LinkedProjectsPage extends StatefulWidget {
  const LinkedProjectsPage({Key? key}) : super(key: key);

  @override
  State<LinkedProjectsPage> createState() => _LinkedProjectsPageState();
}

class _LinkedProjectsPageState extends State<LinkedProjectsPage> {
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
          shape:const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(20.0),
            ),
          ),
          title:const Text(
            "Linked Projects",
            style: TextStyle(fontSize: 14, color: AppColors.greyColor),
          ),
        ),
        body: Container(
          padding:const EdgeInsets.symmetric( horizontal: 15),
          child: FutureBuilder<List<ProjectPerson>>(
            future: apiService.fetchProjectPersons(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(child: Text('No data available'));
              } else {
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    ProjectPerson project = snapshot.data![index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LinkedProjectDetails(
                              project: project,
                            ),
                          ),
                        );
                      },
                      child: LinedProjectCard(
                        project: project,
                      ),
                    );
                  },
                );
              }
            },
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return ProjectPersonForm(); 
              },
            );
          },
                   backgroundColor: Color.fromARGB(255, 199, 138, 47),

      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0), 
      ),
       child: const Icon(Icons.add,color: Color.fromARGB(195, 255, 255, 255),),
    ),);
  }
}

class ProjectPersonForm extends StatefulWidget {
  @override
  _ProjectPersonFormState createState() => _ProjectPersonFormState();
}
class _ProjectPersonFormState extends State<ProjectPersonForm> {
  final ApiServices apiService = ApiServices();
  Person? _selectedPerson;
  Project? _selectedProject;
  List<Person> _persons = [];
  List<Project> _projects = [];

  @override
  void initState() {
    super.initState();
    fetchPersons();
    fetchProjects();
  }

  Future<void> fetchPersons() async {
    final persons = await apiService.fetchEmployes();
    setState(() {
      _persons = persons;
    });
  }

  Future<void> fetchProjects() async {
    final projects = await apiService.fetchProjects();
    setState(() {
      _projects = projects;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
          padding: EdgeInsets.all(16.0),
          child: SizedBox(
            height: 200,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                DropdownButtonFormField<Person>(
                  value: _selectedPerson,
                  hint: Text('Select Person'),
                  onChanged: (person) {
                    setState(() {
                      _selectedPerson = person!;
                    });
                  },
                  items: _persons.map((person) {
                    return DropdownMenuItem(
                      value: person,
                      child: Text('${person.nom} ${person.prenom}'),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 20.0),
                DropdownButtonFormField<Project>(
                  value: _selectedProject,
                  hint:  const Text('Select Project'),
                  onChanged: (project) {
                    setState(() {
                      _selectedProject = project!;
                    });
                  },
                  items: _projects.map((project) {
                    return DropdownMenuItem(
                      value: project,
                      child: Text(project.nom),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 20.0),
                Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                     ElevatedButton(
                      style:const ButtonStyle(
                          backgroundColor: MaterialStatePropertyAll(
                              const Color.fromARGB(61, 255, 255, 255))),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text('cancel'),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    ElevatedButton(
                      onPressed: () async{
                       
                        if (_selectedPerson != null && _selectedProject != null) {
                      
                          ProjectPerson projectPerson = ProjectPerson(
                            id: Id(
                              idpro: _selectedProject!.idpro,
                              idperson: _selectedPerson!.idperson!,
                            ),
                            projecto: _selectedProject!,
                            persono: _selectedPerson!,
                          );
                        
                          await apiService.createProjectPerson(projectPerson)
                              .then((_) {
                         
                              QuickAlert.show(
                      context: context,
                      type: QuickAlertType.success,
                      text: 'Link Completed Successfully!',
                      onConfirmBtnTap: () {
                        Navigator.of(context)..pushNamed("/linkedprojects");
                      },
                      );
                          })
                              .catchError((error) {
                         
                                QuickAlert.show(
 context: context,
 type: QuickAlertType.error,
 title: 'Oops...',
 text: 'Sorry, something went wrong',
);
                          });
                        } else {
                                                        QuickAlert.show(
 context: context,
 type: QuickAlertType.info,
 title: 'hey',
 text: 'Please select the two fields',
);
                        }
                      },
                      child:const Text('Save'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
    );
  }
}
