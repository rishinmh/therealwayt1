import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:uuid/uuid.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'booking_selector.dart'; // Import Booking Selector Page

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
  double _currentZoom = 12.0; // Initial Zoom Level

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
        _currentZoom,
      ),
    );
  }

  // Zoom In Function
  void _zoomIn() {
    setState(() {
      _currentZoom += 1;
      _mapController.animateCamera(CameraUpdate.zoomIn());
    });
  }

  // Zoom Out Function
  void _zoomOut() {
    setState(() {
      _currentZoom -= 1;
      _mapController.animateCamera(CameraUpdate.zoomOut());
    });
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
          icon: Icon(Icons.arrow_back, color: Colors.blue.shade900),
          onPressed: () {
            Navigator.pop(context);
          },
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
              initialCameraPosition: CameraPosition(
                target: _toronto,
                zoom: _currentZoom,
              ),
              markers: _markers,
              zoomControlsEnabled: false, // Disable default zoom controls
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

          // 🔍 Zoom Controls (Bottom Right)
          Positioned(
            bottom: 100,
            right: 20,
            child: Column(
              children: [
                FloatingActionButton(
                  heroTag: "zoomIn",
                  onPressed: _zoomIn,
                  backgroundColor: Colors.blue.shade900,
                  child: Icon(Icons.add, color: Colors.white),
                ),
                SizedBox(height: 10),
                FloatingActionButton(
                  heroTag: "zoomOut",
                  onPressed: _zoomOut,
                  backgroundColor: Colors.blue.shade900,
                  child: Icon(Icons.remove, color: Colors.white),
                ),
              ],
            ),
          ),

          // 🚀 Floating "Start" Button (Navigate to BookingSelectorPage)
          Positioned(
            bottom: 40,
            left: 20,
            right: 20,
            child: ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BookingSelectorPage(),
                  ),
                );
              },
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
        currentIndex: 1, // Make Explore selected by default
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.explore), label: 'Explore'),
          BottomNavigationBarItem(icon: Icon(Icons.map), label: 'Map'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
        onTap: (index) {
          // Handle navigation logic here
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
