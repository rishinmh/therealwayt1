import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Location: New York, USA",
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 1, 25, 60), // Dark blue
        actions: [
          IconButton(
            icon: Icon(Icons.notifications, color: Colors.white),
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
                hintText: "Search",
                hintStyle: TextStyle(fontFamily: 'Poppins', fontSize: 14),
                prefixIcon: Icon(Icons.search, color: Colors.grey),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.white.withOpacity(0.2),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 12,
                ),
              ),
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 14,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 16),

            // Categories
            Text(
              "Categories",
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _categoryChip("Lakes"),
                  const SizedBox(width: 8),
                  _categoryChip("Sea"),
                  const SizedBox(width: 8),
                  _categoryChip("Mountain"),
                  const SizedBox(width: 8),
                  _categoryChip("Forest"),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Top Trips
            Text(
              "Top Trips",
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8),
            _tripCard("RedFish Lake", "Idaho", 4.5, "\$40 /Visit"),
            const SizedBox(height: 16),
            _tripCard("Maligne Lake", "Canada", 4.5, "\$40 /Visit"),
            const SizedBox(height: 16),

            // Group Trips
            Text(
              "Group Trips",
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8),
            _groupTripCard("Mountain Trip", "Seelisburg", "Norway", 80),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color.fromARGB(255, 1, 25, 60), // Dark blue
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

  Widget _categoryChip(String title) {
    return Chip(
      label: Text(title, style: TextStyle(fontFamily: 'Poppins', fontSize: 14)),
      backgroundColor: Colors.white.withOpacity(0.2),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    );
  }

  Widget _tripCard(String title, String location, double rating, String price) {
    return Card(
      color: Colors.white.withOpacity(0.2),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Placeholder for image
            Container(
              height: 100,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Text(
              location,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 14,
                color: Colors.white70,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "⭐ $rating",
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 14,
                    color: Colors.white,
                  ),
                ),
                Text(
                  price,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 14,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _groupTripCard(
    String title,
    String location,
    String country,
    int progress,
  ) {
    return Card(
      color: Colors.white.withOpacity(0.2),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Placeholder for image
            Container(
              height: 100,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Text(
              location,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 14,
                color: Colors.white70,
              ),
            ),
            Text(
              country,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 14,
                color: Colors.white70,
              ),
            ),
            const SizedBox(height: 8),
            // Progress Bar
            LinearProgressIndicator(
              value: progress / 100,
              backgroundColor: Colors.white.withOpacity(0.2),
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}
