import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:musix/firebase_options.dart';
import 'package:musix/logic/provider/audio_provider.dart';
import 'package:musix/presentation/screen/homepage.dart';
import 'package:musix/presentation/screen/songpage.dart';

import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AudioProvider>(
            create: (context) => AudioProvider())
      ],
      builder: (context, child) {
        return const MaterialApp(
          home: Homepage(),
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}
