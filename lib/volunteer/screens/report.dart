import 'package:disastermanagement/admin/map.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class ReportIncidentPage extends StatefulWidget {
  const ReportIncidentPage({super.key});

  @override
  _ReportIncidentPageState createState() => _ReportIncidentPageState();
}

class _ReportIncidentPageState extends State<ReportIncidentPage> {
  final _formKey = GlobalKey<FormState>();
  String? incidentTitle;
  String? description;
  String? incidentType;
  DateTime? incidentDate;
  String? location;
  Position? _position;

  final TextEditingController _locationController= TextEditingController();
  final TextEditingController _dateController= TextEditingController();

   Future<void> _showLocationPickerDialog() async {
    // Open the LocationPickerPage in a dialog and wait for result
    final selectedLocation = await showDialog<List<double>>(
      context: context,
      builder: (context) {
        return AlertDialog(
          contentPadding: EdgeInsets.zero,
          content: SizedBox(
            height: 500,
            child: LocationPickerPage(),
          ),
        );
      },
    );

    // If a location was selected, update the _locationController
    if (selectedLocation != null) {
      final latitude = selectedLocation[0];
      final longitude = selectedLocation[1];
      setState(() {
        _locationController.text = 'Lat: $latitude, Lon: $longitude';
      });
    }
  }

 @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFD9D9DB),
      appBar: AppBar(
        title: const Text('Report Incident'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image or Logo at the top
              Center(
          child: ShaderMask(
            shaderCallback: (bounds) {
              return LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withOpacity(1.0),
                  Colors.black.withOpacity(0.1),
                ],
                stops: [0.0, 1.0],
              ).createShader(bounds);
            },
            blendMode: BlendMode.dstIn,
            child: ClipRRect(borderRadius: BorderRadius.circular(20),
              child: Image.asset(
                'assets/images/reportimage.png', // Replace with your own image path
                height: 150,
                width: MediaQuery.of(context).size.width, // Full screen width
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
              const SizedBox(height: 20),
              // Title and Subtitle
              Center(
                child: Text(
                  'Report an Incident',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 159, 116, 116),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Center(
                child: Text(
                  'Please fill out the form below to report an incident.',
                  style: TextStyle(
                    fontSize: 16,
                    color: Color.fromARGB(255, 187, 142, 142),
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 30),
      
              // Incident Title Field
              _buildCard(
                title: 'Incident Title',
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Enter incident title',
                     fillColor: const Color.fromARGB(255, 232, 226, 226),
                    border: OutlineInputBorder(borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a title';
                    }
                    return null;
                  },
                  onSaved: (value) => incidentTitle = value,
                ),
              ),
              const SizedBox(height: 20),
      
              // Incident Description Field
              _buildCard(
                title: 'Incident Description',
                child: TextFormField(
                  decoration: InputDecoration(
                    fillColor: const Color.fromARGB(255, 232, 226, 226),
                    hintText: 'Describe the incident',
                    border: OutlineInputBorder(borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    contentPadding: const EdgeInsets.all(10),
                  ),
                  maxLines: 5,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please provide a description';
                    }
                    return null;
                  },
                  onSaved: (value) => description = value,
                ),
              ),
              // const SizedBox(height: 20),
      
              // // Incident Type Field
              // _buildCard(
              //   title: 'Incident Type',
              //   child: DropdownButtonFormField<String>(
              //     decoration: InputDecoration(
              //       fillColor: const Color.fromARGB(255, 232, 226, 226),
              //       hintText: '',
              //       border: OutlineInputBorder(borderSide: BorderSide.none,
              //         borderRadius: BorderRadius.circular(10),
              //       ),
              //       contentPadding: const EdgeInsets.all(10),
              //     ),
              //     value: incidentType,
              //     items: ['Accident', 'Crime', 'Fire', 'Medical Emergency']
              //         .map(
              //           (incident) => DropdownMenuItem(
              //             value: incident,
              //             child: Text(incident),
              //           ),
              //         )
              //         .toList(),
              //     onChanged: (value) {
              //       setState(() {
              //         incidentType = value;
              //       });
              //     },
              //     validator: (value) {
              //       if (value == null || value.isEmpty) {
              //         return 'Please select an incident type';
              //       }
              //       return null;
              //     },
              //   ),
              // ),
              const SizedBox(height: 20),
      
              // Date Picker Field
              _buildCard(
                title: 'Date of Incident',
                child: TextFormField(
                  controller: _dateController,
                  readOnly: true,
                  decoration: InputDecoration(
                    fillColor: const Color.fromARGB(255, 232, 226, 226),
                    hintText: 'Pick the incident Date',
                    border: OutlineInputBorder(borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    contentPadding: const EdgeInsets.all(10),
                  ),
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1900),
                      lastDate: DateTime(2101),
                    );
                    if (pickedDate != null && pickedDate != incidentDate) {
                      setState(() {
                        incidentDate = pickedDate;
                        _dateController.text =
                            "${pickedDate.toLocal()}".split(' ')[0];
                      });
                    }
                  },
                  validator: (value) {
                    if (incidentDate == null) {
                      return 'Please select a date';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 20),
      
              // Location Field
              _buildCard(
                title: 'Location of Incident',
                child: TextFormField(
                  controller: _locationController,
                  decoration: InputDecoration(
                    fillColor: const Color.fromARGB(255, 232, 226, 226),
                    hintText: 'Select location',
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.location_on, color: Colors.black54),
                      onPressed: _showLocationPickerDialog,
                    ),
                    border: OutlineInputBorder(borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a location';
                    }
                    return null;
                  },
                  onSaved: (value) => location = value,
                ),
              ),
              const SizedBox(height: 30),
      
              // Submit Button
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                    backgroundColor: Color(0xFF1D1F2A),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Incident reported successfully'),
                        ),
                      );
                    }
                  },
                  child: const Text(
                    'Submit Report',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCard({required String title, required Widget child}) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 10),
            child,
          ],
        ),
      ),
    );
  }
}
