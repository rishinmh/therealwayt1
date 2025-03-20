import 'package:flutter/material.dart';
import 'package:wayt/explore.dart';

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
                // Navigate to ProfilePage (if you have one)
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => const ProfilePage()),
                // );
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
