import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:musix/firebase_options.dart';
import 'package:musix/logic/cubit/made_for_you/made_for_you_cubit.dart';
import 'package:musix/logic/cubit/playlist_cubit/playlist_cubit.dart';
import 'package:musix/logic/cubit/song_cubit/song_cubit.dart';
import 'package:musix/logic/cubit/usercubit/user_cubit.dart';
import 'package:musix/logic/provider/audio_provider.dart';
import 'package:musix/logic/provider/cpassword_visiblity.dart';
import 'package:musix/logic/provider/password_visiblity.dart';
import 'package:musix/presentation/screen/app.dart';
import 'package:musix/presentation/screen/music_slab.dart';
import 'package:provider/provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
        BlocProvider(create: (context) => UserCubit()),
        BlocProvider(create: (context) => SongCubit()),
        BlocProvider(create: (context) => MadeForYouCubit()),
        BlocProvider(create: (context) => PlaylistCubit()),
        ChangeNotifierProvider<AudioProvider>(
            create: (context) => AudioProvider()),
        ChangeNotifierProvider<PasswordVisiblityProvider>(
          create: (context) => PasswordVisiblityProvider(),
        ),
        ChangeNotifierProvider<CpasswordVisibility>(
          create: (context) => CpasswordVisibility(),
        )
      ],
      builder: (context, child) {
        return const MaterialApp(
          home: App(),
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}
