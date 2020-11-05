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
              padding: EdgeInsets.only(top: 10, left: 5, right: 5),
              color: Colors.white,
              child: ListView(children: <Widget>[
                Container(
                  padding: const EdgeInsets.only(
                    left: 20,
                    right: 20,
                    top: 0,
                  ),
                  child: SingleChildScrollView(
                    child: Form(
                      key: _formkey,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            SizedBox(
                              //Tamanho do logo
                              width: 600,
                              height: 200,

                              //Carregando a imagem
                              child: Image.asset(
                                  "assets/logo-launcher.png"), //logo
                            ),

                            //Texto bem-vindo

                            //Espaço entre texto e formulario
                            SizedBox(
                              height: 10,
                            ),

                            //Formulário

                            Container(
                              /*decoration: BoxDecoration(
                                  boxShadow: [new BoxShadow(blurRadius: 0.5),],

                                ),*/
                              child: TextFormField(
                                autofocus: true, //Para focar no campo
                                keyboardType: TextInputType.emailAddress,

                                //Configuracoes do campo
                                decoration: new InputDecoration(
                                    labelText: "Email",
                                    labelStyle: TextStyle(
                                        color: Colors.black38,
                                        fontWeight: FontWeight.w400,
                                        fontSize:
                                            20), //Cor, espessura e tamanho

                                    border: new OutlineInputBorder(
                                      borderRadius:
                                          new BorderRadius.circular(15.0),
                                      borderSide: new BorderSide(
                                          color: Colors.grey, width: 1),
                                    ) //Texto que ira aparecer

                                    ),

                                //Erro
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
                            ),

                            //Espaço
                            SizedBox(height: 10),

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
                                border: new OutlineInputBorder(
                                  borderRadius: new BorderRadius.circular(15.0),
                                  borderSide: new BorderSide(
                                      color: Colors.grey, width: 1),
                                ),
                              ),
                              validator: (item) {
                                return item.length > 6
                                    ? null
                                    : "Insira uma senha! ";
                              },
                              onChanged: (item) {
                                setState(() {
                                  _password = item;
                                });
                              },
                            ),

                            //SizedBox
                            SizedBox(
                              height: 3,
                            ),

                            //Botao de recuperar senha
                            Container(
                              height: 30, //altura que ira ficar
                              alignment: Alignment.center, //Alinhando

                              //Botao
                              child: FlatButton(
                                //Texto do botao
                                child: Text(
                                  "Esqueci a senha.",
                                  style: TextStyle(
                                    shadows: <Shadow>[
                                      Shadow(
                                          offset: Offset(0.5, 0.5),
                                          blurRadius: 1.0,
                                          color:
                                              Color.fromARGB(185, 10, 10, 8)),
                                    ],
                                    fontSize: 15,
                                    color: Colors.red,
                                  ), //Texto a ser exibido
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
                              height: 60,
                              alignment: Alignment.centerLeft,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  stops: [0.3, 1],
                                  colors: [
                                    Colors.red[500],
                                    Colors.redAccent[400],
                                  ],
                                ),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(15),
                                ),
                              ),
                              child: SizedBox.expand(
                                child: FlatButton(
                                  child: Text(
                                    "Login",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        shadows: <Shadow>[
                                          Shadow(
                                              offset: Offset(0.5, 0.5),
                                              blurRadius: 1.0,
                                              color: Color.fromARGB(
                                                  185, 10, 10, 8)),
                                        ]),
                                    textAlign: TextAlign.center,
                                  ),
                                  onPressed: () {
                                    login();
                                  },
                                ),
                              ),
                            ),
                            SizedBox(height: 20),

                            Container(
                              height: 60,
                              alignment: Alignment.center,
                              //Botao
                              // ignore: missing_required_param
                              child: FlatButton(
                                child: Text("Faça login com o Google.",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        fontFamily: 'Roboto',
                                        color: Colors.black45,
                                        shadows: <Shadow>[
                                          Shadow(
                                              offset: Offset(0.5, 0.5),
                                              blurRadius: 1.0,
                                              color: Colors.grey),
                                        ])),
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
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border:
                                    Border.all(color: Colors.white, width: 1),
                                borderRadius: BorderRadius.circular(15),
                                image: DecorationImage(
                                    image: AssetImage('assets/icon_google.png'),
                                    fit: BoxFit.fitHeight,
                                    alignment: Alignment(-0.9, 0.5)),
                              ),
                            ),
                            SizedBox(height: 45),

                            Container(
                              height: 40, //altura que ira ficar
                              alignment: Alignment.center, //Alinhando

                              //Botao
                              child: FlatButton(
                                child: RichText(
                                  text: TextSpan(children: <TextSpan>[
                                    TextSpan(
                                        text: "Não possui uma conta?",
                                        style: TextStyle(
                                            color: Colors.black87,
                                            fontFamily: 'Roboto',
                                            shadows: <Shadow>[
                                              Shadow(
                                                  offset: Offset(0.5, 0.5),
                                                  blurRadius: 1.0,
                                                  color: Colors.grey),
                                            ])),
                                    TextSpan(
                                        text: "Cadastre-se aqui!",
                                        style: TextStyle(
                                            color: Colors.redAccent,
                                            fontFamily: 'Roboto',
                                            shadows: <Shadow>[
                                              Shadow(
                                                  offset: Offset(0.5, 0.5),
                                                  blurRadius: 1.0,
                                                  color: Color.fromARGB(
                                                      185, 10, 10, 8)),
                                            ])),
                                  ]), //Texto a ser exibido
                                  textAlign: TextAlign
                                      .center, //Posicionando na direita
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

        Fluttertoast.showToast(msg: "Login com sucesso!");

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
