import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:maindttt/app/Drawer/Drawer.dart';
import 'package:maindttt/data/DataAccessProvider.dart';
import 'package:maindttt/model/TaskCategory.dart';

class Home extends StatefulWidget {
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TaskCategory? currentCategory;

  final taskFieldController = TextEditingController();

  bool isButtonDisabled = true;

  @override
  void initState() {
    super.initState();
  }

  void updateButton() {
    setState(() {
      isButtonDisabled =
          taskFieldController.text == '' || currentCategory == null;
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
              const Spacer(
                flex: 1,
              ),
              Flexible(
                flex: 4,
                child: TextField(
                  controller: taskFieldController,
                  style: const TextStyle(
                    fontSize: 25.0,
                  ),
                  onChanged: (value) {
                    updateButton();
                  },
                  onSubmitted: (value) {
                    updateButton();
                  },
                  decoration: InputDecoration(
                    hintText: 'O que você vai fazer, senpai? (^///^)',
                    border: UnderlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        borderSide: const BorderSide(
                          width: 4,
                        )),
                  ),
                ),
              ),
              const Spacer(
                flex: 1,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: InputChip(
                    tooltip: "categoria",
                    avatar: CircleAvatar(
                      backgroundColor: currentCategory?.color ?? Colors.white,
                      child: Icon(
                        currentCategory?.icon ?? Icons.cancel,
                        color: currentCategory?.getTextColor() ?? Colors.black,
                      ),
                    ),
                    label: Text(
                      currentCategory?.name ?? 'Categoria não selecionada!',
                      style: const TextStyle(fontSize: 20),
                    ),
                    onPressed: () async {
                      var category = await _dialogBuilder(context);
                      setState(() {
                        currentCategory = category;
                      });
                      updateButton();
                    }),
              )
            ],
          ),
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Ink(
                decoration: const ShapeDecoration(
                  color: Colors.blue,
                  shape: CircleBorder(),
                ),
                child: IconButton(
                  iconSize: 48,
                  color: Colors.white,
                  onPressed: isButtonDisabled ? null : () {},
                  icon: const Icon(Icons.play_arrow),
                ),
              ),
            ],
          )
        ],
      )),
    );
  }

  Future<TaskCategory?> _dialogBuilder(BuildContext context) async {
    var categories =
        Provider.of<DataAccessProvider>(context, listen: false).categories;

    var category = await showDialog<TaskCategory>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Selecione uma categoria!'),
          content: Container(
            width: MediaQuery.of(context).size.width / 2,
            child: ListView.separated(
              itemCount: categories.length,
              separatorBuilder: (context, index) {
                return const Divider(
                  thickness: 2,
                );
              },
              itemBuilder: (context, index) {
                return ListTile(
                  onTap: () {
                    Navigator.pop(context, categories[index]);
                  },
                  leading: Icon(categories[index].icon),
                  title: Text(categories[index].name),
                  iconColor: categories[index].color,
                );
              },
            ),
          ),
        );
      },
    );

    return category;
  }
}
