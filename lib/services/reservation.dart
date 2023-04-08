import 'package:cloud_firestore/cloud_firestore.dart';
class Reservation{

  

// Create a new instance of Firestore
final FirebaseFirestore firestore = FirebaseFirestore.instance;

// Add a new hotel reservation
Future<void> addHotelReservation(String hotelName,  DateTime checkInDate, DateTime checkOutDate) async {
  try {
    await firestore.collection('hotel_reservations').add({
      'hotel_name': hotelName,
      
      'check_in_date': checkInDate,
      'check_out_date': checkOutDate,
    });
  } catch (e) {
    print('Error adding hotel reservation: $e');
  }
}

// Add a new restaurant reservation
Future<void> addRestaurantReservation(String restaurantName, DateTime reservationDate) async {
  try {
    await firestore.collection('restaurant_reservations').add({
      'restaurant_name': restaurantName,
      'reservation_date': reservationDate,
      
    });
  } catch (e) {
    print('Error adding restaurant reservation: $e');
  }
}



}