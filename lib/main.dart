import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

import 'services/auth_service.dart';
import 'services/firestore_service.dart';
import 'screens/auth_screen.dart';
import 'screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
  options: const FirebaseOptions(
    apiKey: "AIzaSyCJ7Szw86tCKQCsrunD6lGp6a__315bPnc",
    authDomain: "notes-app-de1ce.firebaseapp.com",
    projectId: "notes-app-de1ce",
    storageBucket: "notes-app-de1ce",
    messagingSenderId: "749896395037",
    appId: "1:749896395037:android:756c1e4876c7a6ce73d9f4",
  ),
);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext ctx) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthService()),
        Provider(create: (_) => FirestoreService()),
      ],
      child: Consumer<AuthService>(
        builder: (_, auth, __) {
          return MaterialApp(
            title: 'Notes App',
            theme: ThemeData(primarySwatch: Colors.indigo),
            debugShowCheckedModeBanner: false,
            home: auth.currentUser != null ? HomeScreen() : AuthScreen(),
          );
        },
      ),
    );
  }
}