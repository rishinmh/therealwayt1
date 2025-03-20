import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:uuid/uuid.dart';
import 'package:google_places_flutter/google_places_flutter.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({super.key});

  @override
  _ExplorePageState createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  late GoogleMapController _mapController;
  Position? _currentPosition;
  Marker? _userMarker;
  final LatLng _toronto = LatLng(43.65107, -79.347015);
  final Completer<GoogleMapController> _controller = Completer();

  // Map Marker Set
  final Set<Marker> _markers = {};

  // Search Controller
  final TextEditingController _searchController = TextEditingController();
  final String _sessionToken = Uuid().v4();

  @override
  void initState() {
    super.initState();
    _getUserLocation();
  }

  // Get User's Current Location
  Future<void> _getUserLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) return;

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.deniedForever) return;
    }

    Position position = await Geolocator.getCurrentPosition();
    setState(() {
      _currentPosition = position;
      _userMarker = Marker(
        markerId: MarkerId('user_location'),
        position: LatLng(position.latitude, position.longitude),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
        infoWindow: InfoWindow(title: 'You are here'),
      );
      _markers.add(_userMarker!);
    });

    _mapController.animateCamera(
      CameraUpdate.newLatLngZoom(
        LatLng(position.latitude, position.longitude),
        12,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Explore',
          style: poppinsStyle(22, FontWeight.w700, Colors.white),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {},
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications_none, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),

      // 🌍 Google Map
      body: Stack(
        children: [
          // 📍 Fullscreen Google Map
          Positioned.fill(
            child: GoogleMap(
              onMapCreated: (controller) {
                _controller.complete(controller);
                _mapController = controller;
              },
              initialCameraPosition: CameraPosition(target: _toronto, zoom: 5),
              markers: _markers,
              zoomControlsEnabled: false,
              myLocationEnabled: true,
              myLocationButtonEnabled: false,
              mapType: MapType.terrain,
            ),
          ),

          // 📌 Search Bar Overlay
          Positioned(
            top: 100,
            left: 20,
            right: 20,
            child: Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.9),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 8)],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.search, color: Colors.black54),
                      hintText: "Search Places...",
                      border: InputBorder.none,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // 🚀 Floating "Start" Button
          Positioned(
            bottom: 40,
            left: 20,
            right: 20,
            child: ElevatedButton.icon(
              onPressed: () {},
              icon: Icon(
                FontAwesomeIcons.planeDeparture,
                color: Colors.white,
                size: 18,
              ),
              label: Text(
                "Start",
                style: poppinsStyle(18, FontWeight.w600, Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue.shade900,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 12),
              ),
            ),
          ),
        ],
      ),

      // 📌 Bottom Navigation Bar
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.map), label: 'Explore'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
        onTap: (index) {
          // Handle navigation
        },
      ),
    );
  }
}

// 🎨 Poppins Font Helper
TextStyle poppinsStyle(double size, FontWeight weight, Color color) {
  return TextStyle(
    fontFamily: 'Poppins',
    fontSize: size,
    fontWeight: weight,
    color: color,
  );
}
