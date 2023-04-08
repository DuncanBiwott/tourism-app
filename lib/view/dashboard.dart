import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tourism/constants/constants.dart';
import 'package:tourism/controller/Root/auth.dart';
import 'package:tourism/view/book_ride.dart';
import 'package:tourism/view/hotel_res.dart';
import 'package:tourism/view/restaurant_res.dart';
import 'package:url_launcher/url_launcher.dart';


class WelcomePage extends StatefulWidget {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;

  const WelcomePage({super.key, required this.auth, required this.firestore});
  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("Exploring the World",style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold),),
        elevation: 0,
        
        actions: [
          IconButton(onPressed: (() {
            Authenticate(auth: widget.auth).signOut();
            
          }), icon:Icon(FontAwesomeIcons.arrowRightToBracket,size: 16.0,) )
        ],
        
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 400,
              child: Stack(
                children: [
                  CarouselSlider(
                    items: [
                      Image.asset(
                        'assets/images/hotel2.jpeg',
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                      Image.asset(
                        'assets/images/restaurant.jpg',
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                      Image.asset(
                        'assets/images/flight.png',
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                    ],
                    options: CarouselOptions(
                      height: 400,
                      viewportFraction: 1.0,
                      enlargeCenterPage: false,
                      autoPlay: true,
                    ),
                  ),
                  Container(
                    height: 400,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.black.withOpacity(0.3),
                          Colors.black.withOpacity(0.3),
                          Colors.black.withOpacity(0.6),
                        ],
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Text(
                            'Welcome to our travel booking app',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Text(
                            'Book your hotel, restaurant and flight with ease',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Featured Hotels',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  HotelCard(auth: widget.auth, firestore: widget.firestore, amount:25, image: 'assets/images/hotel1.jpeg', name: 'Atana Musandam Resort' ,),
                   HotelCard(auth: widget.auth, firestore: widget.firestore,amount:25, image: 'assets/images/hotel1.jpeg', name: 'Starry Domes Desert Camp' ,),
                   HotelCard(auth: widget.auth, firestore: widget.firestore,amount:25, image: 'assets/images/hotel1.jpeg', name: 'Barcelo Mussanah Resort' ,),
                   HotelCard(auth: widget.auth, firestore: widget.firestore,amount:25, image: 'assets/images/hotel1.jpeg', name: 'Sama al Wasil Desert Camp' ,),
                   HotelCard(auth: widget.auth, firestore: widget.firestore, amount:25, image: 'assets/images/hotel1.jpeg', name: 'Sur Grand Hotel' ,),
                   HotelCard(auth: widget.auth, firestore: widget.firestore,amount:25, image: 'assets/images/hotel1.jpeg', name: 'Sifawy Boutique Hotel' ,),
                   HotelCard(auth: widget.auth, firestore: widget.firestore,amount:25, image: 'assets/images/hotel1.jpeg', name: 'Sur Plaza Hotel' ,),
                   HotelCard(auth: widget.auth, firestore: widget.firestore,amount:25, image: 'assets/images/hotel1.jpeg', name: 'Wadi Shab Guest House' ,),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Featured Restaurants',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  RestaurantCard(auth: widget.auth,firestore: widget.firestore,image: 'assets/images/hotel1.jpeg',restaurant:'Thousand Nights Camp' ,amount: 20.0,),
                  RestaurantCard(auth: widget.auth,firestore: widget.firestore,image: 'assets/images/hotel1.jpeg',restaurant:'Atana Khasab Hotel',amount: 20.0,),
                  RestaurantCard(auth: widget.auth,firestore: widget.firestore,image: 'assets/images/hotel1.jpeg',restaurant:'Radisson Blu Hotel Sohar',amount: 20.0,),
                  RestaurantCard(auth: widget.auth,firestore: widget.firestore,image: 'assets/images/hotel1.jpeg',restaurant:'Turtle Beach Resort',amount: 20.0,),
                  RestaurantCard(auth: widget.auth,firestore: widget.firestore,image: 'assets/images/hotel1.jpeg',restaurant:'Turtle Beach Resort',amount: 20.0,),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Featured Flights',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  FlightCard(auth: widget.auth,firestore: widget.firestore, amount: 25.0, image: 'assets/images/flight1.jpg', name: 'Muscat International Airport',),
                  FlightCard(auth: widget.auth,firestore: widget.firestore, image: 'assets/images/flight2.jpeg', name: 'Duqm Airport', amount: 26.0,),
                  FlightCard(auth: widget.auth,firestore: widget.firestore,image: 'assets/images/flight3.jpeg', name: 'Ras Hadd Airport',amount: 28.0,),
                  FlightCard(auth: widget.auth,firestore: widget.firestore,image: 'assets/images/flight4.jpg', name: 'Muscat International Airport',amount: 30.0,),
                  FlightCard(auth: widget.auth,firestore: widget.firestore, amount: 20.0, image: 'assets/images/flight1.jpg', name: 'Salalah International Airport',),
                  FlightCard(auth: widget.auth,firestore: widget.firestore, image: 'assets/images/flight2.jpeg', name: 'Suhar International Airprot', amount: 26.0,),
                  FlightCard(auth: widget.auth,firestore: widget.firestore,image: 'assets/images/flight3.jpeg', name: 'Marmul Airprot',amount: 25.0,),
                  FlightCard(auth: widget.auth,firestore: widget.firestore,image: 'assets/images/flight4.jpg', name: 'Khasab Airport',amount: 28.0,),
                  FlightCard(auth: widget.auth,firestore: widget.firestore,image: 'assets/images/flight5.jpg', name: 'Duqm International Airport',amount: 25.0,),
                  FlightCard(auth: widget.auth,firestore: widget.firestore,image: 'assets/images/flight4.jpg', name: 'Dibba Airport',amount: 25.0,),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Market Places for Shopping',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: const [
                ShoppingCard(amount: 20, image: 'assets/images/market1.jpg', location: 'Muscat City', market: 'Muscat City Centre',),
                ShoppingCard(amount: 20, image: 'assets/images/market2.jpg', location: 'Oman', market: 'Oman Avenues Mall',),
                ShoppingCard(amount: 20, image: 'assets/images/market3.jpeg', location: 'Salalah', market: 'Salalah Gardens Mall',),
                ShoppingCard(amount: 20, image: 'assets/images/market4.jpg', location: 'Mutrah', market: 'Mutrah Fish Market',),
                ShoppingCard(amount: 20, image: 'assets/images/market5.jpg', location: 'Muscat', market: 'Muscat Grand Mall',),
                ShoppingCard(amount: 20, image: 'assets/images/market6.jpg', location: 'Alia', market: 'Alia Gallery ',),
                ShoppingCard(amount: 20, image: 'assets/images/market7.jpg', location: 'Murtada', market: 'Murtada A.K. Trading Kadok',),
                ShoppingCard(amount: 20, image: 'assets/images/market3.jpeg', location: 'Markaz', market: 'Markaz Al Bahja ',),
                  
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class HotelCard extends StatefulWidget {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;
  final String image;
  final String name; 
  final double amount;

  const HotelCard({super.key, required this.auth, required this.firestore, required this.image, required this.name, required this.amount});

  @override
  State<HotelCard> createState() => _HotelCardState();
}

class _HotelCardState extends State<HotelCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        width: 250,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              widget.image,
              fit: BoxFit.cover,
              height: 150,
              width: double.infinity,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                widget.name,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      'Starting at OMR ${widget.amount}/night',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(primary2),
                              ),
                    onPressed: () {
                      Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AddHotelReservationScreen(auth: widget.auth, firestore: widget.firestore,)),
                          );
// Navigate to hotel reservation page
                    },
                    child: Text('Book Now'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RestaurantCard extends StatefulWidget {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;
  final String image;
  final String restaurant;
  final double amount;

  const RestaurantCard({super.key, required this.auth, required this.firestore, required this.image, required this.restaurant, required this.amount});
  @override
  State<RestaurantCard> createState() => _RestaurantCardState();
}

class _RestaurantCardState extends State<RestaurantCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        width: 250,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              widget.image,
              fit: BoxFit.cover,
              height: 150,
              width: double.infinity,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                widget.restaurant,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Starting at OMR ${widget.amount}',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(primary2),
                              ),
                    
                    onPressed: () {
                      Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>AddRestaurantReservationScreen(auth: widget.auth,firestore: widget.firestore,)),
                          );
// Navigate to restaurant reservation page
                    },
                    child: Text('Book Now'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FlightCard extends StatefulWidget {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;
  final String image;
  final String name; 
  final double amount;


  const FlightCard({super.key, required this.auth, required this.firestore, required this.image, required this.name, required this.amount});

  @override
  State<FlightCard> createState() => _FlightCardState();
}

class _FlightCardState extends State<FlightCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        width: 250,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              widget.image,
              fit: BoxFit.cover,
              height: 150,
              width: double.infinity,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                widget.name,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Starting at ${widget.amount}',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(primary2),
                              ),
                    onPressed: () {
                      Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => BookRidePage(auth: widget.auth, firestore: widget.firestore,)),
                          );
// Navigate to flight booking page
                    },
                    child: Text('Book Now'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ShoppingCard extends StatefulWidget {
  final String image;
  final String market;
  final String location;
  final double amount;

  const ShoppingCard({super.key, required this.image, required this.market, required this.location, required this.amount});
  @override
  State<ShoppingCard> createState() => _ShoppingCardState();

  

}

class _ShoppingCardState extends State<ShoppingCard> {

  Future<void>_launchURL(String url) async {
    final Uri uri=Uri(scheme: "https",host: url);
 
  if (!await launchUrl(uri,mode: LaunchMode.externalApplication,
   
  ))  {
    throw 'Could not launch $url';
  }
}
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        width: 250,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              widget.image,
              fit: BoxFit.cover,
              height: 150,
              width: double.infinity,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                widget.market,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
             Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(widget.location
                ,
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    'OMR ${widget.amount} per person',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: ElevatedButton(
                    style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(primary2),
                              ),
                    onPressed: () {
                      _launchURL("www.citycentremuscat.com");
                    },
                    child: Text('Visit'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
