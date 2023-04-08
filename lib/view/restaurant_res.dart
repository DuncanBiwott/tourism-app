import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tourism/constants/constants.dart';
import 'package:tourism/services/reservation.dart';


class AddRestaurantReservationScreen extends StatefulWidget {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;

  const AddRestaurantReservationScreen({super.key, required this.auth, required this.firestore});

  @override
  _AddRestaurantReservationScreenState createState() =>
      _AddRestaurantReservationScreenState();
}

class _AddRestaurantReservationScreenState
    extends State<AddRestaurantReservationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _restaurantNameController = TextEditingController();
  DateTime _reservationDate = DateTime.now();
  final _numPeopleController = TextEditingController();

  final reservation=Reservation();

  List<String> _restaurants = [
    'Thousand Nights Camp',
    'Atana Khasab Hotel',
    'Radisson Blu Hotel Sohar',
    'Six Senses Zighy Bay',
    'Turtle Beach Resort',
    

  ];
  String _selectedRestaurant = 'Thousand Nights Camp';

  Future<void> _showConfirmationDialog(String restaurantName, DateTime reservationDate) async {
  final confirmed = await showDialog<bool>(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Confirm Reservation'),
        content: Text('Are you sure you want to save the reservation for $restaurantName?'),
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
             
              foregroundColor: MaterialStateProperty.all(primary2),
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
    reservation.addRestaurantReservation(restaurantName,reservationDate);
    Navigator.pop(context);
  }
}

  @override
  void dispose() {
    _restaurantNameController.dispose();
    _numPeopleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
  appBar: AppBar(
    title: Text('Add Restaurant Reservation'),
  ),
  body: Padding(
    padding: const EdgeInsets.all(16.0),
    child: Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                labelText: 'Select a Restaurant',
                labelStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              value: _selectedRestaurant,
              items: _restaurants
                  .map((restaurant) =>
                      DropdownMenuItem(value: restaurant, child: Text(restaurant)))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  _selectedRestaurant = value!;
                });
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please select a restaurant';
                }
                return null;
              },
            ),
            const SizedBox(height: 16.0),
            InkWell(
              onTap: () async {
                final pickedDate = await showDatePicker(
                  context: context,
                  initialDate: _reservationDate,
                  firstDate: DateTime.now(),
                  lastDate: DateTime.now().add(Duration(days: 365)),
                );
                if (pickedDate != null) {
                  setState(() {
                    _reservationDate = pickedDate;
                  });
                }
              },
              child: Row(
                children: [
                   Icon(
                    FontAwesomeIcons.calendar,
                    color: primary2,
                  ),
                  const SizedBox(width: 8.0),
                  Text(
                    'Reservation Date: ${_reservationDate.day}/${_reservationDate.month}/${_reservationDate.year}',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 16.0),
            ElevatedButton(
              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(primary2),
                              ),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  final restaurantName =
                      _selectedRestaurant;
                      final reservation=_reservationDate;
                   _showConfirmationDialog(restaurantName,reservation);
                  
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
