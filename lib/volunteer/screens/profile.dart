
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  

  ProfilePage({
    super.key,
  });

  final String registrationType='';
  final List<String> _skillsOptions = [
    'First Aid',
    'Rescue Operations',
    'Teaching',
    'Counseling',
    'Swimming',
    'Logistics',
  ];
  // final List<String> _selectedSkills = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            // Profile Image
            CircleAvatar(
              radius: 60,
              backgroundColor: Colors.grey[300],
              backgroundImage: NetworkImage('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTITzJCC3jID-zzmtqa83SyG0dFuiv0q02EOg&s')
              //     regModel.profileImage != null ? FileImage(regModel.profileImage!) : null,
              // child: regModel.profileImage! == null
              //     ? const Icon(Icons.person, size: 60, color: Colors.white)
              //     : null,
            ),
            const SizedBox(height: 20),
            // Full Name
            ProfileDetailRow(
              label: 'Full Name',
              value: 
              // regModel.fullName ?? 
              'Not provided',
            ),
            const SizedBox(height: 10),
            // Email
            ProfileDetailRow(
              label: 'Email',
              value: 
              // regModel.email ?? 
              'Not provided',
            ),
            const SizedBox(height: 10),
            // Phone
            ProfileDetailRow(
              label: 'Phone',
              value: 
              // regModel.phone ?? 
              'Not provided',
            ),
            const SizedBox(height: 10),
            // Address
            ProfileDetailRow(
              label: 'Address',
              value: 
              // regModel.address ?? 
              'Not provided',
            ),
            const SizedBox(height: 10),
            // Registration Type
            ProfileDetailRow(
              label: 'Registered As',
              value: registrationType == 'ambulance'
                  ? 'Ambulance Driver'
                  : registrationType == 'none'
        ? 'User'
        : 'Volunteer'
            ),
            const SizedBox(height: 10),
            if (registrationType == 'ambulance') ...[
              // Vehicle Number
              ProfileDetailRow(
                label: 'Vehicle Number',
                value: 
                // regModel.vehicleNumber ?? 
                'Not provided',
              ),
              const SizedBox(height: 10),
            ],
            if (registrationType == 'volunteer') ...[
              // Skills
              const Text(
                'Skills:',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              if (_skillsOptions.isNotEmpty)
                Wrap(
                  spacing: 8.0,
                  runSpacing: 4.0,
                  children: _skillsOptions
                      .map((skill) => Chip(
                            label: Text(skill),
                            backgroundColor: Colors.blueGrey[100],
                          ))
                      .toList(),
                )
              else
                const Text('No skills selected'),
              const SizedBox(height: 10),
            ],
            const SizedBox(height: 20),
            // Edit Profile Button
            // ElevatedButton(
            //   style: ElevatedButton.styleFrom(
            //     fixedSize: const Size(200, 50),
            //     backgroundColor: const Color(0xFF1D1F2A),
            //   ),
            //   onPressed: () {
            //     // Navigate to Edit Profile Page or functionality
            //   },
            //   child: const Text(
            //     'Edit Profile',
            //     style: TextStyle(
            //       color: Colors.white,
            //       fontWeight: FontWeight.w600,
            //       fontSize: 16,
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}

class ProfileDetailRow extends StatelessWidget {
  final String label;
  final String value;

  const ProfileDetailRow({
    super.key,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$label: ',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(fontSize: 16),
          ),
        ),
      ],
    );
  }
}
