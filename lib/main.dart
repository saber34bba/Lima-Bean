import 'package:flutter/material.dart';
import 'package:limabean/home_view.dart';
import 'package:limabean/utils/home_presenter.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => HomePresenter(),
        ),
      ],
      child: MaterialApp(
          title: 'Lima Bean',
          theme: ThemeData(
            primarySwatch: Colors.green,
          ),
          home: HomeView()),
    );
  }
}
