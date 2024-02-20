import 'package:flutter/material.dart';
import 'package:interviewapp/models/projectperson.dart';
import 'package:interviewapp/services/api_services.dart';
import 'package:interviewapp/ui/widgets/map_image.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

import '../../models/person.dart';
import '../../utils/colors.dart';
import '../widgets/custom_dashed_line.dart';

class LinkedProjectDetails extends StatelessWidget {
  final ProjectPerson project;
  const LinkedProjectDetails({Key? key, required this.project}) : super(key: key);

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
        shape:const  RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20.0),
          ),
        ),
        title: Text(
          project.projecto.nom,
          style:const TextStyle(fontSize: 14, color: AppColors.greyColor),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 24),
            child: Column(
              children: [  
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 238, 238, 238),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    children: [
                      Stack(children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: _buildCardImage()
                        ),
                        Container(
                          height: 250,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: AppColors.primaryLightColor.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                      ]),
                      const SizedBox(height: 16),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                              child: Text(
                                project.projecto.nom,
                                style: const TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                            ),
                            const SizedBox(height: 16),
                            CustomPaint(
                              painter: CustomDashedLinePainter(),
                              child: const SizedBox(
                                height: 1,
                                width: double.infinity,
                              ),
                            ),
                            const SizedBox(height: 16),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                _textDescription("Project To",
                                   project.projecto.nom),
                                _textDescription("ID",  project.projecto.idpro.toString()),
                              ],
                            ),
                            const SizedBox(height: 12),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                 _textDescription("Project Taken by",
                                  project.persono.username!),
                                _textDescription("ID",  project.persono.idperson.toString()),
                              ],
                            ),
                            const SizedBox(height: 12),
                            CustomPaint(
                              painter: CustomDashedLinePainter(),
                              child: const SizedBox(
                                height: 1,
                                width: double.infinity,
                              ),
                            ),
                            const SizedBox(height: 24),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                _textDescription("Project Date",project.projecto.date),
                              ],
                            ),
                            _textDescription("Projct Description:", project.projecto.description),
                            // Align(
                            //   alignment: Alignment.center,
                            //   child: Image.asset(
                            //     "assets/images/barcode.png",
                            //     height: 70,
                            //     width: MediaQuery.of(context).size.width * 0.5,
                            //     fit: BoxFit.fill,
                            //   ),
                            // ),
                            const SizedBox(height: 14),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      );
  }

  
  _buildCardImage() => Container(
        height: 280,
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.circular(16),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: SizedBox(
            width: double.infinity,
           height: double.infinity,
            child: MapImageScreen(latitude: project.projecto.latitude, longitude:  project.projecto.longitude,)),
        ),
      );

  Widget _textDescription(String title, String value) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style:
                const TextStyle(fontSize: 12, color: AppColors.greyTextColor),
          ),
          const SizedBox(height: 2),
          Text(
            value,
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
          ),
        ],
      );
}

class EditUserDialog extends StatelessWidget {
  final Person person;
  EditUserDialog({Key? key, required this.person}) : super(key: key);

  final TextEditingController nomController = TextEditingController();
  final TextEditingController prenomController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController roleController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
 final TextEditingController rolesController = TextEditingController();
 final TextEditingController statusController = TextEditingController();
   final ApiServices apiService = ApiServices();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Edit ${person.username} Profile',
              style:const TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: nomController,
              decoration: InputDecoration(
                labelText: 'Nom',
                hintText:person.nom,
                labelStyle:
                    TextStyle(color: Color.fromARGB(255, 109, 109, 109)),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: const Color.fromARGB(255, 153, 153, 153)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: const Color.fromARGB(255, 177, 177, 177)),
                ),
              ),
              style: TextStyle(color: Colors.black),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: prenomController,
              decoration: InputDecoration(
                labelText: 'Prenom',
                 hintText:person.prenom,
              labelStyle:
                    TextStyle(color: Color.fromARGB(255, 109, 109, 109)),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: const Color.fromARGB(255, 153, 153, 153)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: const Color.fromARGB(255, 177, 177, 177)),
                ),
              ),
              style: TextStyle(color: Colors.black),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: usernameController,
              decoration:  InputDecoration(
                labelText: 'Username',
                 hintText:person.username,
                labelStyle:
                    TextStyle(color: Color.fromARGB(255, 109, 109, 109)),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: const Color.fromARGB(255, 153, 153, 153)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: const Color.fromARGB(255, 177, 177, 177)),
                ),
              ),
              style: TextStyle(color: Colors.black),
            ),
           const SizedBox(height: 16.0),
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                 hintText:person.mail,
                labelStyle:
                    TextStyle(color: Color.fromARGB(255, 109, 109, 109)),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color:  Color.fromARGB(255, 153, 153, 153)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color:  Color.fromARGB(255, 177, 177, 177)),
                ),
              ),
              style: TextStyle(color: Colors.black),
            ),
           const SizedBox(height: 16.0),
              TextField(
              controller:statusController,
              decoration: InputDecoration(
                labelText: 'Status',
                 hintText: person.status,
               
                labelStyle:
                    TextStyle(color: Color.fromARGB(255, 109, 109, 109)),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color:  Color.fromARGB(255, 153, 153, 153)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color:  Color.fromARGB(255, 177, 177, 177)),
                ),
              ),
              style: TextStyle(color: Colors.black),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: rolesController,
              decoration: InputDecoration(
                labelText: 'Role(s)',
                 hintText: person.roles?.join(','),
                helperText:"separate between roles with (,)",
                labelStyle:
                    TextStyle(color: Color.fromARGB(255, 109, 109, 109)),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color:  Color.fromARGB(255, 153, 153, 153)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color:  Color.fromARGB(255, 177, 177, 177)),
                ),
              ),
              style: TextStyle(color: Colors.black),
            ),
            SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(
                          const Color.fromARGB(61, 255, 255, 255))),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('cancel'),
                ),
                SizedBox(
                  width: 5,
                ),
                ElevatedButton(
                  onPressed: () async {
                    String nom = nomController.text;
                    String prenom = prenomController.text;
                    String username = usernameController.text;
                    String email = emailController.text;
           String status = statusController.text;

                    String roles = rolesController.text;

                    
                    Person updatePerson = Person(
                      idperson: person.idperson,
                      nom: nom,
                      prenom: prenom,
                      username:username ,
                      mail: email,
                      status: status,
                      roles: roles.split(",")
                    );


                    try {
                      await apiService.updateEmploye(updatePerson);
                      QuickAlert.show(
                      context: context,
                      type: QuickAlertType.success,
                      text: 'Update Completed Successfully!',
                      onConfirmBtnTap: () {
                        Navigator.of(context)..pushNamed("/persons");
                      },
                      );


   
                    } catch (error) {

                      print('Error adding user: $error');
                    }
                  },
                  child: Text('Edit'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
