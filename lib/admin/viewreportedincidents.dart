import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ReportedIncidentsPage extends StatelessWidget {
  final List<Incident> incidents = [
    Incident(
      title: "Fire Outbreak",
      description: "A fire broke out in the warehouse.",
      incidentDate: DateTime(2024, 1, 15),
      latitude: 37.7749,
      longitude: -122.4194,
    ),
    Incident(
      title: "Road Accident",
      description: "A major collision occurred on the highway.",
      incidentDate: DateTime(2024, 1, 10),
      latitude: 34.0522,
      longitude: -118.2437,
    ),
    Incident(
      title: "Flooding",
      description: "Severe flooding in the downtown area.",
      incidentDate: DateTime(2024, 1, 5),
      latitude: 40.7128,
      longitude: -74.0060,
    ),
  ];

  ReportedIncidentsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reported Incidents'),
        centerTitle: true,
        elevation: 0,
      ),
      body: SafeArea(
        child: ListView.builder(
          padding: const EdgeInsets.all(16.0),
          itemCount: incidents.length,
          itemBuilder: (context, index) {
            final incident = incidents[index];
            return IncidentCard(incident: incident);
          },
        ),
      ),
    );
  }
}

class IncidentCard extends StatelessWidget {
  final Incident incident;

  const IncidentCard({Key? key, required this.incident}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Incident Title
            Text(
              incident.title,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1D1F2A),
              ),
            ),
            const SizedBox(height: 8),

            // Incident Description
            Text(
              incident.description,
              style: const TextStyle(fontSize: 16, color: Colors.black87),
            ),
            const SizedBox(height: 12),

            // Incident Date
            Row(
              children: [
                const Icon(Icons.calendar_today, size: 16, color: Colors.grey),
                const SizedBox(width: 6),
                Text(
                  '${incident.incidentDate.toLocal()}'.split(' ')[0],
                  style: const TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Navigation Button
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton.icon(
                onPressed: () => _navigateToLocation(incident.latitude, incident.longitude),
                icon: const Icon(Icons.location_on, color: Colors.white),
                label: const Text('View on Map', style: TextStyle(color: Colors.white)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1D1F2A),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Function to navigate to location
  void _navigateToLocation(double latitude, double longitude) async {
    final url = 'https://www.google.com/maps?q=$latitude,$longitude';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}

// Incident Model
class Incident {
  final String title;
  final String description;
  final DateTime incidentDate;
  final double latitude;
  final double longitude;

  Incident({
    required this.title,
    required this.description,
    required this.incidentDate,
    required this.latitude,
    required this.longitude,
  });
}
