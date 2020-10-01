import 'package:flutter/material.dart';
import 'package:project_mpsp/models/usuario_model.dart';
import 'package:project_mpsp/repository/usuario_repository.dart';
import 'package:project_mpsp/screens/cadastro.dart';
import 'package:project_mpsp/screens/pagInicial.dart';
import 'package:project_mpsp/screens/resetarSenha.dart';

class Login extends StatefulWidget {
  Login({Key key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GlobalKey<FormState> formKey = new GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  UsuarioRepository usuarioRepository = UsuarioRepository();
  UsuarioModel usuarioModel = UsuarioModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //Area onde fica os inputs do login
      body: Container(
        //Delimitando a area do login
        padding: EdgeInsets.only(top: 60, left: 40, right: 40),
        color: Colors.white, //Cor do fundo

        child: ListView(
          children: <Widget>[
            //Local onde a logo ira aparecer
            SizedBox(
              //Tamanho do logo
              width: 128,
              height: 128,

              //Carregando a imagem
              child: Image.asset("assets/logo-mpsp.jpg"), //logo
            ),
            //Espaço entre a logo e os inputs
            SizedBox(
              height: 20,
            ),
            //Campo de CPF
            TextFormField(
              autofocus: true, //Para focar no campo

              keyboardType:
                  TextInputType.number, //Exibe somente os numeros do teclado

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
            //Espacamento entre inputs
            SizedBox(height: 10),
            //Campo de senha
            TextFormField(
              autofocus: true,
              keyboardType: TextInputType.text, //permite numeros e letras
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
                  return 'Insira sua senha!';
                }
                return null;
              },
              onSaved: (value) {
                usuarioModel.senha = value;
              },
            ),

            //Botao de recuperar senha
            Container(
              height: 40, //altura que ira ficar
              alignment: Alignment.centerRight, //Alinhando

              //Botao
              child: FlatButton(
                //Texto do botao
                child: Text(
                  "Recuperar senha", //Texto a ser exibido
                  textAlign: TextAlign.right, //Posicionando na direita
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
                //Texto do botao
                child: Text(
                  "Não possui uma conta? Cadastre-se!", //Texto a ser exibido
                  textAlign: TextAlign.right, //Posicionando na direita
                ),

                //Ao pressionar o botao
                onPressed: () {
                  //Muda para a pagina de cadastro
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Cadastro(),
                    ),
                  );
                },
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(16.0),
              child: RaisedButton(
                child: Text("Entrar",
                    style: TextStyle(
                      color: Colors.white,
                    )),
                color: Colors.pink,
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
                          'Não foi possível faze o login.',
                        ),
                      ),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
