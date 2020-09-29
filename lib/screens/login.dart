import 'package:flutter/material.dart';
import 'package:project_mpsp/screens/cadastro.dart';
import 'package:project_mpsp/screens/pagInicial.dart';
import 'package:project_mpsp/screens/resetarSenha.dart';

class Login extends StatelessWidget {
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
              decoration: InputDecoration(
                  labelText: "CPF", //Texto que ira aparecer

                  labelStyle: TextStyle(
                      color: Colors.black38,
                      fontWeight: FontWeight.w400,
                      fontSize: 20) //Cor, espessura e tamanho

                  ),
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

            RaisedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => PagInicial(),
                      ),
                );
              },
              child: const Text('Acessar', style: TextStyle(fontSize: 20)),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
