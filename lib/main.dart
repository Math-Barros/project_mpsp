import 'package:flutter/material.dart';
import 'package:project_mpsp/screens/editar_screen.dart';
import 'package:project_mpsp/screens/home_screen.dart';
import 'package:project_mpsp/screens/login_screen.dart';
import 'package:project_mpsp/screens/pagInicial.dart';
<<<<<<< HEAD
=======

>>>>>>> 2f0d08e3a7c8b60f46c941ad8f8c380d4e544e5a
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MPSP Project',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      home: MaterialApp(initialRoute: '/login', routes: {
        '/login': (context) => LoginScreen(),
        '/menu': (context) => PagInicial(),
        '/home': (context) => HomeScreen(),
        '/editar': (context) => EditarScreen(),
      }),
    );
  }
}
