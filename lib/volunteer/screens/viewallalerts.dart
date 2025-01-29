import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class EmergencyAlertsPage extends StatelessWidget {
  // Dummy alert data with latitude & longitude
  final List<Map<String, dynamic>> alerts = [
    {
      "message": "Fire outbreak reported near City Center!",
      "location": "Downtown, New York",
      "latitude": 40.7128,
      "longitude": -74.0060,
      "timestamp": "🕒 10:30 AM, Jan 29"
    },
    {
      "message": "Flood warning issued for coastal areas!",
      "location": "Riverside, LA",
      "latitude": 34.0522,
      "longitude": -118.2437,
      "timestamp": "🕒 8:15 AM, Jan 29"
    },
    {
      "message": "Severe thunderstorm approaching, stay indoors!",
      "location": "Green Valley, TX",
      "latitude": 32.7767,
      "longitude": -96.7970,
      "timestamp": "🕒 6:45 AM, Jan 29"
    },
  ];

  // Function to open location in Google Maps
  void _openMap(double latitude, double longitude) async {
    final Uri googleMapsUrl = Uri.parse("https://www.google.com/maps/search/?api=1&query=$latitude,$longitude");

    if (await canLaunchUrl(googleMapsUrl)) {
      await launchUrl(googleMapsUrl, mode: LaunchMode.externalApplication);
    } else {
      throw "Could not open the map.";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFD9D9DB),
      appBar: AppBar(
        title: Text("Emergency Alerts"),
        // backgroundColor: Colors.redAccent,
      ),
      body: alerts.isEmpty
          ? Center(
              child: Text(
                "No emergency alerts available.",
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            )
          : ListView.builder(
              itemCount: alerts.length,
              itemBuilder: (context, index) {
                final alert = alerts[index];

                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 3,
                  child: Padding(
                    padding: EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          alert["message"],
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        SizedBox(height: 5),
                        Text("📍 ${alert["location"]}", style: TextStyle(color: Colors.black87)),
                        SizedBox(height: 5),
                        Text(alert["timestamp"], style: TextStyle(color: Colors.black54)),
                        SizedBox(height: 10),
                        Align(
                          alignment: Alignment.centerRight,
                          child: ElevatedButton.icon(
                            onPressed: () => _openMap(alert["latitude"], alert["longitude"]),
                            icon: Icon(Icons.location_on,color: Colors.white,),
                            label: Text("View Location"),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF1D1F2A),
                              foregroundColor: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
