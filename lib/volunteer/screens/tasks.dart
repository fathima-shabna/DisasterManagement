import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AssignedTasksPage extends StatelessWidget {
  final List<Map<String, String>> assignedTasks = [
    {"title": "Distribute Food Kits", "location": "Community Center"},
    {"title": "Conduct First Aid Workshop", "location": "Local School"},
    {"title": "Assist in Evacuation", "location": "Flood Zone Area"},
  ];
  
    Future<void> _openGoogleMaps(int taskIndex) async {
      final location = assignedTasks[taskIndex]['location'];
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
  } // Replace with dynamic data

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Assigned Tasks"),
      ),
      body: ListView.builder(
        itemCount: assignedTasks.length,
        padding: const EdgeInsets.all(16.0),
        itemBuilder: (context, index) {
          final task = assignedTasks[index];
          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            elevation: 3,
            margin: const EdgeInsets.symmetric(vertical: 8.0),
            child: ListTile(
              leading: const Icon(Icons.task, color: Colors.green),
              title: Text(
                task["title"] ?? "No Title",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              subtitle: Text(task["location"] ?? "No Location"),
              trailing:ElevatedButton.icon(
                onPressed: ()=> _openGoogleMaps(index),
                icon: const Icon(Icons.map, color: Colors.white),
                label: const Text("Open in Google Maps", style: TextStyle(color: Colors.white)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1D1F2A), // Dark button color
                  padding: const EdgeInsets.symmetric(
                    vertical: 15,
                    horizontal: 15,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10), // Rounded corners
                  ),
                  elevation: 5,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
