import 'package:flutter/material.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

import '../../models/person.dart';
import '../../services/api_services.dart';
import '../../utils/colors.dart';
import '../widgets/person_card.dart';
import 'person_details_screen.dart';

class PersonScreen extends StatefulWidget {
  const PersonScreen({Key? key}) : super(key: key);

  @override
  State<PersonScreen> createState() => _PersonScreenState();
}

class _PersonScreenState extends State<PersonScreen> {
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
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pushNamed("/");
          },
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20.0),
          ),
        ),
        title: const Text(
          "Persons",
          style: TextStyle(fontSize: 14, color: AppColors.greyColor),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: FutureBuilder<List<Person>>(
          future: apiService.fetchEmployes(),
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
                  Person person = snapshot.data![index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailsScreen(
                            person: person,
                          ),
                        ),
                      );
                    },
                    child: CardOfUsers(
                      person: person,
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
              return AddUserDialog();
            },
          );
        },
        backgroundColor: Color.fromARGB(255, 199, 138, 47),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: const Icon(
          Icons.add,
          color: Color.fromARGB(195, 255, 255, 255),
        ),
      ),
    );
  }
}

class AddUserDialog extends StatelessWidget {
  final TextEditingController nomController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController prenomController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController statusController = TextEditingController();
  final TextEditingController rolesController = TextEditingController();

  AddUserDialog({super.key});
  final ApiServices apiService = ApiServices();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Add User',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: nomController,
                decoration: const InputDecoration(
                  labelText: 'Nom',
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
                decoration: const InputDecoration(
                  labelText: 'Prenom',
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
                decoration: const InputDecoration(
                  labelText: 'Username',
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
                decoration: const InputDecoration(
                  labelText: 'Email',
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
                controller: rolesController,
                decoration: const InputDecoration(
                  labelText: 'Roles',
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
                controller: statusController,
                decoration: const InputDecoration(
                  labelText: 'Status',
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
                controller: passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Password',
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
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    style: const ButtonStyle(
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
                    onPressed: () async {
                      String nom = nomController.text;
                      String prenom = prenomController.text;
                      String username = usernameController.text;
                      String email = emailController.text;
                      String password = passwordController.text;
                      String status = statusController.text;
                      List<String> roles = rolesController.text.split(",");

                      if (roles.isEmpty) {
                        roles = [rolesController.text];
                      }

                       final RegExp emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

                      if(!emailRegex.hasMatch(email)){
                         return QuickAlert.show(
                          context: context,
                          type: QuickAlertType.info,
                          title: 'Yoo...',
                          text: 'Verify Email',
                        );
                      }
                      if (nom.isEmpty ||
                          username.isEmpty ||
                          email.isEmpty ||
                          prenom.isEmpty ||
                          password.isEmpty) {
                        return QuickAlert.show(
                          context: context,
                          type: QuickAlertType.info,
                          title: 'Oops...',
                          text: 'You should fill all the inputs',
                        );
                      }

                      Person newPerson = Person(
                          idperson: 0,
                          nom: nom,
                          prenom: prenom,
                          username: username,
                          mail: email,
                          password: password,
                          status: status,
                          roles: roles);

                      try {
                        await apiService.createEmploye(newPerson).then((value) {
                          if (value == true) {
                            QuickAlert.show(
                                context: context,
                                type: QuickAlertType.success,
                                text: 'Add Successfully!',
                                onConfirmBtnTap: () {
                                  Navigator.of(context).pushNamed("/persons");
                                });
                          }
                        });
                      } catch (error) {              
                         QuickAlert.show(
                                context: context,
                                type: QuickAlertType.success,
                                text: error.toString(),
                                onConfirmBtnTap: () {
                                  Navigator.of(context).pushNamed("/persons");
                                });
                      }
                    },
                    child: Text('Add'),
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
