import 'package:flutter/material.dart';
import 'package:saikottt/Drawer/Drawer.dart';

class Home extends StatefulWidget {
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String currentCategory = '';

  @override
  void initState() {
    super.initState();
    setState(() {
      currentCategory = 'Não selecionada';
    });
  }

  @override
  Widget build(BuildContext context) {
    final ButtonStyle style =
        ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20));
    return Scaffold(
      appBar: AppBar(
        title: const Text('Executar Tarefa'),
      ),
      drawer: const MyDrawer(),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: const [Text("Input nome da task")],
              ),
              const SizedBox(width: 30),
              Column(
                children: [
                  InputChip(
                      avatar: CircleAvatar(
                        backgroundColor: Colors.grey.shade800,
                        child: const Icon(Icons.work_history_outlined),
                      ),
                      label: Text(currentCategory),
                      onPressed: () async {
                        print('I am the one thing in life.');
                        var category = await _dialogBuilder(context);
                        print(category);

                        setState(() {
                          currentCategory = category ?? 'Não Selecionada';
                        });
                      })
                ],
              )
            ],
          ),
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                style: style,
                onPressed: () {},
                child: const Text('Iniciar!'),
              ),
            ],
          )
        ],
      )),
    );
  }

  Future<String?> _dialogBuilder(BuildContext context) async {
    var category = await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: const Text('Selecione uma categoria!'),
          children: <Widget>[
            SimpleDialogOption(
              onPressed: () {
                Navigator.pop(context, 'Estudos');
              },
              child: const Text('Estudos'),
            ),
            SimpleDialogOption(
              onPressed: () {
                Navigator.pop(context, 'Trabalho');
              },
              child: const Text('Trabalho'),
            ),
          ],
        );
      },
    );

    return category;
  }
}
