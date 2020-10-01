import 'package:project_mpsp/screens/login.dart';
import 'package:flutter/material.dart';
import 'package:project_mpsp/screens/pagInicial.dart';

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
        '/login': (context) => Login(),
        '/menu': (context) => PagInicial(),
      }),
    );
  }
}
