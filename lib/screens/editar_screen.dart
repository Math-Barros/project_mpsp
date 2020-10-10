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
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red,
          centerTitle: true,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
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
            top: 20,
          ),
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Center(
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      width: 100,
                      height: 100,
                      child: Image.asset("assets/editar.png"),
                    ),

                    //Espacamento da logo com o resto da tela
                    SizedBox(
                      height: 20,
                    ),

                    Text(
                      "Editar Informações",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w500,
                      ),
                    ),

                    SizedBox(
                      height: 10,
                    ),

                    Text(
                      "Insira suas informações para contato nos campos abaixo, "
                      "logo após podera logar no site.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    TextFormField(
                      decoration: new InputDecoration(
                          fillColor: Colors.white,
                          hintText: 'Digite o seu Nome',
                          labelText: "Nome"),
                      initialValue: usuarioModel.nome.toString(),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Insira um nome válido!';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        usuarioModel.nome = value;
                      },
                    ),
                    TextFormField(
                      decoration: new InputDecoration(
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
                      decoration: new InputDecoration(
                          fillColor: Colors.white,
                          hintText: 'Digite o email desejado',
                          labelText: "Email"),
                      initialValue: usuarioModel.email.toString(),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Insira um email válido!';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        usuarioModel.email = value;
                      },
                    ),

                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 60,
                      alignment: Alignment.centerLeft,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          stops: [0.3, 1],
                          colors: [
                            Colors.red,
                            Colors.redAccent,
                          ],
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(5),
                        ),
                      ),
                      child: SizedBox.expand(
                        child: FlatButton(
                          child: Text(
                            "Concluir",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 20,
                            ),
                          ),
                          color: Colors.red,
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
                            setState(() {});
                          },
                        ),
                      ),
                    ),
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
