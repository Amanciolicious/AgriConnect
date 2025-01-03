import 'package:agri_app/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_fonts/google_fonts.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyDVauwpz4Z8hgMHyQr7viTls3kCw3RVsh0",
      authDomain: "agriconnectapp-8dbb4.firebaseapp.com",
      databaseURL:
          "https://agriconnectapp-8dbb4-default-rtdb.asia-southeast1.firebasedatabase.app",
      projectId: "agriconnectapp-8dbb4",
      storageBucket: "agriconnectapp-8dbb4.firebasestorage.app",
      messagingSenderId: "617332053598",
      appId: "1:617332053598:web:7b783a6665cd6ba62b86cf",
      measurementId: "G-PZ72ZZ439F",
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Agri-Connect',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
        textTheme: GoogleFonts.mulishTextTheme(),
      ),
      home: const LoginPage(), // Default home page
    );
  }
}
