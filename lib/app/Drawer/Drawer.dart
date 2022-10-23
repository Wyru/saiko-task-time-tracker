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
  }

  @override
  Widget build(BuildContext context) {
    Color selectedColor = const Color.fromRGBO(118, 88, 152, 1);

    return Drawer(
        child: ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        const DrawerHeader(
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
          leading: const Icon(Icons.task),
          title: const Text('Executar Tarefa'),
          selectedColor: selectedColor,
          selected: true,
          onTap: () {
            Navigator.of(context).popUntil(ModalRoute.withName('/'));
          },
        ),
        ListTile(
          leading: const Icon(Icons.list),
          title: const Text('Histórico de Tarefas'),
          selectedColor: selectedColor,
          onTap: () {
            Navigator.popAndPushNamed(context, '/taskHistory');
          },
        ),
        ListTile(
          leading: const Icon(Icons.tag),
          title: const Text('Categorias'),
          selectedColor: selectedColor,
          onTap: () {
            Navigator.popAndPushNamed(context, '/categories');
          },
        ),
        ListTile(
          leading: const Icon(Icons.info_outline),
          title: const Text('Sobre'),
          onTap: () {},
        ),
      ],
    ));
  }
}
