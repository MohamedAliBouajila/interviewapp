import 'package:flutter/material.dart';
import 'package:interviewapp/services/api_services.dart';
import 'package:interviewapp/ui/screens/persons_screen.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

import '../../models/person.dart';
import '../../utils/colors.dart';
import '../widgets/custom_dashed_line.dart';

class DetailsScreen extends StatefulWidget {
  final Person person;
  const DetailsScreen({Key? key, required this.person}) : super(key: key);

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  final ApiServices apiService = ApiServices();

  @override
  Widget build(BuildContext context) {
    final String role =
        widget.person.roles.toString().replaceAll('[', '').replaceAll(']', '');

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          iconTheme: const IconThemeData(
            size: 19,
            color: AppColors.primaryColor,
          ),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(20.0),
            ),
          ),
          title: Text(
            widget.person.username!,
            style: const TextStyle(fontSize: 14, color: AppColors.greyColor),
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
                            child: SizedBox(
                              height: 250,
                              width: double.infinity,
                              child: Image.network(
                                "https://images.unsplash.com/photo-1438761681033-6461ffad8d80?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Container(
                            height: 250,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color:
                                  AppColors.primaryLightColor.withOpacity(0.3),
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
                              Text(
                                widget.person.username!,
                                style: const TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  _textDescription("Full name",
                                      "${widget.person.nom} ${widget.person.prenom}"),
                                  _textDescription(
                                      "ID", "${widget.person.idperson}"),
                                ],
                              ),
                              const SizedBox(height: 12),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  _textDescription(
                                      "Email", "${widget.person.mail}"),
                                ],
                              ),
                              const SizedBox(height: 32),
                              CustomPaint(
                                painter: CustomDashedLinePainter(),
                                child: const SizedBox(
                                  height: 1,
                                  width: double.infinity,
                                ),
                              ),
                              const SizedBox(height: 24),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  _textDescription("Role", "$role"),
                                ],
                              ),
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
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return EditUserDialog(
                      person: widget.person,
                    );
                  },
                );
              },
              backgroundColor: Colors.blue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: const Icon(
                Icons.edit,
                color: Color.fromARGB(195, 255, 255, 255),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            FloatingActionButton(
              onPressed: () {
                QuickAlert.show(
                  context: context,
                  type: QuickAlertType.warning,
                  text: 'Do you want delete this person?',
                  showCancelBtn: true,
                  confirmBtnText: 'Yes',
                  cancelBtnText: 'No',
                  confirmBtnColor: const Color.fromARGB(255, 175, 76, 76),
                  onConfirmBtnTap: () async {
                    await apiService
                        .deleteEmploye(widget.person.idperson.toString())
                        .then((value) => {
                              if (value == true)
                                {
                                  QuickAlert.show(
                                    context: context,
                                    type: QuickAlertType.success,
                                    text: 'Deleted Successfully!',
                                    onConfirmBtnTap: () {
                                      Navigator.of(context)
                                          .pushNamed("/persons");
                                    },
                                  )
                                }
                            });
                  },
                );
              },
              backgroundColor: Colors.red,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: const Icon(
                Icons.delete,
                color: Color.fromARGB(195, 255, 255, 255),
              ),
            )
          ],
        ));
  }

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
              style: const TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: nomController,
              decoration: InputDecoration(
                labelText: 'Nom',
                hintText: person.nom,
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
                hintText: person.prenom,
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
              decoration: InputDecoration(
                labelText: 'Username',
                hintText: person.username,
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
                hintText: person.mail,
                labelStyle:
                    TextStyle(color: Color.fromARGB(255, 109, 109, 109)),
                focusedBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: Color.fromARGB(255, 153, 153, 153)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: Color.fromARGB(255, 177, 177, 177)),
                ),
              ),
              style: TextStyle(color: Colors.black),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: statusController,
              decoration: InputDecoration(
                labelText: 'Status',
                hintText: person.status,
                labelStyle:
                    TextStyle(color: Color.fromARGB(255, 109, 109, 109)),
                focusedBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: Color.fromARGB(255, 153, 153, 153)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: Color.fromARGB(255, 177, 177, 177)),
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
                helperText: "separate between roles with (,)",
                labelStyle:
                    TextStyle(color: Color.fromARGB(255, 109, 109, 109)),
                focusedBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: Color.fromARGB(255, 153, 153, 153)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: Color.fromARGB(255, 177, 177, 177)),
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
                        username: username,
                        mail: email,
                        status: status,
                        roles: roles.split(","));

                    try {
                      await apiService
                          .updateEmploye(updatePerson)
                          .then((value) => {
                                if (value == true)
                                  {
                                    QuickAlert.show(
                                      context: context,
                                      type: QuickAlertType.success,
                                      text: 'Update Completed Successfully!',
                                      onConfirmBtnTap: () {
                                        Navigator.of(context)
                                          ..pushNamed("/persons");
                                      },
                                    )
                                  }
                              });
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
