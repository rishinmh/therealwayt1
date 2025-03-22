/*import 'package:flutter/material.dart';
import 'package:wayt/explore.dart';
import 'package:wayt/profile_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<String> locations = [
    "New York, USA",
    "Paris, France",
    "Tokyo, Japan",
    "Dubai, UAE",
    "Rome, Italy",
    "London, UK",
    "Sydney, Australia",
  ];
  String selectedLocation = "New York, USA";
  String searchQuery = "";

  final List<String> categories = [
    "All",
    "Water",
    "Sea",
    "Beaches",
    "Mountains",
    "Historic Places",
    "Parks",
    "Cultural Sites",
    "Nature",
    "Forests",
  ];
  String selectedCategory = "All";

  final Map<String, List<Map<String, String>>> touristSpots = {
    "New York, USA": [
      {
        "name": "Statue of Liberty",
        "price": "\$30 /Visit",
        "image":
            "https://upload.wikimedia.org/wikipedia/commons/a/a1/Statue_of_Liberty_7.jpg",
        "category": "Historic Places",
      },
      {
        "name": "Central Park",
        "price": "Free",
        "image":
            "https://upload.wikimedia.org/wikipedia/commons/e/ec/Central_Park_New_York_City_New_York_23.jpg",
        "category": "Parks",
      },
      {
        "name": "Times Square",
        "price": "Free",
        "image":
            "https://upload.wikimedia.org/wikipedia/commons/4/47/New_york_times_square-terabass.jpg",
        "category": "Cultural Sites",
      },
      {
        "name": "Brooklyn Bridge",
        "price": "Free",
        "image":
            "https://upload.wikimedia.org/wikipedia/commons/3/3e/Brooklyn_Bridge_Postdlf.jpg",
        "category": "Historic Places",
      },
    ],
    "Paris, France": [
      {
        "name": "Eiffel Tower",
        "price": "\$25 /Visit",
        "image":
            "https://upload.wikimedia.org/wikipedia/commons/a/a8/Tour_Eiffel_Wikimedia_Commons.jpg",
        "category": "Historic Places",
      },
      {
        "name": "Louvre Museum",
        "price": "\$15 /Visit",
        "image":
            "https://upload.wikimedia.org/wikipedia/commons/3/3a/Louvre_Museum_Wikimedia_Commons.jpg",
        "category": "Cultural Sites",
      },
      {
        "name": "Notre-Dame Cathedral",
        "price": "Free",
        "image":
            "https://upload.wikimedia.org/wikipedia/commons/6/6d/Notre-Dame_de_Paris.jpg",
        "category": "Historic Places",
      },
      {
        "name": "Champs-Élysées",
        "price": "Free",
        "image":
            "https://upload.wikimedia.org/wikipedia/commons/3/37/Champs-Élysées%2C_Paris.jpg",
        "category": "Cultural Sites",
      },
    ],
    "Tokyo, Japan": [
      {
        "name": "Mount Fuji",
        "price": "\$50 /Visit",
        "image":
            "https://upload.wikimedia.org/wikipedia/commons/1/12/Mount_Fuji_from_Misaka_Pass_2.jpg",
        "category": "Mountains",
      },
      {
        "name": "Shibuya Crossing",
        "price": "Free",
        "image":
            "https://upload.wikimedia.org/wikipedia/commons/7/79/Shibuya_Crossing_Wikimedia_Commons.jpg",
        "category": "Cultural Sites",
      },
      {
        "name": "Tokyo Tower",
        "price": "\$20 /Visit",
        "image":
            "https://upload.wikimedia.org/wikipedia/commons/e/e6/Tokyo_Tower_and_skyline.jpg",
        "category": "Historic Places",
      },
      {
        "name": "Senso-ji Temple",
        "price": "Free",
        "image":
            "https://upload.wikimedia.org/wikipedia/commons/0/00/Sens%C5%8D-ji_-_panoramio_%282%29.jpg",
        "category": "Historic Places",
      },
    ],
  };

  @override
  Widget build(BuildContext context) {
    final filteredSpots =
        touristSpots[selectedLocation]!
            .where(
              (spot) =>
                  (selectedCategory == "All" ||
                      spot["category"] == selectedCategory) &&
                  (searchQuery.isEmpty ||
                      spot["name"]!.toLowerCase().contains(
                        searchQuery.toLowerCase(),
                      )),
            )
            .toList();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: DropdownButton<String>(
          value: selectedLocation,
          dropdownColor: Colors.white,
          icon: const Icon(
            Icons.arrow_drop_down,
            color: Color.fromARGB(255, 1, 25, 60),
          ),
          style: const TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontFamily: 'Poppins',
          ),
          underline: Container(),
          items:
              locations.map((String location) {
                return DropdownMenuItem<String>(
                  value: location,
                  child: Text(
                    location,
                    style: const TextStyle(color: Colors.black),
                  ),
                );
              }).toList(),
          onChanged: (newLocation) {
            setState(() {
              selectedLocation = newLocation!;
            });
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search Bar
            TextField(
              decoration: InputDecoration(
                hintText: "Search destinations...",
                hintStyle: const TextStyle(fontFamily: 'Poppins', fontSize: 14),
                prefixIcon: const Icon(
                  Icons.search,
                  color: Color.fromARGB(255, 1, 25, 60),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey.withOpacity(0.1),
              ),
              style: const TextStyle(
                fontFamily: 'Poppins',
                fontSize: 14,
                color: Colors.black,
              ),
              onChanged: (value) {
                setState(() {
                  searchQuery = value;
                });
              },
            ),
            const SizedBox(height: 16),

            // Categories
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children:
                    categories.map((category) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: FilterChip(
                          label: Text(
                            category,
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 12,
                              color:
                                  selectedCategory == category
                                      ? Colors.white
                                      : Colors.black,
                            ),
                          ),
                          selected: selectedCategory == category,
                          onSelected: (selected) {
                            setState(() {
                              selectedCategory = category;
                            });
                          },
                          backgroundColor: Colors.grey.withOpacity(0.1),
                          selectedColor: const Color.fromARGB(255, 1, 25, 60),
                        ),
                      );
                    }).toList(),
              ),
            ),
            const SizedBox(height: 16),

            // Top Trips (Small Rectangle Image Boxes)
            const Text(
              "Top Trips",
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 8),
            SizedBox(
              height: 160,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: filteredSpots.length,
                itemBuilder: (context, index) {
                  final spot = filteredSpots[index];
                  return Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: _smallImageBox(spot["name"]!, spot["image"]!),
                  );
                },
              ),
            ),
            const SizedBox(height: 16),

            // Group Trips (Large Rectangle Cards)
            const Text(
              "Group Trips",
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: ListView.builder(
                itemCount: filteredSpots.length,
                itemBuilder: (context, index) {
                  final spot = filteredSpots[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: _groupTripCard(
                      spot["name"]!,
                      spot["price"]!,
                      spot["image"]!,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // Home Button
            IconButton(
              icon: const Icon(
                Icons.home_outlined,
                color: Color.fromARGB(255, 1, 25, 60),
                size: 28,
              ),
              onPressed: () {
                // Navigate to HomePage (or stay on the current page)
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const HomePage()),
                );
              },
            ),

            // Explore Button (Second Button)
            IconButton(
              icon: const Icon(
                Icons.search_outlined,
                color: Color.fromARGB(255, 1, 25, 60),
                size: 28,
              ),
              onPressed: () {
                // Navigate to ExplorePage
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ExplorePage()),
                );
              },
            ),

            // Profile Button
            IconButton(
              icon: const Icon(
                Icons.person_outline,
                color: Color.fromARGB(255, 1, 25, 60),
                size: 28,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfileScreen()),
                );
              },
            ),

            // Other Button
            IconButton(
              icon: const Icon(
                Icons.auto_awesome,
                color: Color.fromARGB(255, 1, 25, 60),
                size: 28,
              ),
              onPressed: () {
                // Add functionality for this button
              },
            ),
          ],
        ),
      ),
    );
  }

  // Small Rectangle Image Box for Top Trips
  Widget _smallImageBox(String name, String imageUrl) {
    return SizedBox(
      width: 120,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              imageUrl,
              height: 100,
              width: 120,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  height: 100,
                  width: 120,
                  color: Colors.grey.withOpacity(0.1),
                  child: const Icon(
                    Icons.broken_image,
                    color: Colors.grey,
                    size: 40,
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 8),
          Text(
            name,
            style: const TextStyle(
              fontFamily: 'Poppins',
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  // Large Rectangle Card for Group Trips
  Widget _groupTripCard(String name, String price, String imageUrl) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
            child: Image.network(
              imageUrl,
              height: 180,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  height: 180,
                  width: double.infinity,
                  color: Colors.grey.withOpacity(0.1),
                  child: const Icon(
                    Icons.broken_image,
                    color: Colors.grey,
                    size: 40,
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              name,
              style: const TextStyle(
                fontFamily: 'Poppins',
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              price,
              style: const TextStyle(
                fontFamily: 'Poppins',
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
*/
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'package:wayt/explore.dart';
import 'package:wayt/profile_screen.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

