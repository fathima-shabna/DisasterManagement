import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ReportResponsePage extends StatelessWidget {
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

  ReportResponsePage({Key? key}) : super(key: key);

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

class IncidentCard extends StatefulWidget {
  final Incident incident;

  const IncidentCard({Key? key, required this.incident}) : super(key: key);

  @override
  _IncidentCardState createState() => _IncidentCardState();
}

class _IncidentCardState extends State<IncidentCard> {
  bool _isReplying = false;
  TextEditingController _replyController = TextEditingController();
  String? _reply;

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
              widget.incident.title,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1D1F2A),
              ),
            ),
            const SizedBox(height: 8),

            // Incident Description
            Text(
              widget.incident.description,
              style: const TextStyle(fontSize: 16, color: Colors.black87),
            ),
            const SizedBox(height: 12),

            // Incident Date
            Row(
              children: [
                const Icon(Icons.calendar_today, size: 16, color: Colors.grey),
                const SizedBox(width: 6),
                Text(
                  '${widget.incident.incidentDate.toLocal()}'.split(' ')[0],
                  style: const TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Navigation Button
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton.icon(
                onPressed: () => _navigateToLocation(
                    widget.incident.latitude, widget.incident.longitude),
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

            // Reply Option
            const SizedBox(height: 16),
            if (_reply == null)
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _isReplying = !_isReplying;
                  });
                },
                child: Text(_isReplying ? 'Cancel Reply' : 'Reply',style: TextStyle(color: Colors.white),),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1D1F2A),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),

            // Reply Input and Display
            if (_isReplying)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 8),
                  TextField(
                    controller: _replyController,
                    decoration: const InputDecoration(
                       fillColor: const Color.fromARGB(255, 232, 226, 226),
                    // floatingLabelStyle: TextStyle(backgroundColor: Colors.transparent,color: Colors.black54,fontSize: 20),
                    // labelStyle: TextStyle(color: Colors.black54,fontSize: 16),
                      hintText: 'Enter your reply...',
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none
                      ),
                      contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    ),
                    maxLines: 3,
                  ),
                  const SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _reply = _replyController.text;
                        _isReplying = false;
                      });
                    },
                    child: const Text('Submit Reply',style: TextStyle(color: Colors.white)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                ],
              ),

            // Display Reply
            if (_reply != null)
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  'Reply: $_reply',
                  style: const TextStyle(fontSize: 16, color: Colors.green),
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
