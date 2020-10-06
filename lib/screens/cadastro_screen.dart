import 'package:flutter/material.dart';
import 'package:project_mpsp/models/usuario_model.dart';
import 'package:project_mpsp/repository/usuario_repository.dart';

class CadastroScreen extends StatefulWidget {
  CadastroScreen({Key key}) : super(key: key);

  @override
  _CadastroScreenState createState() => _CadastroScreenState();
}

class _CadastroScreenState extends State<CadastroScreen> {
  final GlobalKey<FormState> formKey = new GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  UsuarioRepository usuarioRepository = UsuarioRepository();
  UsuarioModel usuarioModel = UsuarioModel();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.pink,
        fontFamily: 'Montserrat',
      ),
      home: Scaffold(
        //barra top da tela
        appBar: AppBar(
          backgroundColor: Colors.white, //Cor de fundo da tela
          automaticallyImplyLeading: true,
          leading: IconButton(
              icon: Icon(Icons.arrow_back),
              color: Colors.black,
              onPressed: () => Navigator.pop(context)),
        ),
        body: Padding(
          padding: const EdgeInsets.only(
            left: 20,
            right: 20,
            top: 15,
          ),
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Center(
                child: Column(
                  children: <Widget>[
                    //Icone de reset
                    SizedBox(
                      width: 100,
                      height: 100,
                      child: Image.asset("assets/social.png"),
                    ),

                    //Espacamento da logo com o resto da tela
                    SizedBox(
                      height: 20,
                    ),

                    Text(
                      "Realize seu cadastro!",
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
                      // autofocus: true,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        labelText: "Nome",
                        labelStyle: TextStyle(
                          color: Colors.black38,
                          fontWeight: FontWeight.w400,
                          fontSize: 20,
                        ),
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Precisamos do seu nome para o cadastro!';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        usuarioModel.nome = value;
                      },
                    ),
                    TextFormField(
                      // autofocus: true,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: "CPF",
                        labelStyle: TextStyle(
                          color: Colors.black38,
                          fontWeight: FontWeight.w400,
                          fontSize: 20,
                        ),
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Insira um CPF valido para cadastro!';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        usuarioModel.cpf = value;
                      },
                    ),

                    TextFormField(
                      // autofocus: true,
                      keyboardType: TextInputType.text,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: "Senha",
                        labelStyle: TextStyle(
                          color: Colors.black38,
                          fontWeight: FontWeight.w400,
                          fontSize: 20,
                        ),
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Insira uma senha!';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        usuarioModel.senha = value;
                      },
                    ),

                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: "E-mail",
                        labelStyle: TextStyle(
                          color: Colors.black38,
                          fontWeight: FontWeight.w400,
                          fontSize: 20,
                        ),
                      ),
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
                            "Cadastrar",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 20,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          onPressed: () {
                            if (formKey.currentState.validate()) {
                              formKey.currentState.save();

                              usuarioRepository.create(usuarioModel);

                              Navigator.pop(context);
                            } else {
                              scaffoldKey.currentState.showSnackBar(
                                SnackBar(
                                  content: Text(
                                    'Não foi possível fazer o login.',
                                  ),
                                ),
                              );
                            }
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
