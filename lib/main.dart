import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:flutter/services.dart';
import 'package:dropdown_formfield/dropdown_formfield.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Lista de Contato',
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

  final TextNome = TextEditingController();
  final TextTelefone = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  String _result = "";
  String _msg = "";
  String _myActivity;
  String _myActivityResult;

  @override
  void initState() {
   
    super.initState();
    _myActivityResult='';
    _myActivity='';

    contatos.add(new Contato(nome: "Oswaldo", telefone: "9999", tipo: ContatoType.CASA));
    contatos.add(new Contato(nome: "Oswaldo2", telefone: "9996", tipo: ContatoType.CELULAR));
    contatos.add(new Contato(nome: "Oswaldo3", telefone: "9996", tipo: ContatoType.TRABALHO));
    contatos.add(new Contato(nome: "Elaine", telefone: "9996", tipo: ContatoType.FAVORITO));

    contatos.sort((a,b) => a.nome.compareTo(b.nome));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Lista de Contatos'),

        ),
        floatingActionButton: FloatingActionButton(
          tooltip: 'Adicionar Novo Contato',
          onPressed: () {
                _form();
          },
          child: Icon(Icons.add),
        ),



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
  TextFieldValidator alturaValidador(){
    return RequiredValidator(errorText: "Requirido");
  }

  TextFieldValidator pesoValidador(){
    return RequiredValidator(errorText: "Requirido");
  }


  void _form() {

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Caculadora IMC'),
          ),
          body: Form(
            key: _formkey,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Wrap(
                spacing: 20,
                runSpacing: 10,
                children: <Widget>[
                  TextFormField(
                    controller: TextNome,
                    validator: alturaValidador(),
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      labelText: "Nome",
                    ),


                  ),
                  TextFormField(
                    controller: TextTelefone,
                    validator: pesoValidador(),
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      labelText: "Telefone",
                     ),
                  ),


                  Container(
                    padding: EdgeInsets.all(16),
                    child: DropDownFormField(
                      titleText: 'My workout',
                      hintText: "_myActivityResult",
                      value: _myActivity,

                      onChanged: (value) {
                        setState(() {
                          _myActivity = value;
                          _myActivityResult = _myActivity;
                        });
                      },
                      dataSource: [
                        {
                          "display": "Running",
                          "value": "Running",
                        },
                        {
                          "display": "Climbing",
                          "value": "Climbing",
                        },
                        {
                          "display": "Walking",
                          "value": "Walking",
                        },
                        {
                          "display": "Swimming",
                          "value": "Swimming",
                        },
                        {
                          "display": "Soccer Practice",
                          "value": "Soccer Practice",
                        },
                        {
                          "display": "Baseball Practice",
                          "value": "Baseball Practice",
                        },
                        {
                          "display": "Football Practice",
                          "value": "Football Practice",
                        },
                      ],
                      textField: 'display',
                      valueField: 'value',
                    ),
                  ),

                  Container(
                    padding: EdgeInsets.all(16),
                    child: Text(_myActivityResult),
                  ),


                  SizedBox(
                    width: double.infinity,
                    child: Text(

                      '$_msg',
                      style: Theme.of(context).textTheme.headline5,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  ElevatedButton(
                      child: Text("Cancelar"),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.grey, // background
                      //onPrimary: Colors.white, // foreground
                    ),
                      onPressed: (){
                          Navigator.pop(context);
                      },
                    ),
                  ElevatedButton(
                    child: Text("Salvar"),
                    onPressed: (){
                      Navigator.pop(context);
                    },
                  )

                ],
              ),

            ),
          ),
        );
      },
    );

  }
}

class Contato{

  final String nome;
  final String telefone;
  final ContatoType tipo;

  Contato({@required this.nome,@required this.telefone,@required this.tipo});

  Map<String, dynamic> toMap() {
    return {

      'nome': nome,
      'tefone': telefone,
      'tipo': tipo,
    };
  }

  @override
  String toString() {
    return 'Contato{nome: $nome, telefone: $telefone, tipo:  $tipo}';
  }

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
  static const Map<ContatoType, String> ContatoTypeName = {
    ContatoType.CASA: "Casa",
    ContatoType.CELULAR: "Celular",
    ContatoType.TRABALHO: "Trabalho",
    ContatoType.FAVORITO: "Favorito",
  };

}