// API Configuration
final _GOOGLE_API_KEY = dotenv.env['GOOGLE_API_KEY'];
const String _TELEPORT_URL = 'https://api.teleport.org/api/urban_areas/';
const String _GEOCODING_URL = 'https://maps.googleapis.com/maps/api/geocode/json';
const String _PLACES_URL = 'https://maps.googleapis.com/maps/api/place/nearbysearch/json';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> locations = [];
  String selectedLocation = "";
  String searchQuery = "";
  List<dynamic> _places = [];
  bool _isLoading = true;
  String _errorMessage = '';
  List<String> categories = [
    "All",
    "natural",
    "beach",
    "historic",
    "museum",
    "park",
    "religious",
    "cultural",
    "entertainment"
  ];
  String selectedCategory = "All";
  late Connectivity _connectivity;

  @override
  void initState() {
    super.initState();
    _connectivity = Connectivity();
    _checkConnectivityAndFetch();
  }

  Future<void> _checkConnectivityAndFetch() async {
    var connectivityResult = await _connectivity.checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      setState(() {
        _errorMessage = 'No internet connection. Please connect to the internet.';
        _isLoading = false;
      });
      return;
    }
    _fetchCities();
  }

  Future<void> _fetchCities() async {
    try {
      final response = await http.get(Uri.parse(_TELEPORT_URL)).timeout(const Duration(seconds: 15));
      if (response.statusCode != 200) throw Exception('Failed to load cities');

      final data = json.decode(response.body);
      final cities = data['_links']['ua:item']
          .map<String>((item) => item['name'].toString())
          .toList();

      setState(() {
        locations = cities;
        selectedLocation = cities.isNotEmpty ? cities.first : "";
      });

      if (cities.isNotEmpty) _fetchPlaces();
    } on SocketException catch (e) {
      setState(() {
        _errorMessage = 'Network error: ${e.message}';
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'Failed to load cities: ${e.toString()}';
        _isLoading = false;
      });
    }
  }

  String _getGooglePlaceType(String category) {
    const typeMapping = {
      "All": "tourist_attraction",
      "natural": "natural_feature",
      "beach": "beach",
      "historic": "museum",
      "museum": "museum",
      "park": "park",
      "religious": "place_of_worship",
      "cultural": "museum",
      "entertainment": "amusement_park"
    };
    return typeMapping[category] ?? "tourist_attraction";
  }

  Future<void> _fetchPlaces() async {
    if (selectedLocation.isEmpty) return;

    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });

    try {
      // Geocode selected city using Google API
      final geocodeResponse = await http.get(Uri.parse(
        '$_GEOCODING_URL?address=$selectedLocation&key=$_GOOGLE_API_KEY',
      ));

      if (geocodeResponse.statusCode != 200) {
        throw Exception('Failed to geocode location');
      }

      final geoData = json.decode(geocodeResponse.body);
      if (geoData['results'].isEmpty) throw Exception('Location not found');

      final location = geoData['results'][0]['geometry']['location'];
      final lat = location['lat'];
      final lng = location['lng'];

      // Fetch places using Google Places API
      final placesResponse = await http.get(Uri.parse(
        '$_PLACES_URL?location=$lat,$lng'
            '&radius=5000'
            '&type=${_getGooglePlaceType(selectedCategory)}'
            '&key=$_GOOGLE_API_KEY',
      ));

      if (placesResponse.statusCode != 200) {
        throw Exception('Failed to load places');
      }

      final placesData = json.decode(placesResponse.body);
      setState(() {
        _places = placesData['results'];
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _errorMessage = 'Failed to load data: ${e.toString()}';
      });
    }
  }

  void _showPlaceDetails(Map<String, dynamic> place) {
    final geometry = place['geometry']['location'];
    final lat = geometry['lat'];
    final lng = geometry['lng'];

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PlaceDetailScreen(
          placeName: place['name'] ?? 'Unnamed Place',
          location: LatLng(lat, lng),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final filteredPlaces = _places.where((place) {
      return searchQuery.isEmpty ||
          place['name'].toString().toLowerCase().contains(
            searchQuery.toLowerCase(),
          );
    }).toList();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: locations.isEmpty
            ? const Text("Loading cities...")
            : DropdownButton<String>(
          value: selectedLocation,
          onChanged: (newValue) {
            setState(() {
              selectedLocation = newValue!;
              _fetchPlaces();
            });
          },
          items: locations.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(
                value,
                style: const TextStyle(
                  color: Colors.black,
                  fontFamily: 'Poppins',
                ),
              ),
            );
          }).toList(),
          underline: Container(),
          icon: const Icon(Icons.arrow_drop_down, color: Colors.black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: "Search destinations...",
                hintStyle: const TextStyle(fontFamily: 'Poppins', fontSize: 14),
                prefixIcon: const Icon(Icons.search, color: Colors.black),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey.withOpacity(0.1),
              ),
              onChanged: (value) => setState(() => searchQuery = value),
            ),
            const SizedBox(height: 16),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: categories.map((category) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: FilterChip(
                      label: Text(category),
                      selected: selectedCategory == category,
                      onSelected: (selected) {
                        setState(() {
                          selectedCategory = selected ? category : "All";
                          _fetchPlaces();
                        });
                      },
                      backgroundColor: Colors.grey.withOpacity(0.1),
                      selectedColor: const Color(0xFF0A2A50),
                      labelStyle: TextStyle(
                        color: selectedCategory == category
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 16),
            _errorMessage.isNotEmpty
                ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(_errorMessage),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: _checkConnectivityAndFetch,
                    child: const Text("Retry"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF0A2A50),
                    ),
                  ),
                ],
              ),
            )
                : Expanded(
              child: _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : ListView(
                children: [
                  const Text(
                    "Top Attractions",
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    height: 160,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: filteredPlaces.length,
                      itemBuilder: (context, index) {
                        final place = filteredPlaces[index];
                        return _PlaceCard(
                          place: place,
                          onTap: () => _showPlaceDetails(place),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    "All Places",
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  ...filteredPlaces.map((place) =>
                      _PlaceDetailsCard(
                        place: place,
                        onTap: () => _showPlaceDetails(place),
                      )),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.explore), label: 'Explore'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
        currentIndex: 0,
        selectedItemColor: const Color(0xFF0A2A50),
        onTap: (index) {
          if (index == 1) {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const ExplorePage()));
          } else if (index == 2) {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => ProfileScreen()));
          }
        },
      ),
    );
  }
}

