import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class TaskDetailsPage extends StatelessWidget {
  final String? title;
  final String? location;

  const TaskDetailsPage({
    Key? key,
    required this.title,
    required this.location,
  }) : super(key: key);

  Future<void> _openGoogleMaps() async {
    final Uri googleMapsUri = Uri(
      scheme: 'https',
      host: 'www.google.com',
      path: '/maps/search/',
      queryParameters: {'q': location},
    );

    print("Google Maps URL: ${googleMapsUri.toString()}"); // Debug

    if (await canLaunchUrl(googleMapsUri)) {
      await launchUrl(googleMapsUri, mode: LaunchMode.externalApplication);
    } else {
      print("Could not launch Google Maps");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Task Details"),
        backgroundColor: const Color(0xFF1D1F2A), // Dark color for header
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Task Title
            Text(
              title!,
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 15),

            // Task Location
            Row(
              children: [
                const Icon(Icons.location_on, color: Colors.red),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    location!,
                    style: const TextStyle(fontSize: 18, color: Colors.black54),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),

            // Google Maps Button
            Center(
              child: ElevatedButton.icon(
                onPressed: _openGoogleMaps,
                icon: const Icon(Icons.map, color: Colors.white),
                label: const Text("Open in Google Maps", style: TextStyle(color: Colors.white)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1D1F2A), // Dark button color
                  padding: const EdgeInsets.symmetric(
                    vertical: 15,
                    horizontal: 30,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10), // Rounded corners
                  ),
                  elevation: 5,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
