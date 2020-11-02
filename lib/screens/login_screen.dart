import 'package:flutter/material.dart';
import 'package:project_mpsp/models/usuario_model.dart';
import 'package:project_mpsp/repository/usuario_repository.dart';
import 'package:project_mpsp/screens/cadastro_screen.dart';
import 'package:project_mpsp/screens/resetarSenha.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> formKey = new GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  UsuarioRepository usuarioRepository = UsuarioRepository();
  UsuarioModel usuarioModel = UsuarioModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(top: 10, left: 40, right: 40),
        color: Colors.white,
        child: ListView(children: <Widget>[
          Container(
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
                      SizedBox(
                        //Tamanho do logo
                        width: 150,
                        height: 150,

                        //Carregando a imagem
                        child: Image.asset("assets/logo-mpsp.jpg"), //logo
                      ),
                      //Espaço entre a logo e os inputs
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        autofocus: true, //Para focar no campo
                        keyboardType: TextInputType
                            .number, //Exibe somente os numeros do teclado

                        //Configuracoes do campo
                        decoration: new InputDecoration(
                            labelText: "CPF", //Texto que ira aparecer

                            labelStyle: TextStyle(
                                color: Colors.black38,
                                fontWeight: FontWeight.w400,
                                fontSize: 20) //Cor, espessura e tamanho

                            ),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Insira seu CPF para logar!';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          usuarioModel.cpf = value;
                        },
                      ),
                      TextFormField(
                        autofocus: true,
                        keyboardType:
                            TextInputType.text, //permite numeros e letras
                        obscureText: true, //oculta os caracteres

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
                            return 'Digite sua senha para logar!';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          usuarioModel.senha = value;
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),

                      //Botao de recuperar senha
                      Container(
                        height: 40, //altura que ira ficar
                        alignment: Alignment.centerRight, //Alinhando

                        //Botao
                        child: FlatButton(
                          //Texto do botao
                          child: Text(
                            "Esqueceu sua senha?", //Texto a ser exibido
                            textAlign:
                                TextAlign.right, //Posicionando na direita
                          ),

                          //Ao pressionar o botao
                          onPressed: () {
                            //Muda para a pagina de resetar senha
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ResetarSenha(),
                              ),
                            );
                          },
                        ),
                      ),

                      //Botao de cadastro
                      Container(
                        height: 40, //altura que ira ficar
                        alignment: Alignment.centerRight, //Alinhando

                        //Botao
                        child: FlatButton(
                          child: Text(
                            "Não possui uma conta? Cadastre-se!", //Texto a ser exibido
                            textAlign:
                                TextAlign.right, //Posicionando na direita
                          ),
                          //Ao pressionar o botao
                          onPressed: () {
                            //Muda para a pagina de cadastro
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CadastroScreen(),
                              ),
                            );
                          },
                        ),
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
                              "Acessar",
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

                                var resultLogin = usuarioRepository.login(
                                    usuarioModel.cpf, usuarioModel.senha);

                                resultLogin.then((usuario) {
                                  if (usuario == null) {
                                  } else {
                                    Navigator.pushNamed(
                                      context,
                                      '/menu',
                                      arguments: usuario,
                                    );
                                  }
                                });
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
        ]),
      ),
    );
  }
}
