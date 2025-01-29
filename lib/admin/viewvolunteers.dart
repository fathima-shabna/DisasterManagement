import 'package:flutter/material.dart';



class Volunteer {
  final String fullName;
  final String skills;
  final String address;
  final String email;
  final String phoneNumber;

  Volunteer({
    required this.fullName,
    required this.skills,
    required this.address,
    required this.email,
    required this.phoneNumber,
  });
}

class VolunteerPage extends StatelessWidget {
  final List<Volunteer> volunteers = [
    Volunteer(
      fullName: 'John Doe',
      skills: 'Swimming, first Aid',
      address: 'Vythiri, Wayanad',
      email: 'john.doe@example.com',
      phoneNumber: '+91 7234567890',
    ),
    Volunteer(
      fullName: 'Jane Smith',
      skills: 'Cooking, Driving',
      address: 'Sultan BAtheri, Wayanad',
      email: 'jane.smith@example.com',
      phoneNumber: '+91 7234567891',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F0F0),
      body: ListView.builder(
        itemCount: volunteers.length,
        itemBuilder: (context, index) {
          final volunteer = volunteers[index];
          return VolunteerCard(volunteer: volunteer);
        },
      ),
    );
  }
}

class VolunteerCard extends StatelessWidget {
  final Volunteer volunteer;

  VolunteerCard({required this.volunteer});

void _showDetails(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.white, // Dialog background color
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15), // Rounded corners
        ),
        title: Text(
          volunteer.fullName,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1D1F2A), // Title color
          ),
        ),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.location_on, color: Colors.redAccent, size: 20),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Address: ${volunteer.address}',
                    style: TextStyle(fontSize: 16, color: Colors.grey[800]),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Icon(Icons.email, color: Colors.green, size: 20),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Email: ${volunteer.email}',
                    style: TextStyle(fontSize: 16, color: Colors.grey[800]),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Icon(Icons.phone, color: Colors.blue, size: 20),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Phone Number: ${volunteer.phoneNumber}',
                    style: TextStyle(fontSize: 16, color: Colors.grey[800]),
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(
              'Close',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.redAccent, // Button text color
              ),
            ),
          ),
        ],
      );
    },
  );
}


@override
Widget build(BuildContext context) {
  return Card(
    margin: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
    elevation: 4,
    child: InkWell(
      onTap: () => _showDetails(context),
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        child: Row(
          children: [
            CircleAvatar(
              radius: 24,
              backgroundColor: Colors.teal.shade400,
              child: Icon(
                Icons.person,
                size: 22,
                color: Colors.white,
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    volunteer.fullName,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    volunteer.skills,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.shade600,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            Icon(
              Icons.info_outline,
              size: 24,
              color: Colors.teal.shade400,
            ),
          ],
        ),
      ),
    ),
  );
}


}
