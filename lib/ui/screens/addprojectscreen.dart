

import 'dart:ui';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:interviewapp/models/project.dart';
import 'package:interviewapp/services/api_services.dart';
import 'package:interviewapp/ui/widgets/custombutton.dart';
import 'package:interviewapp/utils/colors.dart';
import 'package:open_street_map_search_and_pick/open_street_map_search_and_pick.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

class AddProjectScreen extends StatefulWidget {
  const AddProjectScreen({ Key? key}) : super(key: key);

  @override
  State<AddProjectScreen> createState() => _AddProjectScreenState();
}

class _AddProjectScreenState extends State<AddProjectScreen> {
  TextEditingController nomController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  double latitude = 0;
  double longitude = 0;

    final ApiServices api = ApiServices();


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(
          size: 19,
          color: AppColors.backgroundColorDark,
        ),
        shape:const  RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20.0),
          ),
        ),
        title:const Text(
          "Add Project",
          style: TextStyle(fontSize: 15, color: Color.fromARGB(255, 136, 138, 156)),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: CustomButton(text: 'Save', onPressed: () { 
                QuickAlert.show(
 context: context,
 type: QuickAlertType.confirm,
 text: 'Do you want to save this project',
 confirmBtnText: 'Yes',
 cancelBtnText: 'No',
 confirmBtnColor: Colors.green,
 onConfirmBtnTap:() {
   saveData();
 },
);
            },
            color:Color.fromARGB(255, 55, 175, 75),
            height: 38,
            width: 70,
            ),
          )
        ],
      ),
        body: Material(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.all(15),
                child: Column(
                  children: [
                    TextField(
                      controller: nomController,
                      decoration: const InputDecoration(
                        labelText: 'Nom',
                        labelStyle: TextStyle(
                          color: Color.fromARGB(255, 109, 109, 109),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: const Color.fromARGB(255, 153, 153, 153),
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: const Color.fromARGB(255, 177, 177, 177),
                          ),
                        ),
                      ),
                      style: TextStyle(color: Colors.black),
                    ),
                    const SizedBox(height: 16.0),
                    TextField(
                      controller: descriptionController,
                      decoration: const InputDecoration(
                        labelText: 'Description',
                        labelStyle: TextStyle(
                          color: Color.fromARGB(255, 109, 109, 109),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: const Color.fromARGB(255, 153, 153, 153),
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: const Color.fromARGB(255, 177, 177, 177),
                          ),
                        ),
                      ),
                      style: TextStyle(color: Colors.black),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.width * 0.9,
                child: OpenStreetMapSearchAndPick(
                  buttonColor: const Color.fromARGB(255, 59, 153, 230),
                  buttonText: 'Set Current Location',
                  onPicked: (pickedData) {
                    setState(() {
                      latitude = pickedData.latLong.latitude;
                      longitude = pickedData.latLong.longitude;
                    });
             
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

String formatDate(DateTime dateTime) {
  final DateFormat formatter = DateFormat('dd/MM/yyyy HH:mm:ss');
  final String formattedDate = formatter.format(dateTime);
  return formattedDate;
}

  void saveData() async{
    String nom = nomController.text;
    String description = descriptionController.text;
  DateTime date = DateTime.now();
 Project project = Project(
      idpro: 0,
      nom: nom,
      date:formatDate(date),
      description: description,
      latitude: latitude,
      longitude: longitude,
    );
    try {
      await api.addProject(project).onError((error, stackTrace) {
        QuickAlert.show(
 context: context,
 type: QuickAlertType.error,
 title: 'Oops...',
 text: 'Sorry, something went wrong',
);
      });
    } catch (e) {
      print('Error saving project: $e');
    }

  }
}
