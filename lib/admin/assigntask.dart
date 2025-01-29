import 'package:disastermanagement/admin/map.dart';
import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:geolocator/geolocator.dart';

class AssignTaskPage extends StatefulWidget {
  @override
  _AssignTaskPageState createState() => _AssignTaskPageState();
}

class _AssignTaskPageState extends State<AssignTaskPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _taskController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();

  String? _selectedSkill;
  String? _selectedVolunteer;
  bool _isFetchingLocation = false;
  final List<String> _selectedVolunteers = [];
   
  

  late MapController mapController;

  final List<String> _skills = ['Cooking', 'Teaching', 'Cleaning', 'Driving', 'First Aid'];
  final List<Map<String, dynamic>> _volunteers = [
    {'name': 'John Doe', 'skills': ['Cooking', 'Cleaning']},
    {'name': 'Jane Smith', 'skills': ['Teaching', 'First Aid']},
    {'name': 'Robert Brown', 'skills': ['Swimming', 'First Aid']},
    {'name': 'Emily Davis', 'skills': ['Cooking', 'Driving']},
    {'name': 'Michael Johnson', 'skills': ['First Aid', 'Cleaning']},
  ];

  List<String> _filteredVolunteers = [];

  @override
  void dispose() {
    _taskController.dispose();
    _locationController.dispose();
    mapController.dispose();
    super.dispose();
  }

  Future<void> _showVolunteerSelectionDialog() async {
  await showModalBottomSheet(
    context: context,
    isScrollControlled: true, // Ensure the modal adjusts height dynamically
    builder: (context) {
      return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return Container(height: 500,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Select Volunteers",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                    child: ListView(
                      children: _filteredVolunteers.map((volunteer) {
                        return CheckboxListTile(
                          title: Text(volunteer),
                          value: _selectedVolunteers.contains(volunteer),
                          onChanged: (bool? isChecked) {
                            setState(() {
                              if (isChecked == true) {
                                if (!_selectedVolunteers.contains(volunteer)) {
                                  _selectedVolunteers.add(volunteer);
                                }
                              } else {
                                _selectedVolunteers.remove(volunteer);
                              }
                            });
                          },
                        );
                      }).toList(),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF1D1F2A),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    child: const Text(
                      'Confirm',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    },
  );
}


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

  void _filterVolunteersBySkill(String skill) {
    setState(() {
      _selectedVolunteers.clear();
      _filteredVolunteers = _volunteers
          .where((volunteer) => volunteer['skills'].contains(skill))
          .map((volunteer) => volunteer['name'] as String)
          .toList();
      _selectedVolunteer = null;
    });
  }

  void _assignTask() {
    if (_formKey.currentState!.validate()) {
      final task = _taskController.text;
      final location = _locationController.text;
      

      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Assign task'),
          content: Text(
            "Confirm to assign task"
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancel'),
            ),
            ElevatedButton(onPressed: (){
              _formKey.currentState!.reset();
      setState(() {
        _selectedSkill = null;
        _filteredVolunteers = [];
        _selectedVolunteer = null;
        _locationController.clear();
      });
      Navigator.pop(context);
            }, child: Text("Confirm",style: TextStyle(color: Colors.white),))
          ],
        ),
      );

      
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Assign Task'),
      //   backgroundColor: const Color(0xFF1D1F2A),
      //   centerTitle: true,
      // ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 6,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: TextFormField(
                  controller: _taskController,
                  decoration: InputDecoration(
                    fillColor: Colors.transparent,
                    floatingLabelStyle: TextStyle(backgroundColor: Colors.transparent,color: Colors.black54,fontSize: 20),
                    labelStyle: TextStyle(color: Colors.black54,fontSize: 16),
                    labelText: 'Enter Task here...',
                    border: InputBorder.none,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a task';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 6,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        readOnly: true,
                        controller: _locationController,
                        decoration: InputDecoration(
                          fillColor: Colors.transparent,
                    floatingLabelStyle: TextStyle(backgroundColor: Colors.transparent,color: Colors.black54,fontSize: 20),
                    labelStyle: TextStyle(color: Colors.black54,fontSize: 16),
                          labelText: 'Location',
                          border: InputBorder.none,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter or fetch a location';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton.icon(
                      onPressed: _showLocationPickerDialog,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF1D1F2A),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      icon: const Icon(Icons.location_on, color: Colors.white),
                      label: const Text('Get Location', style: TextStyle(color: Colors.white)),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 6,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: DropdownButtonFormField<String>(
                  value: _selectedSkill,
                  decoration: const InputDecoration(
                    fillColor: Colors.transparent,
                    floatingLabelStyle: TextStyle(backgroundColor: Colors.transparent,color: Colors.black54,fontSize: 20),
                    labelStyle: TextStyle(color: Colors.black54,fontSize: 16),
                    labelText: 'Select Required Skill',
                    border: InputBorder.none,
                  ),
                  items: _skills.map((skill) {
                    return DropdownMenuItem(
                      value: skill,
                      child: Text(skill),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedSkill = value;
                      _filterVolunteersBySkill(value!);
                    });
                  },
                  validator: (value) {
                    if (value == null) {
                      return 'Please select a skill';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 16),
              InkWell(
                onTap: () async {
                  await _showVolunteerSelectionDialog();
                  setState(() {});
                },
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 6,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Text(
                    _selectedVolunteers.isEmpty
                        ? 'Select Volunteers'
                        : _selectedVolunteers.join(', '),
                    style: TextStyle(
                      fontSize: 16,
                      color: _selectedVolunteers.isEmpty ? Colors.grey : Colors.black,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: _assignTask,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1D1F2A),
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Assign Task',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