class PlaceDetailScreen extends StatelessWidget {
  final String placeName;
  final LatLng location;

  const PlaceDetailScreen({
    super.key,
    required this.placeName,
    required this.location,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(placeName),
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: location,
          zoom: 14,
        ),
        markers: {
          Marker(
            markerId: MarkerId(placeName),
            position: location,
            infoWindow: InfoWindow(title: placeName),
          ),
        },
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
      ),
    );
  }
}

class _PlaceCard extends StatelessWidget {
  final dynamic place;
  final VoidCallback onTap;

  const _PlaceCard({required this.place, required this.onTap});

  String _getPhotoUrl() {
    if (place['photos']?.isNotEmpty ?? false) {
      final photoRef = place['photos'][0]['photo_reference'];
      return 'https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photoreference=$photoRef&key=$_GOOGLE_API_KEY';
    }
    return 'https://via.placeholder.com/200';
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 200,
        margin: const EdgeInsets.only(right: 10),
        child: Card(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(10)),
                  child: Image.network(
                    _getPhotoUrl(),
                    fit: BoxFit.cover,
                    width: double.infinity,
                    errorBuilder: (_, __, ___) => Container(
                      color: Colors.grey[200],
                      child: const Icon(Icons.broken_image),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      place['name'] ?? 'Unnamed Place',
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Poppins'),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      place['vicinity'] ?? '',
                      style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 12,
                          fontFamily: 'Poppins'),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PlaceDetailsCard extends StatelessWidget {
  final dynamic place;
  final VoidCallback onTap;

  const _PlaceDetailsCard({required this.place, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10)),
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  place['icon'] ?? 'https://via.placeholder.com/100',
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    color: Colors.grey[200],
                    child: const Icon(Icons.place),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      place['name'] ?? 'Unnamed Place',
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          fontFamily: 'Poppins'),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      place['types']?.join(', ') ?? '',
                      style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 14,
                          fontFamily: 'Poppins'),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      place['vicinity'] ?? '',
                      style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 12,
                          fontFamily: 'Poppins'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}