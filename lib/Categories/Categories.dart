import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CategoriesRoute extends StatefulWidget {
  const CategoriesRoute({super.key});

  @override
  State<CategoriesRoute> createState() => _CategoriesRouteState();
}

class _CategoriesRouteState extends State<CategoriesRoute> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Categorias'),
      ),
      body: Container(),
    );
  }
}
