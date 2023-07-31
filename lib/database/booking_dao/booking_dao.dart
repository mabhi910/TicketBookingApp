 import 'package:floor/floor.dart';
import 'package:ticket_booking/database/booking_dao/booking_database.dart';

@dao
abstract class BookingDao{
  @insert
  Future<int> insertBooking(Booking booking);

  @Query('SELECT * FROM booking')
  Future<List<Booking?>> getBooking();
}