import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'home_page.dart';

Future main() async{
  WidgetsFlutterBinding.ensureInitialized();
  if(kIsWeb){
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyDulhYGlBWg-MfieswmMt2kDLtPh0oS6Hk",
            appId: "1:676472388183:web:ee7d2e6fb3aee5266a0112",
            messagingSenderId: "676472388183",
            projectId:"crudkokonoteapp",
        ));
  }
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
      ),
      home: HomePage(),
    );
  }
}
