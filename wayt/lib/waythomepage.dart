import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
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

  final Map<String, List<Map<String, String>>> touristSpots = {
    "New York, USA": [
      {
        "name": "Statue of Liberty",
        "price": "\$30 /Visit",
        "image":
            "https://upload.wikimedia.org/wikipedia/commons/a/a1/Statue_of_Liberty_7.jpg",
      },
      {
        "name": "Central Park",
        "price": "Free",
        "image":
            "https://upload.wikimedia.org/wikipedia/commons/e/ec/Central_Park_New_York_City_New_York_23.jpg",
      },
      {
        "name": "Times Square",
        "price": "Free",
        "image":
            "https://upload.wikimedia.org/wikipedia/commons/4/47/New_york_times_square-terabass.jpg",
      },
      {
        "name": "Brooklyn Bridge",
        "price": "Free",
        "image":
            "https://upload.wikimedia.org/wikipedia/commons/3/3e/Brooklyn_Bridge_Postdlf.jpg",
      },
    ],
    "Paris, France": [
      {
        "name": "Eiffel Tower",
        "price": "\$25 /Visit",
        "image":
            "https://upload.wikimedia.org/wikipedia/commons/a/a8/Tour_Eiffel_Wikimedia_Commons.jpg",
      },
      {
        "name": "Louvre Museum",
        "price": "\$15 /Visit",
        "image":
            "https://upload.wikimedia.org/wikipedia/commons/3/3a/Louvre_Museum_Wikimedia_Commons.jpg",
      },
      {
        "name": "Notre-Dame Cathedral",
        "price": "Free",
        "image":
            "https://upload.wikimedia.org/wikipedia/commons/6/6d/Notre-Dame_de_Paris.jpg",
      },
      {
        "name": "Champs-Élysées",
        "price": "Free",
        "image":
            "https://upload.wikimedia.org/wikipedia/commons/3/37/Champs-Élysées%2C_Paris.jpg",
      },
    ],
    "Tokyo, Japan": [
      {
        "name": "Mount Fuji",
        "price": "\$50 /Visit",
        "image":
            "https://upload.wikimedia.org/wikipedia/commons/1/12/Mount_Fuji_from_Misaka_Pass_2.jpg",
      },
      {
        "name": "Shibuya Crossing",
        "price": "Free",
        "image":
            "https://upload.wikimedia.org/wikipedia/commons/7/79/Shibuya_Crossing_Wikimedia_Commons.jpg",
      },
      {
        "name": "Tokyo Tower",
        "price": "\$20 /Visit",
        "image":
            "https://upload.wikimedia.org/wikipedia/commons/e/e6/Tokyo_Tower_and_skyline.jpg",
      },
      {
        "name": "Senso-ji Temple",
        "price": "Free",
        "image":
            "https://upload.wikimedia.org/wikipedia/commons/0/00/Sens%C5%8D-ji_-_panoramio_%282%29.jpg",
      },
    ],
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 1, 25, 60),
        title: DropdownButton<String>(
          value: selectedLocation,
          dropdownColor: Colors.white,
          icon: const Icon(Icons.arrow_drop_down, color: Colors.white),
          style: const TextStyle(
            color: Colors.white,
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
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications, color: Colors.white),
            onPressed: () {},
          ),
        ],
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
                prefixIcon: const Icon(Icons.search, color: Colors.grey),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.white.withOpacity(0.2),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 12,
                ),
              ),
              style: const TextStyle(
                fontFamily: 'Poppins',
                fontSize: 14,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 16),

            // Destination List (GridView)
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // Show 2 cards per row
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio:
                      0.75, // Adjusted aspect ratio for better fit
                ),
                itemCount: (touristSpots[selectedLocation] ?? []).length,
                itemBuilder: (context, index) {
                  final spot = touristSpots[selectedLocation]![index];
                  return _tripCard(
                    spot["name"]!,
                    spot["price"]!,
                    spot["image"]!,
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color.fromARGB(255, 1, 25, 60),
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white70,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: "Search"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );
  }

  // Updated trip card with fixed images
  Widget _tripCard(String title, String price, String imageUrl) {
    return Card(
      color: Colors.white.withOpacity(0.2),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
            child: Image.network(
              imageUrl,
              height: 140, // Adjusted for better layout
              width: double.infinity,
              fit: BoxFit.cover, // Ensures image fills the area properly
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  price,
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 14,
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
