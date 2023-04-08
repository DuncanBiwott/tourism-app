import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tourism/constants/constants.dart';

import '../services/reservation.dart';

class AddHotelReservationScreen extends StatefulWidget {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;

  const AddHotelReservationScreen(
      {super.key, required this.auth, required this.firestore});
  @override
  _AddHotelReservationScreenState createState() =>
      _AddHotelReservationScreenState();
}

class _AddHotelReservationScreenState extends State<AddHotelReservationScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _hotelNameController = TextEditingController();
  final TextEditingController _roomTypeController = TextEditingController();
  final TextEditingController _numGuestsController = TextEditingController();
  DateTime _checkInDate = DateTime.now();
  DateTime _checkOutDate = DateTime.now();
  final reservation = Reservation();

  List<String> _hotels = [
    'Atana Musandam Resort',
    'Starry Domes Desert Camp',
    'Barcelo Mussanah Resort',
    'Sama al Wasil Desert Camp',
    'Sur Grand Hotel',
    'Sifawy Boutique Hotel',
    'Sur Plaza Hotel',
    'Wadi Shab Guest House'

  ];
  String _selectedHotel = 'Atana Musandam Resort';

  Future<void> _showConfirmationDialog(String hotelName, DateTime checkInDate, DateTime checkOutDate) async {
  final confirmed = await showDialog<bool>(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Confirm Reservation'),
        content: Text('Are you sure you want to save the reservation for $hotelName?'),
        actions: [
          TextButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(primary2),
              foregroundColor: MaterialStateProperty.all(Colors.white),
            ),
            onPressed: () {
              Navigator.pop(context, true);
            },
            child: const Text('Yes'),
          ),
          TextButton(
            style: ButtonStyle(
             
              foregroundColor: MaterialStateProperty.all(primary),
            ),
            onPressed: () {
              Navigator.pop(context, false);
            },
            child: const Text('No'),
          ),
        ],
      );
    },
  );

  if (confirmed ?? false) {
    reservation.addHotelReservation(hotelName, checkInDate,checkOutDate);
    Navigator.pop(context);
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Hotel Reservation'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    labelText: 'Hotel Name',
                  ),
                  value: _selectedHotel,
                  items: _hotels
                      .map((hotel) =>
                          DropdownMenuItem(value: hotel, child: Text(hotel)))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedHotel = value!;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select a hotel';
                    }
                    return null;
                  },
                ),
                
                SizedBox(height: 16.0),
                Text(
                    'Check-in Date: ${DateFormat('MM/dd/yyyy').format(_checkInDate)}'),
                ElevatedButton(
                  style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(primary2),
                              ),
                  onPressed: () async {
                    final pickedDate = await showDatePicker(
                      context: context,
                      initialDate: _checkInDate,
                      firstDate: DateTime.now(),
                      lastDate: DateTime.now().add(Duration(days: 365)),
                    );
                    if (pickedDate != null) {
                      setState(() {
                        _checkInDate = pickedDate;
                      });
                    }
                  },
                  child: const Text('Select Check-in Date'),
                ),
                SizedBox(height: 16.0),
                Text(
                    'Check-out Date: ${DateFormat('MM/dd/yyyy').format(_checkOutDate)}'),
                ElevatedButton(
                  style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(primary2),
                              ),
                  onPressed: () async {
                    final pickedDate = await showDatePicker(
                      context: context,
                      initialDate: _checkOutDate,
                      firstDate: DateTime.now(),
                      lastDate: DateTime.now().add(Duration(days: 365)),
                    );
                    if (pickedDate != null) {
                      setState(() {
                        _checkOutDate = pickedDate;
                      });
                    }
                  },
                  child: Text('Select Check-out Date'),
                ),
                const SizedBox(height: 16.0),
                ElevatedButton(
                  style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(primary2),
                              ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      final hotelName = _selectedHotel;
                      final checkIn=_checkInDate;
                      final checkout=_checkOutDate;
                      _showConfirmationDialog(hotelName,checkIn,checkout);
                      
                      
                    }
                  },
                  child: const Text('Add Reservation'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
