//  Future<void> _getCurrentLocation() async {
  //   bool serviceEnabled;
  //   LocationPermission permission;

  //   // Test if location services are enabled.
  //   serviceEnabled = await Geolocator.isLocationServiceEnabled();
  //   if (!serviceEnabled) {
  //     setState(() {
  //       location = 'Location services are disabled.';
  //     });
  //     return;
  //   }

  //   permission = await Geolocator.checkPermission();
  //   if (permission == LocationPermission.denied) {
  //     // Request location permission if it's denied
  //     permission = await Geolocator.requestPermission();
  //     if (permission == LocationPermission.denied) {
  //       setState(() {
  //         location = 'Location permissions are denied';
  //       });
  //       return;
  //     }
  //   }

  //   if (permission == LocationPermission.deniedForever) {
  //     setState(() {
  //       location =
  //           'Location permissions are permanently denied. We cannot request permissions.';
  //     });
  //     return;
  //   }

  //   try {
  //     print("Attempting to get current position...");

  //     Position position = await Geolocator.getCurrentPosition(
  //         // desiredAccuracy: LocationAccuracy.high
  //         );
  //     print("Current position fetched: ${position.latitude}, ${position.longitude}");

  //     setState(() {
  //       _position = position;
  //        _locationController.text = "Lat: ${_position!.latitude}, Lon: ${_position!.longitude}";
  //     });

  //     // Get the address (place name) from latitude and longitude
  //     // List<Placemark> placemarks =
  //     //     await placemarkFromCoordinates(position.latitude, position.longitude);
      
  //     // print("Address fetched: $placemarks");

  //     // if (placemarks.isNotEmpty) {
  //     //   Placemark place = placemarks[0];
  //     //   setState(() {
  //     //     location =
  //     //         "${place.name}, ${place.locality}, ${place.administrativeArea}, ${place.country} (Lat: ${position.latitude}, Lon: ${position.longitude})";
  //     //   print(location);
  //     //   });
  //     // } else {
  //     //   setState(() {
  //     //     location = 'No address found for the given coordinates.';
  //     //   });
  //     // }
  //   } catch (e) {
  //     print("Error occurred in the try block: $e");
  //     setState(() {
  //       location = 'Error getting location: $e';
  //     });
  //   }
  // }

  // @override
  // void initState() {
  //   super.initState();
  //   // Automatically fetch the current location when the page loads
  //   _getCurrentLocation();
  //   _locationController.text = _position!.latitude.toString();
  // }


 // TextFormField(
              //   decoration: InputDecoration(
              //     suffixIcon: IconButton(
              //         onPressed: () {
              //           _getCurrentLocation();
              //         },
              //         icon: Icon(Icons.location_on,color: Colors.white,)),
              //     labelText: _position!=null ? 'Lat: ${_position!.latitude}, Lat: ${_position!.latitude}' : 'Location not available',
              //     // labelStyle: TextStyle(color: Colors.black54),
              //     // filled: true,
              //     // fillColor: Colors.white,
              //     border: OutlineInputBorder(
              //       // borderRadius: BorderRadius.circular(12),
              //       borderSide: BorderSide.none,
              //     ),
              //     contentPadding: const EdgeInsets.symmetric(horizontal: 20),
              //   ),
              //   validator: (value) {
              //     if (value == null || value.isEmpty) {
              //       return 'Please enter a location';
              //     }
              //     return null;
              //   },
              //   onSaved: (value) => location = value,
              // ),