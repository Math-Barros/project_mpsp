import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:project_mpsp/models/user_model.dart';
import 'package:project_mpsp/screens/home_screen.dart';
import 'package:project_mpsp/utils/firebase_utils.dart';
import 'package:icon_shadow/icon_shadow.dart';

class CadastroScreen extends StatefulWidget {
  CadastroScreen({Key key}) : super(key: key);

  @override
  _CadastroScreenState createState() => _CadastroScreenState();
}

class _CadastroScreenState extends State<CadastroScreen> {
  String _email, _password, _nome, _cpf;
  var _formkey = GlobalKey<FormState>();

  bool autoValidate = false;
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
                top: 5,
              ),
              child: SingleChildScrollView(
                child: Form(
                  key: _formkey,
                  child: Center(
                    child: Column(
                      children: <Widget>[
                        //Icone de reset
                        /*SizedBox(
                          width: 100,
                          height: 100,
                          child: Image.asset("assets/social.png"),
                        ),*/

                        //Espacamento da logo com o resto da tela
                        SizedBox(
                          height: 20,
                        ),

                        Text(
                          "CADASTRE-SE",
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: 30,
                            fontWeight: FontWeight.w500,
                            shadows: <Shadow>[
                                        Shadow(
                                          offset: Offset(0.5,0.5),
                                          blurRadius: 1.0,
                                          color: Colors.grey
                                        ),
                                      ],
                            
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
                            fontFamily: 'Roboto',
                            fontSize: 15,
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

                         SizedBox(height: 10,),
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
                              border: new OutlineInputBorder(
                                      borderRadius: new BorderRadius.circular(15.0),
                                      borderSide: new BorderSide(color: Colors.grey, width:1),
                                    )
                            ),
                            validator: (item) {
                              return item.length > 0
                                  ? null
                                  : "Insira um nome válido!";
                            },
                            onChanged: (item) {
                              setState(() {
                                _nome = item;
                              });
                            }),
                            SizedBox(
                          height: 10,
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
                            border: new OutlineInputBorder(
                                      borderRadius: new BorderRadius.circular(15.0),
                                      borderSide: new BorderSide(color: Colors.grey, width:1),
                                    )
                          ),
                          validator: (item) {
                            return item.length < 11
                                ? "Insira um CPF válido"
                                : null;
                          },
                          onChanged: (item) {
                            setState(() {
                              _cpf = item;
                            });
                          },
                          inputFormatters: [
                            // ignore: deprecated_member_use
                            WhitelistingTextInputFormatter.digitsOnly
                          ],
                        ),
                        SizedBox(
                          height: 10,
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
                            border: new OutlineInputBorder(
                                      borderRadius: new BorderRadius.circular(15.0),
                                      borderSide: new BorderSide(color: Colors.grey, width:1),
                                    )
                          ),
                          validator: (item) {
                            return item.length > 6
                                ? null
                                : "Sua senha deve ter no mínimo 6 caracteres!";
                          },
                          onChanged: (item) {
                            setState(() {
                              _password = item;
                            });
                          },
                        ),
                        SizedBox(
                          height: 10,
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
                            border: new OutlineInputBorder(
                                      borderRadius: new BorderRadius.circular(15.0),
                                      borderSide: new BorderSide(color: Colors.grey, width:1),
                                    )
                            
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
                        SizedBox(
                          height: 30,
                        ),

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
                                "CADASTRAR",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  fontSize: 27,
                                  shadows: <Shadow>[
                                        Shadow(
                                          offset: Offset(0.5,0.5),
                                          blurRadius: 1.0,
                                          color: Color.fromARGB(185, 10, 10, 8)
                                        ),
                                      ]
                                ),
                                textAlign: TextAlign.center,
                              ),
                              onPressed: () {
                                signup();
                              },
                            ),
                          ),
                        ),
                        
                        SizedBox(height: 20),
                        Container(height: 50,
                              alignment: Alignment.center,
                              //Botao
                                // ignore: missing_required_param
                                child: FlatButton(
                                  child: Text("Cadastre-se com o Google.", textAlign: TextAlign.left, style: TextStyle(
                                    fontFamily: 'Roboto',
                                    color: Colors.black45,
                                    shadows: <Shadow>[
                                        Shadow(
                                          offset: Offset(0.5,0.5),
                                          blurRadius: 1.0,
                                          color: Colors.grey
                                        ),
                                      ]
                                  )),
                                ),
                                decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(color:Colors.grey, width:1),
                                borderRadius: BorderRadius.circular(15),
                                image: DecorationImage(image: AssetImage('assets/icon_google.png'),
                                fit: BoxFit.fitHeight,
                                
                                alignment: Alignment(-0.9,0.5)),

                                
                                

                              ),
                              
                              ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
    );
  }

  void signup() {
    if (_formkey.currentState.validate()) {
      setState(() {
        isLoading = true;
      });
      setState(() {
        autoValidate = false;
      });
      FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: _email, password: _password)
          .then((user) {
        // sign up
        postUserDataToDb();
      }).catchError((onError) {
        setState(() {
          isLoading = false;
        });
        Fluttertoast.showToast(msg: "error " + onError.toString());
      });
    } else {
      setState(() {
        autoValidate = true;
      });
    }
  }

  void postUserDataToDb() async {
    setState(() {
      isLoading = true;
    });

    //FirebaseUser firebaseUser = await FirebaseAuth.instance.currentUser();
    User firebaseUser = FirebaseAuth.instance.currentUser;

    UserModel userModel = new UserModel();
    userModel.email = _email;
    userModel.nome = _nome;
    userModel.cpf = _cpf;
    userModel.uid = firebaseUser.uid;

    // await FireStore.instance
    //     .collection("user")
    //     .document(firebaseUser.uid)
    //     .setData(userModel.toMap());

    await FirebaseFirestore.instance
        .collection("user")
        .doc(firebaseUser.uid)
        .set(userModel.toMap());

    Fluttertoast.showToast(msg: "Cadastro efetuado!");

    await FirebaseUtils.updateFirebaseToken();

    sendVerificationEmail();

    setState(() {
      isLoading = false;
    });
  }

  void sendVerificationEmail() async {
    //FirebaseUser firebaseUser = await FirebaseAuth.instance.currentUser();
    User firebaseUser = FirebaseAuth.instance.currentUser;
    await firebaseUser.sendEmailVerification();

    Fluttertoast.showToast(
        msg: "Um link de verificação foi enviado a seu email!");

    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => HomeScreen()),
        (Route<dynamic> route) => false);
  }
}
