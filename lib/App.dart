import 'package:flutter/material.dart';
import 'package:pos_scanner/scoped_model/main.dart';
import 'package:pos_scanner/views/pages/home_page.dart';
import 'package:scoped_model/scoped_model.dart';

class App extends StatelessWidget {
  // This widget is the root of your application.
  final MainModel _model = MainModel();
  @override
  Widget build(BuildContext context) {
    return ScopedModel<MainModel>(
      child: MaterialApp(
        title: 'POS SCANNER',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: HomePage(),
      ),
      model: _model,
    );
  }
}
