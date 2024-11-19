import 'package:flutter/material.dart';
import 'package:ta_ppb_dota2/widget/loading.dart';
// Impor halaman loading

void main() {
  runApp(const Dota2App()); // Tambahkan 'const' di sini
}

class Dota2App extends StatelessWidget {
  const Dota2App({super.key}); // Tambahkan 'const' di sini

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dota 2 Heroes',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 4, 195, 10), // Tambahkan 'const' di sini
        ),
        useMaterial3: true,
      ),
      home: const LoadingPage(), // Tambahkan 'const' di sini
    );
  }
}
