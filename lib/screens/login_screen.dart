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
                              child: Image.asset("assets/logo-launcher.png"), //logo

                            ),
                            
                            //Texto bem-vindo
                            Text("Bem-vindo!", style: TextStyle(
                              shadows: <Shadow>[
                                Shadow(
                                  offset: Offset(0.5, 0.5),
                                  blurRadius: 1.0,
                                  color: Color.fromARGB(255,0,0,0),
                                ),
                              ],
                              fontSize: 45, color: Colors.black, fontFamily: 'Roboto', fontWeight: FontWeight.w500
                            )),

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
                                      fontSize: 20), //Cor, espessura e tamanho


                                  border: new OutlineInputBorder(
                                    borderRadius: new BorderRadius.circular(15.0),
                                    borderSide: new BorderSide(color: Colors.grey, width:1),
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
                            ),),

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
                                    borderSide: new BorderSide(color: Colors.grey, width:1),
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
                                        offset: Offset(0.5,0.5),
                                        blurRadius: 1.0,
                                        color: Color.fromARGB(185, 10, 10, 8)
                                      ),
                                    ],
                                    fontFamily: 'Roboto',
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red,

                                  ), //Texto a ser exibido
                                  textAlign:
                                      TextAlign.center, //Posicionando na direita
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
                              height: 50,
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
                                    "ENTRAR",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
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
                            SizedBox(height: 10),

                            Container(height: 50,
                            alignment: Alignment.center,
                            
                            ),


                            Container(
                              height: 40, //altura que ira ficar
                              alignment: Alignment.center, //Alinhando

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
