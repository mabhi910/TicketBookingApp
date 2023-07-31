import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ticket_booking/presentation/views/booking_screen.dart';

import 'database/database.dart';
AppDatabase? database;
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  database = await $FloorAppDatabase.databaseBuilder('book_database.db').build();
  print(database);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BookingScreen(),
    );
  }
}

