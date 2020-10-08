import 'package:flutter/material.dart';
import 'package:project_mpsp/models/usuario_model.dart';
import 'package:project_mpsp/repository/usuario_repository.dart';

class EditarScreen extends StatefulWidget {
  EditarScreen({Key key}) : super(key: key);

  @override
  _EditarScreenState createState() => _EditarScreenState();
}

class _EditarScreenState extends State<EditarScreen> {
  final GlobalKey<FormState> formKey = new GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  UsuarioRepository usuarioRepository = UsuarioRepository();
  UsuarioModel usuarioModel;

  @override
  Widget build(BuildContext context) {
    usuarioModel = ModalRoute.of(context).settings.arguments;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.pink,
        fontFamily: 'Montserrat',
      ),
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text('FIAPP',
              style: TextStyle(
                color: Colors.pink,
                fontWeight: FontWeight.w500,
              )),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.pink,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.only(
            left: 20,
            right: 20,
            top: 100,
          ),
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Center(
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Cadastrar Professor",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                          color: Colors.pink,
                        ),
                      ),
                    ),
                    TextFormField(
                      decoration: new InputDecoration(
                          icon: const Icon(Icons.people_outline),
                          fillColor: Colors.white,
                          hintText: 'Digite o seu Nome',
                          labelText: "Nome"),
                      initialValue: usuarioModel.nome.toString(),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Precisamos do seu nome para o cadastro';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        usuarioModel.nome = value;
                      },
                    ),
                    TextFormField(
                      decoration: new InputDecoration(
                          icon: const Icon(Icons.person_pin),
                          fillColor: Colors.white,
                          hintText: 'Insira o CPF',
                          enabled: false,
                          labelText: "CPF"),
                      initialValue: usuarioModel.cpf.toString(),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Digite o CPF para logar';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        usuarioModel.cpf = value;
                      },
                    ),
                    TextFormField(
                      obscureText: true,
                      decoration: new InputDecoration(
                        icon: const Icon(Icons.lock),
                        fillColor: Colors.white,
                        hintText: 'Insira sua senha',
                        labelText: 'Senha',
                      ),
                      initialValue: usuarioModel.senha.toString(),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Digite a senha';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        usuarioModel.senha = value;
                      },
                    ),
                    TextFormField(
                      obscureText: true,
                      decoration: new InputDecoration(
                        icon: const Icon(Icons.lock),
                        fillColor: Colors.white,
                        hintText: 'Insira seu email',
                        labelText: 'email',
                      ),
                      initialValue: usuarioModel.senha.toString(),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Digite seu email!';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        usuarioModel.email = value;
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: RaisedButton(
                        child: Text("Cadastrar",
                            style: TextStyle(
                              color: Colors.white,
                            )),
                        color: Colors.pink,
                        onPressed: () {
                          if (formKey.currentState.validate()) {
                            formKey.currentState.save();

                            usuarioRepository.update(usuarioModel);

                            Navigator.pop(context, usuarioModel);
                          } else {
                            scaffoldKey.currentState.showSnackBar(
                              SnackBar(
                                content: Text(
                                  'Não foi possivel editar o usuario',
                                ),
                              ),
                            );
                          }
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
