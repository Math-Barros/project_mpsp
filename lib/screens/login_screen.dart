import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:project_mpsp/screens/cadastro_screen.dart';
import 'package:project_mpsp/screens/home_screen.dart';
import 'package:project_mpsp/screens/resetarSenha.dart';
import 'package:project_mpsp/utils/firebase_utils.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String _email, _password;
  var _formkey = GlobalKey<FormState>();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Container(
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
                      key: _formkey,
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
                              keyboardType: TextInputType.emailAddress,

                              //Configuracoes do campo
                              decoration: new InputDecoration(
                                  labelText: "Email", //Texto que ira aparecer

                                  labelStyle: TextStyle(
                                      color: Colors.black38,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 20) //Cor, espessura e tamanho

                                  ),
                              validator: (item) {
                                return item.contains("@")
                                    ? null
                                    : "Insira um email válido!";
                              },
                              onChanged: (item) {
                                setState(() {
                                  _email = item;
                                });
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
                              validator: (item) {
                                return item.length > 6
                                    ? null
                                    : "Sua senha deve ter, no mínimo 6 caracteres!";
                              },
                              onChanged: (item) {
                                setState(() {
                                  _password = item;
                                });
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
                                    login();
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

  void login() {
    if (_formkey.currentState.validate()) {
      setState(() {
        isLoading = true;
      });
      FirebaseAuth.instance
          .signInWithEmailAndPassword(email: _email, password: _password)
          .then((user) async {
        // sign up
        setState(() {
          isLoading = false;
        });

        Fluttertoast.showToast(msg: "Login Success");

        await FirebaseUtils.updateFirebaseToken();

        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (_) => HomeScreen()),
            (Route<dynamic> route) => false);
      }).catchError((onError) {
        setState(() {
          isLoading = false;
        });
        Fluttertoast.showToast(msg: "Login inválido!! " + onError.toString());
      });
    }
  }
}
