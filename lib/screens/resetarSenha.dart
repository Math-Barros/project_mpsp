import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ResetarSenha extends StatefulWidget {
  ResetarSenha({Key key}) : super(key: key);

  @override
  _ResetarSenhaState createState() => _ResetarSenhaState();
}

class _ResetarSenhaState extends State<ResetarSenha> {
  var _formkey = GlobalKey<FormState>();
  TextEditingController editController = TextEditingController();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Voltar"),
        backgroundColor: Colors.redAccent[700], //Cor de fundo da tela
        automaticallyImplyLeading: true,
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            color: Colors.white,
            onPressed: () => Navigator.pop(context)),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.only(
                left: 20,
                right: 20,
                top: 15,
              ),
              child: SingleChildScrollView(
                child: Form(
                    key: _formkey,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            child: Column(
                              children: <Widget>[
                                //Icone de reset
                                SizedBox(
                                  width: 600,
                                  height: 200,
                                  child: Image.asset(
                                      "assets/reset-password-icon.png"),
                                ),

                                //Espacamento da logo com o resto da tela
                                SizedBox(
                                  height: 20,
                                ),

                                Text(
                                  "RESETAR",
                                  style: TextStyle(
                                    fontSize: 32,
                                    fontWeight: FontWeight.w500,
                                    shadows: <Shadow>[
                                        Shadow(
                                          offset: Offset(0.5,0.5),
                                          blurRadius: 1.0,
                                          color: Colors.grey
                                        ),
                                      ]
                                  ),
                                ),

                                SizedBox(
                                  height: 10,
                                ),

                                Text(
                                  "Informe o e-mail associado a sua conta. Um link com o passo a passo para resetar a senha será enviado no mesmo.",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400,
                                    shadows: <Shadow>[
                                        Shadow(
                                          offset: Offset(0.5,0.5),
                                          blurRadius: 1.0,
                                          color: Colors.grey
                                        ),
                                      ]
                                  ),
                                ),
                              ],
                            ),
                          ),

                          SizedBox(height: 30,),
                          Container(
                            width: 600,
                            
                            child: Column(
                              children: <Widget>[
                                TextFormField(
                                  autofocus: true, //Para focar no campo
                                  keyboardType: TextInputType.emailAddress,

                                  //Configuracoes do campo
                                  controller: editController,
                                  decoration: new InputDecoration(
                                      labelText:
                                          "Email", //Texto que ira aparecer

                                      labelStyle: TextStyle(
                                          color: Colors.black38,
                                          fontWeight: FontWeight.w400,
                                          fontSize:
                                              20),
                                              border: new OutlineInputBorder(
                                      borderRadius: new BorderRadius.circular(15.0),
                                      borderSide: new BorderSide(color: Colors.grey, width:1),
                                    ), //Cor, espessura e tamanho

                                      ),
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                                Container(
                                  height: 50,
                                  alignment: Alignment.center,
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
                                    //Botão enviar
                                    child: FlatButton(
                                      child: Text(
                                        "ENVIAR",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w800,
                                            color: Colors.black,
                                            fontSize: 20,
                                            shadows: <Shadow>[
                                        Shadow(
                                          offset: Offset(0.5,0.5),
                                          blurRadius: 1.0,
                                          color: Color.fromARGB(185, 10, 10, 8)
                                        ),
                                      ]),
                                            
                                      ),
                                      onPressed: () {
                                        resetPassword(context);
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

  void resetPassword(BuildContext context) async {
    if (editController.text.length == 0 || !editController.text.contains("@")) {
      Fluttertoast.showToast(msg: "Insira um email valido!!");
      return;
    }

    await FirebaseAuth.instance
        .sendPasswordResetEmail(email: editController.text);
    Fluttertoast.showToast(
        msg:
            "Um link foi enviado ao seu email, use ele para resetar sua senha.");
    Navigator.pop(context);
  }
}
