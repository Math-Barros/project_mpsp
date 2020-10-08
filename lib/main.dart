import 'package:flutter/material.dart';
import 'package:project_mpsp/screens/editar_screen.dart';
import 'package:project_mpsp/screens/home_screen.dart';
import 'package:project_mpsp/screens/login_screen.dart';
import 'package:project_mpsp/screens/pagInicial.dart';
import 'package:project_mpsp/screens/resetarSenha.dart';

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
        '/resetar': (context) => ResetarSenha(),
        '/home': (context) => HomeScreen(),
        '/editar': (context) => EditarScreen(),
      }),
    );
  }
}
