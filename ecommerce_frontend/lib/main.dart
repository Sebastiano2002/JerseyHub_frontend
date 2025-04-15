import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Homepage.dart';
import 'Provider/CartProvider.dart';
import 'Provider/LogProvider.dart';
import 'Provider/MagliaProvider.dart';
import 'model/support/SharedPreferenceManager.dart';

Future<void> main() async{
  await SharedPreferenceManager.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
              create: (_) => CartProvider()
          ),
          ChangeNotifierProvider(
              create: (_) => MagliaProvider()
          ),
          ChangeNotifierProvider(
              create: (_) => LogProvider()
          )
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: HomePage(),
          theme: ThemeData(primarySwatch: Colors.lightBlue),
        ));
  }
}