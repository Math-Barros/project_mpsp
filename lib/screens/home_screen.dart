import 'package:flutter/material.dart';
import 'package:project_mpsp/models/usuario_model.dart';

class HomeScreen extends StatelessWidget {
  final UsuarioModel usuarioModel;

  const HomeScreen({
    this.usuarioModel,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.only(top: 0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 0, vertical: 30),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(100.0),
                          child: Image.network(
                            'https://static.thenounproject.com/png/629576-200.png',
                            width: 100,
                          ),
                        ),
                      ),
                      Text(
                        'Olá, ${usuarioModel.nome}',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: Colors.red,
                            fontSize: 25,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 4),
                      child: Text(
                        "Notícia",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ],
                ),
                Card(
                  elevation: 12.0,
                  margin: new EdgeInsets.symmetric(
                    horizontal: 12.0,
                    vertical: 6.0,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white70,
                    ),
                    child: ListTile(
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: 15.0, vertical: 10.0),
                      title: Text(
                        "Aplicativo de soluções MPSP está disponível para sistemas Android e iOS",
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 16,
                        ),
                      ),
                      subtitle: Row(
                        children: <Widget>[
                          Expanded(
                            flex: 3,
                            child: Padding(
                              padding: EdgeInsets.only(left: 0),
                              child: Text(
                                "Ferramenta permite comunicação rápida e compartilhamento de arquivos",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      onTap: () {},
                    ),
                  ),
                ),
                Card(
                  elevation: 12.0,
                  margin: new EdgeInsets.symmetric(
                    horizontal: 12.0,
                    vertical: 6.0,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white70,
                    ),
                    child: ListTile(
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: 15.0, vertical: 10.0),
                      title: Text(
                        "Podcast traz conversa sobre direitos da pessoa idosa na pandemia de covid-19",
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 16,
                        ),
                      ),
                      subtitle: Row(
                        children: <Widget>[
                          Expanded(
                            flex: 3,
                            child: Padding(
                              padding: EdgeInsets.only(left: 0),
                              child: Text(
                                "Programa está disponível no Spotify, Deezer, iTunes e Google",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      onTap: () {},
                    ),
                  ),
                ),
                Card(
                  elevation: 12.0,
                  margin: new EdgeInsets.symmetric(
                    horizontal: 12.0,
                    vertical: 6.0,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white70,
                    ),
                    child: ListTile(
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: 15.0, vertical: 10.0),
                      title: Text(
                        "Medidas para responsabilizar autores de focos de queimadas são temas do MPSP+",
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 16,
                        ),
                      ),
                      subtitle: Row(
                        children: <Widget>[
                          Expanded(
                            flex: 3,
                            child: Padding(
                              padding: EdgeInsets.only(left: 0),
                              child: Text(
                                "Promotora Tatiana Serra é a entrevistada nesta edição do programa",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      onTap: () {},
                    ),
                  ),
                ),
                SizedBox(height: 24),
                FutureBuilder<List>(
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      if (snapshot.data.length > 0) {
                        return Text(snapshot.data.toString());
                      } else {
                        return Center(
                          child: Text("Nenhum cadastrado!"),
                        );
                      }
                    } else {
                      return Center(
                          //child: CircularProgressIndicator(),
                          );
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
