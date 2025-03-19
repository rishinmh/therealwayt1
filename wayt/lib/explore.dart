import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ExplorePage extends StatefulWidget {
  @override
  _ExplorePageState createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  late GoogleMapController mapController;

  static final LatLng _center = const LatLng(
    43.65107,
    -79.347015,
  ); // Toronto Coordinates

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Explore')),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Image.network(
                  'https://your_image_url_here.jpg', // Replace with your image URL
                  width: double.infinity,
                  height: 250,
                  fit: BoxFit.cover,
                ),
                Container(
                  padding: EdgeInsets.all(16.0),
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    "Toronto, Canada\n12.5 km",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            Container(
              height: 300,
              child: GoogleMap(
                onMapCreated: (GoogleMapController controller) {
                  mapController = controller;
                },
                initialCameraPosition: CameraPosition(
                  target: _center,
                  zoom: 10,
                ),
                markers: {
                  Marker(
                    markerId: MarkerId('your_location'),
                    position: _center,
                    infoWindow: InfoWindow(title: 'Your Location'),
                  ),
                  Marker(
                    markerId: MarkerId('retre_inn'),
                    position: LatLng(43.65107, -79.347015),
                    infoWindow: InfoWindow(title: 'Retre Inn'),
                  ),
                  Marker(
                    markerId: MarkerId('new_york'),
                    position: LatLng(40.7128, -74.0060),
                    infoWindow: InfoWindow(title: 'New York'),
                  ),
                  Marker(
                    markerId: MarkerId('russia'),
                    position: LatLng(55.7558, 37.6173),
                    infoWindow: InfoWindow(title: 'Russia'),
                  ),
                },
              ),
            ),
            ElevatedButton(
              onPressed: () {
                // Add navigation to ExplorePage
              },
              child: Text('Start'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 1, 19, 35),
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
