import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';

class LocationPickerPage extends StatefulWidget {
  @override
  _LocationPickerPageState createState() => _LocationPickerPageState();
}

class _LocationPickerPageState extends State<LocationPickerPage> {
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
    // Listen for the single tap to select a location
    mapController.listenerMapSingleTapping.addListener(() {
      final selectedPoint = mapController.listenerMapSingleTapping.value;
      if (selectedPoint != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              "Selected Location: ${selectedPoint.latitude}, ${selectedPoint.longitude}",
            ),
          ),
        );
        
        // Navigator.pop(context,[selectedPoint.latitude,selectedPoint.longitude]);

        // If a location already exists, move the marker, otherwise add a new one
        if (currentLocation != null) {
          // Move the existing marker to the new location
          mapController.changeLocationMarker(
            oldLocation: currentLocation!,
            newLocation: selectedPoint,
            markerIcon: MarkerIcon(
              icon: Icon(
                Icons.location_on,
                color: Colors.red,
                size: 48,
              ),
            ),
          );
        } else {
          // Add a new marker at the selected location
          mapController.addMarker(
            selectedPoint,
            markerIcon: MarkerIcon(
              icon: Icon(
                Icons.location_on,
                color: Colors.red,
                size: 48,
              ),
            ),
          );
        }

        // Update the current location to the selected point
        currentLocation = selectedPoint;

        // ElevatedButton(onPressed: (){
        //   Navigator.pop(context,[selectedPoint.latitude,selectedPoint.longitude]);
        // }, child: Text('Select location'));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return 
      Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: Colors.black54),
            height: 400,
            width: 500,
            child: Column(
              children: [
                // Map Widget
                Expanded(
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
                      roadConfiguration: RoadOption(
                        roadColor: Colors.yellowAccent,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(
                        context,
                        [currentLocation!.latitude, currentLocation!.longitude],
                      );
                    },
                    child: Text('Select Location'),
                  ),
                ),
                
              ],
            ),
          ),
        ),
      );
    
  }

  @override
  void dispose() {
    mapController.dispose();
    super.dispose();
  }
}
