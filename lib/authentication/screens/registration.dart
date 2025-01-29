import 'dart:io';
import 'package:disastermanagement/admin/map.dart';
import 'package:disastermanagement/authentication/screens/login.dart';
import 'package:disastermanagement/models/regModel.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';

class VolunteerRegistrationScreen extends StatefulWidget {
  const VolunteerRegistrationScreen({super.key,});

  @override
  _VolunteerRegistrationScreenState createState() =>
      _VolunteerRegistrationScreenState();
}

class _VolunteerRegistrationScreenState
    extends State<VolunteerRegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  String? fullName;
  String? email;
  String? phone;
  String? address;
  String? skills;
  String? availability;
  String? vehicleNumber;
  String? selectedOption; 
  String? password;
  bool isVolunteer = false;
  bool isAmbulance = false;
  String? location;

  final TextEditingController _locationController= TextEditingController();

  // final List<String> _availabilityOptions = [
  //   'Weekdays',
  //   'Weekends',
  //   'Anytime',
  //   'Specific Hours'
  // ];

    final List<String> _skillsOptions = [
    'First Aid',
    'Rescue Operations',
    'Teaching',
    'Counseling',
    'Swimming',
    'Logistics',
  ];
  final List<String> _selectedSkills = [];

  File? _imageFile;
  final TextEditingController _passwordController = TextEditingController();

  // Method to pick an image from the gallery
  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    try {
  if (pickedFile != null) {
    print('Picked image path: ${pickedFile.path}');
    setState(() {
      _imageFile = File(pickedFile.path);
    });
  } else {
    print('No image selected');
  }
} catch (e) {
  print('Error picking image: $e');
}

  }


  // Function to get the current location and assign latitude and longitude
  Future<void> _getCurrentLocation() async {
    // Check if location services are enabled
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled, handle accordingly (e.g., show a dialog)
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Location services are disabled.')),
      );
      return;
    }

    // Check and request permission for location access
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied || permission == LocationPermission.deniedForever) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse && permission != LocationPermission.always) {
        // Location permission is denied, handle accordingly (e.g., show a dialog)
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Location permission denied.')),
        );
        return;
      }
    }

    // Get the current position (latitude and longitude)
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

    // Update the _locationController with latitude and longitude
    setState(() {
      _locationController.text = 'Lat: ${position.latitude}, Lon: ${position.longitude}';
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFD9D9DB),
      appBar: AppBar(
        title: const Text('Registration'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 20),
              Center(
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [CircleAvatar(
                    radius: 60,
                    backgroundColor: Colors.grey[300],
                    backgroundImage: _imageFile != null
                        ? FileImage(_imageFile!)
                        : null,
                  ),
                  Positioned(
                    bottom: -12,
                    left: 0,
                    right: 0,
                    child: 
                    // IconButton(onPressed: (){_pickImage();}, icon: Icon(Icons.camera_alt_rounded))
                    GestureDetector(
                      onTap: () {
                        _pickImage();
                      },
                      child: CircleAvatar(backgroundColor: const Color(0xFF736A68),
                        radius: 15,
                        child: Icon(Icons.camera_alt_rounded,color: Colors.white,),))
                      )
                  ]
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Full Name',
                  border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(12))),
                  prefixIcon: Icon(Icons.person),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your full name';
                  }
                  return null;
                },
                onSaved: (value) => fullName = value,
              ),
              const SizedBox(height: 15),
              // Email
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(12))),
                  prefixIcon: Icon(Icons.email),
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                    return 'Please enter a valid email address';
                  }
                  return null;
                },
                onSaved: (value) => email = value,
              ),
              const SizedBox(height: 15),
              // Phone Number
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Phone Number',
                  border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(12))),
                  prefixIcon: Icon(Icons.phone),
                ),
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your phone number';
                  } else if (!RegExp(r'^\d{10}$').hasMatch(value)) {
                    return 'Please enter a valid 10-digit phone number';
                  }
                  return null;
                },
                onSaved: (value) => phone = value,
              ),
              const SizedBox(height: 15),
              // Address
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Address',
                  border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(12))),
                  prefixIcon: Icon(Icons.location_on),
                ),
                maxLines: 3,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your address';
                  }
                  return null;
                },
                onSaved: (value) => address = value,
              ),
              const SizedBox(height: 15),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.lock),
                ),
                obscureText: true,
                controller: _passwordController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  } else if (value.length < 6) {
                    return 'Password must be at least 6 characters';
                  }
                  return null;
                },
                onSaved: (value) => password = value,
              ),
              const SizedBox(height: 15),
              // Confirm Password
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Confirm Password',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.lock_outline),
                ),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please confirm your password';
                  } else if (value != _passwordController.text) {
                    return 'Passwords do not match';
                  }
                  return null;
                },
              ),
              SizedBox(height: 15,),
              
              Text("Would you like register as:",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
              RadioListTile<String>(
          value: 'none',
          groupValue: selectedOption,
          title: const Text("None"),
          onChanged: (String? value) {
            setState(() {
              selectedOption = value;
              _selectedSkills.clear();
              vehicleNumber = null;
            });
          },
        ),
        SizedBox(height: 5,),
              RadioListTile<String>(
          value: 'ambulance',
          groupValue: selectedOption,
          title: const Text("Register an Ambulance"),
          onChanged: (String? value) {
            setState(() {
              selectedOption = value;
              _selectedSkills.clear();
            });
          },
        ),
        if (selectedOption == 'ambulance')
          Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Vehicle Number',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.library_books_outlined),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your vehicle number';
                  }
                  return null;
                },
                onSaved: (value) => vehicleNumber = value,
              ),
               SizedBox(height: 15,),
              TextFormField(
                readOnly: true,
                  controller: _locationController,
                  decoration: InputDecoration(
                    // fillColor: const Color.fromARGB(255, 232, 226, 226),
                    hintText: 'Select location',
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.location_on, color: Colors.black54),
                      onPressed: _getCurrentLocation,
                    ),
                    border: OutlineInputBorder(
                      // borderRadius: BorderRadius.circular(10),
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
            ],
          ),

        const SizedBox(height: 15),

        RadioListTile<String>(
          value: 'volunteer',
          groupValue: selectedOption,
          title: const Text("Register as Volunteer"),
          onChanged: (String? value) {
            setState(() {
              selectedOption = value;
              vehicleNumber = null;
            });
          },
        ),
        if (selectedOption == 'volunteer') ...[
          const Text(
            'Skills:',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          ..._skillsOptions.map((skill) {
            return CheckboxListTile(
              title: Text(skill),
              value: _selectedSkills.contains(skill),
              onChanged: (bool? value) {
                setState(() {
                  if (value == true) {
                    _selectedSkills.add(skill);
                  } else {
                    _selectedSkills.remove(skill);
                  }
                });
              },
            );
          }).toList(),
        ],
              // Availability
              //  DropdownButtonFormField<String>(
              //   decoration: const InputDecoration(
              //     labelText: 'Availability',
              //     border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(12))),
              //     prefixIcon: Icon(Icons.calendar_today),
              //   ),
              //   value: availability,
              //   items: _availabilityOptions.map((option) {
              //     return DropdownMenuItem(
              //       value: option,
              //       child: Text(option),
              //     );
              //   }).toList(),
              //   onChanged: (value) {
              //     setState(() {
              //       availability = value;
              //     });
              //   },
              //   validator: (value) {
              //     if (value == null || value.isEmpty) {
              //       return 'Please select your availability';
              //     }
              //     return null;
              //   },
              // ),
             SizedBox(height: 20),
              ElevatedButton(
                 style: ElevatedButton.styleFrom(
                  fixedSize: Size(380, 50),
                  backgroundColor: const Color(0xFF1D1F2A)), 
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    final volunteerRegistration = RegistrationModel(
        fullName: fullName!,
        email: email!,
        phone: phone!,
        address: address!,
        password: password!,
        vehicleNumber: vehicleNumber,
        selectedSkills: _selectedSkills,
        registrationType: selectedOption!,
        profileImage: _imageFile,
      );
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen(),));
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Registration successful')),
      );
          }
            },
                child: Text("Register",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600,fontSize: 16),),
              ),
              SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Already have an account?"),
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen(),));
                    },
                    child: const Text('Login',style: TextStyle(color:  Color(0xFF1D1F2A),),),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
