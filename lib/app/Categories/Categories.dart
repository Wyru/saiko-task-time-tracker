import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:provider/provider.dart';
import 'package:maidttt/data/DataAccessProvider.dart';
import 'package:maidttt/model/TaskCategory.dart';

class CategoriesRoute extends StatefulWidget {
  const CategoriesRoute({super.key});

  @override
  State<CategoriesRoute> createState() => _CategoriesRouteState();
}

class _CategoriesRouteState extends State<CategoriesRoute> {
  Color currentColor = Colors.blueAccent;
  IconData currentIcon = Icons.task;
  String currentTaskName = '';

  @override
  Widget build(BuildContext context) {
    var categories = Provider.of<DataAccessProvider>(context).categories;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Categorias'),
      ),
      body: Column(
        children: [
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(
                flex: 1,
              ),
              Flexible(
                flex: 3,
                child: TextField(
                  onChanged: (value) {
                    setState(() {
                      currentTaskName = value;
                    });
                  },
                  onSubmitted: (value) {
                    createCategory(context);
                  },
                  style: const TextStyle(
                    fontSize: 25.0,
                  ),
                  decoration: InputDecoration(
                    prefixIcon:
                        Icon(currentIcon, color: currentColor, size: 30),
                    fillColor: currentColor,
                    hintText: 'Digite o nome da categoria a ser adicionada!',
                    border: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: Colors.blueAccent, width: 32.0),
                        borderRadius: BorderRadius.circular(25.0)),
                  ),
                ),
              ),
              const SizedBox(width: 30),
              OutlinedButton.icon(
                style: OutlinedButton.styleFrom(backgroundColor: currentColor),
                label: Text('COR',
                    style: TextStyle(
                        fontSize: 18,
                        color: currentColor.computeLuminance() > 0.5
                            ? Colors.black
                            : Colors.white)),
                onPressed: () {
                  openColorPicker(context);
                },
                icon: Icon(
                  Icons.color_lens,
                  color: currentColor.computeLuminance() > 0.5
                      ? Colors.black
                      : Colors.white,
                  size: 42,
                ),
              ),
              const SizedBox(width: 30),
              OutlinedButton.icon(
                style: OutlinedButton.styleFrom(backgroundColor: currentColor),
                label: Text('TAG',
                    style: TextStyle(
                        fontSize: 18,
                        color: currentColor.computeLuminance() > 0.5
                            ? Colors.black
                            : Colors.white)),
                onPressed: () {},
                icon: Icon(
                  Icons.tag,
                  color: currentColor.computeLuminance() > 0.5
                      ? Colors.black
                      : Colors.white,
                  size: 42,
                ),
              ),
              const Spacer(
                flex: 1,
              ),
            ],
          ),
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Ink(
                decoration: const ShapeDecoration(
                  color: Colors.blue,
                  shape: CircleBorder(),
                ),
                child: IconButton(
                  iconSize: 48,
                  color: Colors.white,
                  onPressed: () {
                    createCategory(context);
                  },
                  icon: const Icon(Icons.add),
                ),
              ),
              const SizedBox(width: 40),
            ],
          ),
          Flexible(
            flex: 1,
            child: RefreshIndicator(
              onRefresh: refresh,
              child: ListView.separated(
                padding: const EdgeInsets.only(top: 15.0),
                itemCount: categories.length,
                itemBuilder: buildItem,
                separatorBuilder: (context, index) {
                  return const Divider(
                    thickness: 2,
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildItem(context, index) {
    var categories = Provider.of<DataAccessProvider>(context).categories;

    return Dismissible(
      key: Key(DateTime.now().millisecondsSinceEpoch.toString()),
      background: Container(
        color: Colors.redAccent,
        child: const Align(
            alignment: Alignment(-0.9, 0.0),
            child: Icon(Icons.delete, color: Colors.white)),
      ),
      direction: DismissDirection.startToEnd,
      child: ListTile(
        leading: Icon(categories[index].icon),
        title: Text(
          categories[index].name,
          style: TextStyle(fontSize: 24),
        ),
        iconColor: categories[index].color,
      ),
      onDismissed: (direction) => deleteCategory(direction, index, context),
    );
  }

  Future<Null> refresh() async {
    await Future.delayed(Duration(seconds: 1));

    setState(() {});

    return null;
  }

  Future<String?> openColorPicker(BuildContext context) async {
    var category = await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
            titlePadding: const EdgeInsets.all(0),
            contentPadding: const EdgeInsets.all(0),
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(25))),
            content: SingleChildScrollView(
              child: SlidePicker(
                pickerColor: currentColor,
                onColorChanged: (Color newColor) {
                  setState(() {
                    currentColor = newColor;
                  });
                },
                colorModel: ColorModel.rgb,
                enableAlpha: false,
                displayThumbColor: true,
                showParams: true,
                showIndicator: true,
                indicatorBorderRadius:
                    const BorderRadius.vertical(top: Radius.circular(25)),
              ),
            ));
      },
    );
    return category;
  }

  void createCategory(context) {
    var categories =
        Provider.of<DataAccessProvider>(context, listen: false).categories;

    categories.add(TaskCategory(currentTaskName, currentColor, currentIcon));
    setState(() {});

    // validar valores
    // validar se já não existe uma categoria assim

    // criar categoria
    final snackBar = SnackBar(
      content: Text("Categoria \"$currentTaskName\" adicionada!"),
      duration: const Duration(seconds: 1),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void deleteCategory(direction, int index, BuildContext context) {
    var categories =
        Provider.of<DataAccessProvider>(context, listen: false).categories;

    final TaskCategory lastRemovedCategory = categories[index];

    categories.removeAt(index);

    setState(() {});

    final snackBar = SnackBar(
      content: Text("Categoria \"${lastRemovedCategory.name}\" removida!"),
      duration: const Duration(seconds: 1),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
