import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);



  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Contato> contatos = [];

  @override
  void initState() {
   
    super.initState();
    
    contatos.add(new Contato(nome: "Oswaldo", telefone: "9999", tipo: ContatoType.CASA));
    contatos.add(new Contato(nome: "Oswaldo2", telefone: "9996", tipo: ContatoType.CELULAR));
    contatos.add(new Contato(nome: "Oswaldo3", telefone: "9996", tipo: ContatoType.TRABALHO));

    contatos.sort((a,b) => a.nome.compareTo(b.nome));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.separated(itemBuilder: (context, index) {
        var contato = contatos[index];
        return ListTile(
          leading: CircleAvatar(
            child: ContatoHelper.getIconByContatoType(contato.tipo),
            backgroundColor: Colors.blue[200],
          ),
          title: Text(contato.nome),
          subtitle: Text(contato.telefone),
          trailing: IconButton(
            icon: Icon(Icons.call),
            onPressed: () => {},
          ),

        );

      },  separatorBuilder: (context, index) => Divider(),
          itemCount: contatos.length)
    );
  }
}

class Contato{
  final String nome;
  final String telefone;
  final ContatoType tipo;

  Contato({@required this.nome,@required this.telefone,@required this.tipo});

}
enum ContatoType{CELULAR,TRABALHO,FAVORITO,CASA}
class ContatoHelper{
  static Icon getIconByContatoType(ContatoType tipo){
    switch(tipo){
      case ContatoType.CELULAR:
        return Icon(Icons.phone_android, color: Colors.green[700]);
      case ContatoType.TRABALHO:
        return Icon(Icons.work, color: Colors.brown[600]);
      case ContatoType.FAVORITO:
        return Icon(Icons.star, color: Colors.yellow[600]);
      case ContatoType.CASA:
        return Icon(Icons.home, color: Colors.purple[600]);
    }
  }


}