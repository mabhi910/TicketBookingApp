
import 'dart:async';

import 'package:floor/floor.dart';

import 'booking_dao/booking_dao.dart';
import 'booking_dao/booking_database.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

part 'database.g.dart';


@Database(version: 1, entities: [Booking])
abstract class AppDatabase extends FloorDatabase{
  BookingDao get bookingDao;
}