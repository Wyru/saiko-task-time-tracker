import 'package:flutter/material.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({super.key});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  @override
  void initState() {
    super.initState();
    // TODO: implement initState
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
      padding: EdgeInsets.zero,
      children: const <Widget>[
        DrawerHeader(
          decoration: BoxDecoration(
            color: Colors.blue,
          ),
          child: Text(
            'Menu',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
            ),
          ),
        ),
        ListTile(
          leading: Icon(Icons.task),
          title: Text('Executar Tarefa'),
        ),
        ListTile(
          leading: Icon(Icons.list),
          title: Text('Histórico de Tarefas'),
        ),
        ListTile(
          leading: Icon(Icons.tag),
          title: Text('Categorias'),
        ),
        ListTile(
          leading: Icon(Icons.details),
          title: Text('Sobre'),
        ),
      ],
    ));
  }
}
