import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:maidttt/data/dataAccessProvider.dart';
import 'package:provider/provider.dart';
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

    return Consumer<DataAccessProvider>(
        builder: (context, dataAccessProvider, child) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Categorias'),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            openCreateModal(context, dataAccessProvider);
          },
          backgroundColor: Colors.blue,
          child: const Icon(Icons.add),
        ),
        body: Column(
          children: [
            Flexible(
              flex: 1,
              child: RefreshIndicator(
                onRefresh: refresh,
                child: ListView.separated(
                  itemCount: categories.length,
                  itemBuilder: (context, index) =>
                      buildItem(context, index, dataAccessProvider),
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
    });
  }

  Widget buildItem(context, index, DataAccessProvider dataAccessProvider) {
    var categories = dataAccessProvider.categories;

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
          style: const TextStyle(fontSize: 12),
        ),
        iconColor: categories[index].color,
      ),
      onDismissed: (direction) =>
          deleteCategory(direction, index, context, dataAccessProvider),
    );
  }

  Future<Null> refresh() async {
    await Future.delayed(Duration(seconds: 1));

    setState(() {});

    return null;
  }

  void openCreateModal(
      BuildContext context, DataAccessProvider dataAccessProvider) {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          titlePadding: const EdgeInsets.all(0),
          contentPadding: const EdgeInsets.all(0),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(25)),
          ),
          content: Column(
            children: [
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(width: 5),
                  Flexible(
                    flex: 3,
                    child: TextField(
                      onChanged: (value) {
                        setState(() {
                          currentTaskName = value;
                        });
                      },
                      onSubmitted: (value) {
                        createCategory(context, dataAccessProvider);
                      },
                      style: const TextStyle(
                        fontSize: 18,
                      ),
                      decoration: InputDecoration(
                        prefixIcon:
                            Icon(currentIcon, color: currentColor, size: 20),
                        fillColor: currentColor,
                        hintText:
                            'Digite o nome da categoria a ser adicionada!',
                        border: const UnderlineInputBorder(
                          borderSide: BorderSide(
                            width: 4,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  OutlinedButton.icon(
                    style:
                        OutlinedButton.styleFrom(backgroundColor: currentColor),
                    label: Text('COR',
                        style: TextStyle(
                            fontSize: 15,
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
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 15),
                  OutlinedButton.icon(
                    style:
                        OutlinedButton.styleFrom(backgroundColor: currentColor),
                    label: Text('TAG',
                        style: TextStyle(
                            fontSize: 15,
                            color: currentColor.computeLuminance() > 0.5
                                ? Colors.black
                                : Colors.white)),
                    onPressed: () {},
                    icon: Icon(
                      Icons.tag,
                      color: currentColor.computeLuminance() > 0.5
                          ? Colors.black
                          : Colors.white,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 5),
                ],
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Ink(
                    decoration: const ShapeDecoration(
                      color: Colors.blue,
                      shape: CircleBorder(),
                    ),
                    child: IconButton(
                      iconSize: 20,
                      color: Colors.white,
                      onPressed: () {
                        createCategory(context, dataAccessProvider);
                      },
                      icon: const Icon(Icons.add),
                    ),
                  ),
                  const SizedBox(width: 10),
                ],
              ),
            ],
          ),
        );
      },
    );
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
          ),
        );
      },
    );
    return category;
  }

  void createCategory(context, DataAccessProvider dataAccessProvider) {
    var categories = dataAccessProvider.categories;

    categories.add(TaskCategory(currentTaskName, currentColor, currentIcon));

    dataAccessProvider.notify();

    // validar valores
    // validar se já não existe uma categoria assim

    // criar categoria
    final snackBar = SnackBar(
      content: Text("Categoria \"$currentTaskName\" adicionada!"),
      duration: const Duration(seconds: 1),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void deleteCategory(direction, int index, BuildContext context,
      DataAccessProvider dataAccessProvider) {
    var categories = dataAccessProvider.categories;

    final TaskCategory lastRemovedCategory = categories[index];

    categories.removeAt(index);

    dataAccessProvider.notify();

    final snackBar = SnackBar(
      content: Text("Categoria \"${lastRemovedCategory.name}\" removida!"),
      duration: const Duration(seconds: 1),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
