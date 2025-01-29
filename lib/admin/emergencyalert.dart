import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';



class EmergencyAlertScreen extends StatefulWidget {
  @override
  _EmergencyAlertScreenState createState() => _EmergencyAlertScreenState();
}

class _EmergencyAlertScreenState extends State<EmergencyAlertScreen> {
  final String _emergencyMessage = "";
  late MapController mapController;
  GeoPoint? currentLocation;

  @override
  void initState() {
    super.initState();
    mapController = MapController(
      initPosition: GeoPoint(latitude: 11.2528089, longitude: 75.7702406),
    );
    _initializeListeners();
  }

  void _initializeListeners() {
    mapController.listenerMapSingleTapping.addListener(() {
      final selectedPoint = mapController.listenerMapSingleTapping.value;
      if (selectedPoint != null) {
        setState(() {
          currentLocation = selectedPoint;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              "Selected Location: ${selectedPoint.latitude}, ${selectedPoint.longitude}",
            ),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F0F0),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 6,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Container(
                    height: 300,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: OSMFlutter(
                      controller: mapController,
                      osmOption: OSMOption(
                        userTrackingOption: UserTrackingOption(
                          enableTracking: true,
                          unFollowUser: false,
                        ),
                        zoomOption: ZoomOption(
                          initZoom: 8,
                          minZoomLevel: 3,
                          maxZoomLevel: 19,
                          stepZoom: 1.0,
                        ),
                        userLocationMarker: UserLocationMaker(
                          personMarker: MarkerIcon(
                            icon: Icon(
                              Icons.location_history_rounded,
                              color: Colors.red,
                              size: 48,
                            ),
                          ),
                          directionArrowMarker: MarkerIcon(
                            icon: Icon(
                              Icons.double_arrow,
                              size: 48,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Icon(
                    Icons.warning_amber_rounded,
                    color: Colors.red,
                    size: 30,
                  ),
                  SizedBox(width: 10),
                  Text(
                    'Alert Message:',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 18, color: Colors.red),
                  ),
                ],
              ),
              SizedBox(height: 8),
              TextFormField(
                initialValue: _emergencyMessage,
                maxLines: 3,
                decoration: InputDecoration(fillColor: const Color.fromARGB(96, 232, 226, 226),
                  hintText: 'Enter alert message...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none
                  ),
                  contentPadding: EdgeInsets.all(12),
                ),
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 20),

   Center(
     child: ElevatedButton.icon(
       onPressed: () {
      if (currentLocation != null) {
        _sendAlert();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Please select a location")),
        );
      }
       },
       icon: Icon(
      Icons.warning_amber_rounded,color: Colors.white,
      size: 28, // Slightly larger icon for prominence
       ),
       label: Text(
      'Send Emergency Alert',
      style: TextStyle(
        fontSize: 18, // Larger text for visibility
        fontWeight: FontWeight.bold, // Bold text to make it stand out
        color: Colors.white,
      ),
       ),
       style: ElevatedButton.styleFrom(
      backgroundColor: Colors.red, // Red color for emergency
      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 20), // Increased padding
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16), // Slightly more rounded for emphasis
      ),
      shadowColor: Colors.black.withOpacity(0.6), // Adding shadow for depth
      elevation: 10, // Adding elevation for a floating effect
      textStyle: TextStyle(
        fontWeight: FontWeight.bold, // Bold text for emphasis
      ),
       ),
     ),
   ),

              SizedBox(height: 20),
              // Image.asset('assets/emergency_alert_image.png', height: 150), // Add your image
            ],
          ),
        ),
      ),
    );
  }

  void _sendAlert() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AlertConfirmationPage(
          location: currentLocation!,
          message: _emergencyMessage,
        ),
      ),
    );
  }
}

class AlertConfirmationPage extends StatelessWidget {
  final GeoPoint location;
  final String message;

  AlertConfirmationPage({required this.location, required this.message});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Emergency Alert Confirmation")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Location: ${location.latitude}, ${location.longitude}',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Text(
              'Alert Message:',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            SizedBox(height: 8),
            Text(message, style: TextStyle(fontSize: 16)),
            SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Alert sent successfully!")),
                );
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                backgroundColor: Colors.green, // Button color for confirmation
              ),
              child: Text('Confirm Alert'),
            ),
          ],
        ),
      ),
    );
  }
}
