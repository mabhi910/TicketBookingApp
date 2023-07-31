import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ticket_booking/database/booking_dao/booking_database.dart';
import 'package:ticket_booking/main.dart';
import 'package:ticket_booking/presentation/widgets/custom_text_field.dart';
import 'package:ticket_booking/utils/common/common_methods.dart';

class SeatDisplayScreen extends StatefulWidget {
  final int totalSeat;
  final List<int?> booked;

  const SeatDisplayScreen(
      {super.key, required this.totalSeat, required this.booked});

  @override
  State<SeatDisplayScreen> createState() => _SeatDisplayScreenState();
}

class _SeatDisplayScreenState extends State<SeatDisplayScreen> {
  final emailController = TextEditingController();

  final selectedSeatController = TextEditingController();

  List<int> selected = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CustomTextField(
                  controller: emailController,
                  inputType: TextInputType.emailAddress,
                  titleText: 'Email'),
              CustomTextField(
                  controller: selectedSeatController,
                  inputType: TextInputType.number,
                  titleText: 'Selected Seat No.'),
              SizedBox(
                height: 20,
              ),
              Container(
                decoration: BoxDecoration(border: Border.all(width: 1)),
                height: 2,
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    showInfo(
                        Icons.crop_square_rounded, 'Available', Colors.grey),
                    showInfo(Icons.square_rounded, 'Booked', Colors.grey),
                    showInfo(
                      Icons.square_rounded,
                      'Selected',
                      Colors.green,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: Row(
                  children: [
                    Spacer(),
                    SvgPicture.asset('assets/images/wheel.svg'),
                  ],
                ),
              ),
              GridView.count(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  crossAxisCount: 4,
                  crossAxisSpacing: 10.0,
                  mainAxisSpacing: 10.0,
                  children: List.generate(widget.totalSeat, (index) {
                    return GestureDetector(
                        onTap: () {
                          if(!widget.booked.contains(index+1)){
                            if (selected.contains(index + 1)) {
                              selected.remove(index + 1);
                            } else {
                              selected.add(index + 1);
                            }
                            setState(() {});
                          }
                        },
                        child: SvgPicture.asset(
                          widget.booked.contains(index + 1)
                              ? 'assets/images/chair_filled.svg'
                              : 'assets/images/chair.svg',
                          color: widget.booked.contains(index)
                              ? Colors.grey
                              : selected.contains(index + 1)
                                  ? Colors.green
                                  : Colors.grey,
                        ));
                  }))
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.check),
          onPressed: () {
            if (emailController.text.isNotEmpty &&
                selectedSeatController.text.isNotEmpty) {
              if (int.parse(selectedSeatController.text) == selected.length) {
                for (var i in selected) {
                  database?.bookingDao.insertBooking(
                    Booking(
                      email: emailController.text,
                      createdAt: CommonMethods.dateFormatterTimes(
                          DateTime.now().toString()),
                      seatId: i.toString(),
                    ),
                  );
                }
                Navigator.pop(context);
              }else{
                CommonMethods.errorMsg('Selected seat count should be same');
              }
            }else if(emailController.text.isEmpty){
                CommonMethods.errorMsg('Please enter email id');
              }else{
                CommonMethods.errorMsg('Please enter selected seat count');
              }


          }),
    );
  }

  showInfo(IconData icon, String text, Color color) {
    return Row(
      children: [
        Icon(
          icon,
          color: color,
        ),
        SizedBox(width: 20),
        Text(text),
      ],
    );
  }
}
