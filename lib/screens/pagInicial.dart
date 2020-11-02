import 'package:flutter/material.dart';
import 'package:project_mpsp/models/usuario_model.dart';
import 'package:project_mpsp/screens/home_screen.dart';
import 'package:project_mpsp/screens/login_screen.dart';

class PagInicial extends StatefulWidget {
  PagInicial({Key key}) : super(key: key);
  @override
  _PagInicialState createState() => _PagInicialState();
}

class _PagInicialState extends State<PagInicial> {
  UsuarioModel usuarioModel;

  final GlobalKey<FormState> formKey = new GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  // Menu superior
  // ignore: unused_field
  ChoiceMenu _selectedChoice = choices[0];

  void _select(ChoiceMenu choice) {
    setState(() {
      _selectedChoice = choice;
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // Menu de navegação
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    usuarioModel = ModalRoute.of(context).settings.arguments;
    final List<Widget> _widgetOptions = [
      HomeScreen(
        usuarioModel: usuarioModel,
      ),
      //ChamadaScreen(
      //  ctx: context,
      //),
    ];
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white70,
        appBar: AppBar(
          backgroundColor: Colors.red, //Cor de fundo da tela
          automaticallyImplyLeading: true,
          centerTitle: true,
          actions: [
            PopupMenuButton<ChoiceMenu>(
              onSelected: _select,
              itemBuilder: (BuildContext ctx) {
                return choices.map((ChoiceMenu choice) {
                  return PopupMenuItem<ChoiceMenu>(
                    enabled: choice.enabled,
                    value: choice,
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            if (choice.route == '/editar') {
                              Navigator.pushNamed(
                                context,
                                choice.route,
                                arguments: usuarioModel,
                              );
                            } else if (choice.route == '/login') {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => LoginScreen(),
                                ),
                              );
                            } else {
                              Navigator.pushNamed(context, choice.route);
                            }
                          },
                          child: Row(
                            children: [
                              Icon(
                                choice.icon,
                                color: Colors.red,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Text(choice.title),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList();
              },
            ),
          ],
        ),
        body: _widgetOptions.elementAt(_selectedIndex),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.red,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              // ignore: deprecated_member_use
              title: Text(
                'Início',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.assignment_ind),
              // ignore: deprecated_member_use
              title: Text(
                'BOT',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.red[900],
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}

const List<ChoiceMenu> choices = const <ChoiceMenu>[
  const ChoiceMenu(
      title: 'Editar Perfil',
      icon: Icons.edit,
      enabled: true,
      route: '/editar'),
  const ChoiceMenu(
      title: 'Configurações', icon: Icons.settings, enabled: false),
  const ChoiceMenu(
      title: 'Sair', icon: Icons.exit_to_app, enabled: true, route: '/login'),
];

class ChoiceMenu {
  const ChoiceMenu({this.title, this.icon, this.enabled, this.route});
  final String title;
  final IconData icon;
  final bool enabled;
  final String route;
}
