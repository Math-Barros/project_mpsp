import 'package:flutter/material.dart';

class ResetarSenha extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //barra top da tela
      appBar: AppBar(
        backgroundColor: Colors.white, //Cor de fundo da tela
        automaticallyImplyLeading: true,
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            color: Colors.black,
            onPressed: () => Navigator.pop(context, false)),
      ),

      body: Container(
        padding: EdgeInsets.only(top: 1, left: 1, right: 1),
        color: Colors.white,
        child: ListView(
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  child: Column(
                    children: <Widget>[
                      //Icone de reset
                      SizedBox(
                        width: 200,
                        height: 200,
                        child: Image.asset("assets/reset-password-icon.png"),
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
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          labelText: "E-mail",
                          labelStyle: TextStyle(
                            color: Colors.black38,
                            fontWeight: FontWeight.w500,
                            fontSize: 20,
                          ),
                        ),
                        style: TextStyle(fontSize: 20),
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
                            onPressed: () {},
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
