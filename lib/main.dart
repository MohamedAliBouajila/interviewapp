import 'package:flutter/material.dart';
import 'package:interviewapp/ui/screens/homescreen.dart';
import 'package:interviewapp/ui/screens/linkedproject.dart';
import 'package:interviewapp/ui/screens/personscreen.dart';
import 'package:interviewapp/ui/screens/projectsscreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Color.fromARGB(255, 199, 138, 47),
        ),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => HomeScreen(),
        '/linkedprojects': (context) => LinkedProjectsPage(),
        '/persons': (context) => PersonScreen(),
        '/projects': (context) => ProjectsScreen(),
      },
    );
  }
}
