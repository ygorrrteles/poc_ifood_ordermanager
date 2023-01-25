import 'package:flutter/material.dart';
import 'package:poc_ifood_ordermanager/src/data/datasource/database_impl.dart';
import 'package:poc_ifood_ordermanager/src/pages/board/board_page.dart';

void main() async {
  await DataBaseImpl.instance.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gp database',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const BoardPage(),
    );
  }
}
