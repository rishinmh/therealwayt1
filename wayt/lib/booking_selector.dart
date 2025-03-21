import 'package:flutter/material.dart';

class BookingSelectorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Booking Selector'),
        backgroundColor: Colors.blue[900],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🌄 Destination Image
            ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Image.network(
                'https://example.com/image.jpg', // Replace with actual image URL
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Toronto, Canada',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5),
            const Text(
              'Arriving Date To US, California',
              style: TextStyle(fontSize: 16),
            ),
            const Text(
              '\$40',
              style: TextStyle(fontSize: 20, color: Colors.greenAccent),
            ),
            const SizedBox(height: 5),
            const Text(
              'November 10, 2023 - Wednesday',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 10),
            const Text('Time: 14:00', style: TextStyle(fontSize: 16)),
            const SizedBox(height: 20),

            // ✈ Flight Selector Widgets
            FlightSelector(
              date: "November 10, 2023",
              departure: "California",
              arrival: "Toronto",
            ),
            const SizedBox(height: 20),
            FlightSelector(
              date: "November 13, 2023",
              departure: "Toronto",
              arrival: "California",
            ),

            // 📌 Book Now Button
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Handle booking action
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue[900], // Dark navy blue
                  padding: const EdgeInsets.symmetric(
                    horizontal: 50,
                    vertical: 15,
                  ),
                  textStyle: const TextStyle(fontSize: 18),
                ),
                child: const Text('Book Now'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ✈ Flight Selector Card Widget
class FlightSelector extends StatelessWidget {
  final String date;
  final String departure;
  final String arrival;

  const FlightSelector({
    super.key,
    required this.date,
    required this.departure,
    required this.arrival,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.blue[800], // Darker card color
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'Flight on: $date',
              style: const TextStyle(color: Colors.white, fontSize: 18),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(departure, style: const TextStyle(color: Colors.white)),
                const Icon(Icons.flight_takeoff, color: Colors.white),
                Text(arrival, style: const TextStyle(color: Colors.white)),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text('14:00', style: TextStyle(color: Colors.white)),
                Text('19:00', style: TextStyle(color: Colors.white)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
