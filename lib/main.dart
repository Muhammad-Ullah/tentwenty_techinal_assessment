import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:tentwenty_techinical_assessment/constant/trending.dart';
import 'package:tentwenty_techinical_assessment/screens/dashboard.dart';
import 'package:tentwenty_techinical_assessment/screens/pay.dart';
import 'package:tentwenty_techinical_assessment/screens/tickets.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox('listedMovies');

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
  );

  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Dashboard(),
    );
  }
}
// Youtube: https://www.youtube.com/watch?v=h6hZkvrFIj0
// Vimeo: https://vimeo.com/282875052