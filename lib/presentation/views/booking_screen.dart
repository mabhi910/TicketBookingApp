import 'package:flutter/material.dart';
import 'package:ticket_booking/main.dart';
import 'package:ticket_booking/presentation/views/seat_display_screen.dart';

import '../../database/booking_dao/booking_database.dart';

class BookingScreen extends StatefulWidget {
  const BookingScreen({super.key});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  List<Booking?> book = [];

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    book = await database?.bookingDao.getBooking() ?? [];
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:book.isNotEmpty
          ? ListView.builder(
              itemCount: book.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.all(10),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      border: Border.all(
                    color: Colors.black,
                    width: 1,
                  )),
                  child: Row(
                    children: [

                      Expanded(child: Text('Email: ${book[index]?.email}')),
                      const SizedBox(
                        width: 20,
                      ),
                      Text('Seat No. ${book[index]?.seatId}'),
                      const SizedBox(
                        width: 20,
                      ),
                      Text('Booking on ${book[index]?.createdAt}'),
                    ],
                  ),
                );
              })
          : const Center(
              child: Text('No previous booking found!'),
            ),
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            List<int?> list = [];
            for (var i in book) {
              list.add(int.parse(i!.seatId!));
            }
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => SeatDisplayScreen(
                          totalSeat: 30,
                          booked: list,
                        ))).then((value) => getData());
          }),
    );
  }
}
