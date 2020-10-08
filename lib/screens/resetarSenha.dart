import 'package:flutter/material.dart';
import 'package:project_mpsp/models/usuario_model.dart';
import 'package:project_mpsp/repository/usuario_repository.dart';

class ResetarSenha extends StatefulWidget {
  ResetarSenha({Key key}) : super(key: key);

  @override
  _ResetarSenhaState createState() => _ResetarSenhaState();
}

class _ResetarSenhaState extends State<ResetarSenha> {
  final GlobalKey<FormState> formKey = new GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  UsuarioRepository usuarioRepository = UsuarioRepository();
  UsuarioModel usuarioModel = UsuarioModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      child: Column(
                        children: <Widget>[
                          //Icone de reset
                          SizedBox(
                            width: 200,
                            height: 200,
                            child:
                                Image.asset("assets/reset-password-icon.png"),
                          ),

                          //Espacamento da logo com o resto da tela
                          SizedBox(
                            height: 20,
                          ),

                          Text(
                            "Esqueceu sua senha?",
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.w500,
                            ),
                          ),

                          SizedBox(
                            height: 10,
                          ),

                          Text(
                            "Por favor, informe o E-mail associado a sua conta que enviaremos"
                            " um link com as instruções para restauração de sua senha!",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.only(top: 10, left: 20, right: 20),
                      color: Colors.white,
                      child: Column(
                        children: <Widget>[
                          TextFormField(
                            autofocus: true, //Para focar no campo
                            keyboardType: TextInputType.emailAddress,

                            //Configuracoes do campo
                            decoration: new InputDecoration(
                                labelText: "Email", //Texto que ira aparecer

                                labelStyle: TextStyle(
                                    color: Colors.black38,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 20) //Cor, espessura e tamanho

                                ),
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Insira seu Email para recuperar o cadastro!';
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
                                  Color(0xFFF58524),
                                  Color(0XFFF92B7F),
                                ],
                              ),
                              borderRadius: BorderRadius.all(
                                Radius.circular(5),
                              ),
                            ),
                            child: SizedBox.expand(
                              //Botão enviar
                              child: FlatButton(
                                child: Text(
                                  "Enviar",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w800,
                                      color: Colors.white,
                                      fontSize: 20),
                                ),
                                onPressed: () {
                                  if (formKey.currentState.validate()) {
                                    formKey.currentState.save();

                                    var resultLogin = usuarioRepository
                                        .resetarSenha(usuarioModel.email);

                                    resultLogin.then((usuario) {
                                      if (usuario == null) {
                                      } else {
                                        Navigator.pushNamed(
                                          context,
                                          '/editar',
                                          arguments: usuario,
                                        );
                                      }
                                    });
                                  } else {
                                    scaffoldKey.currentState.showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          'Não foi possível resetar seu cadastro.',
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
                  ],
                ),
              )),
        ),
      ),
    );
  }
}
