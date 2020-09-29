import 'package:flutter/material.dart';

class PagInicial extends StatelessWidget {
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
    );
  }
}
