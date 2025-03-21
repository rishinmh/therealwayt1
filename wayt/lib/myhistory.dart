import 'package:flutter/material.dart';
import 'package:wayt/waythomepage.dart';
import 'explore.dart';

class MyHistoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'My History',
          style: TextStyle(
            color: Color.fromARGB(255, 1, 25, 60),
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 2,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Color.fromARGB(255, 1, 25, 60),
          ),
          onPressed: () {
            Navigator.pop(context); // Back button functionality
          },
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildHistoryItem(
            'Hampi, India',
            'https://example.com/hampi.jpg',
            'A UNESCO World Heritage Site known for its ancient ruins.',
          ),
          _buildHistoryItem(
            'Goa, India',
            'https://example.com/goa.jpg',
            'Famous for its stunning beaches and vibrant nightlife.',
          ),
          _buildHistoryItem(
            'Dandeli, India',
            'https://example.com/dandeli.jpg',
            'A paradise for adventure seekers and nature lovers.',
          ),
          _buildHistoryItem(
            'Dubai, UAE',
            'https://example.com/dubai.jpg',
            'A modern metropolis with iconic skyscrapers and luxury shopping.',
          ),
          _buildHistoryItem(
            'Muscat, Oman',
            'https://example.com/muscat.jpg',
            'A charming city blending traditional and contemporary elements.',
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Color.fromARGB(255, 1, 25, 60),
        unselectedItemColor: Colors.grey,
        currentIndex: 2, // Ensuring My History is highlighted
        onTap: (index) {
          if (index == 0) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
            );
          } else if (index == 1) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => ExplorePage(),
              ), // Ensure ExplorePage exists
            );
          }
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: 'History'),
        ],
      ),
    );
  }

  Widget _buildHistoryItem(String title, String imageUrl, String description) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                imageUrl,
                width: 80,
                height: 80,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: const TextStyle(fontSize: 14, color: Colors.grey),
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
