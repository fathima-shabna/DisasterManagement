import 'package:disastermanagement/admin/addcampcoordinator.dart';
import 'package:disastermanagement/admin/assigntask.dart';
import 'package:disastermanagement/admin/emergencyalert.dart';
import 'package:disastermanagement/admin/resourcemanagement.dart';
import 'package:disastermanagement/admin/viewfeedbacks.dart';
import 'package:disastermanagement/admin/viewreportedincidents.dart';
import 'package:disastermanagement/admin/viewvolunteers.dart';
import 'package:disastermanagement/authentication/screens/login.dart';
import 'package:disastermanagement/volunteer/screens/tasks.dart';
import 'package:flutter/material.dart';

// Placeholder screens for the different functionalities
class AdminHomePage extends StatefulWidget {
  @override
  _AdminHomePageState createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {
  int _currentIndex = 1; // Initially set to center tab (Resource Management)

  // List of screens for bottom navigation
  final List<Widget> _screens = [
    VolunteerPage(),
    ManageResourcesPage(),
    AssignTaskPage(),
    EmergencyAlertScreen(),
    ReportedIncidentsPage(),
  ];

  final List<String> _appBarTitles = [
    'Volunteers',
    'Resource Management',
    'Assign Duties',
    'Emergency Alerts',
    'Reported Incidents'
  ];

  Widget _buildDrawerItem({required IconData icon, required String text, required VoidCallback onTap}) {
  return ListTile(
    leading: Icon(icon, color: Color(0xFF1D1F2A)),
    title: Text(
      text,
      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
    ),
    onTap: onTap,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
    tileColor: Colors.grey[200], // Soft background for better visibility
    contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    trailing: Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
  );
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_appBarTitles[_currentIndex]),
        centerTitle: true,
        backgroundColor: Color(0xFF1D1F2A),
      ),
      body: _screens[_currentIndex],
      drawer: Drawer(
  child: Column(
    children: [
      UserAccountsDrawerHeader(
        accountName: Text(
          'Admin Name',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        accountEmail: Text(
          'admin@example.com',
          style: TextStyle(color: Colors.white70),
        ),
        decoration: BoxDecoration(
          color: Color(0xFF1D1F2A),
        ),
        currentAccountPicture: CircleAvatar(
          backgroundColor: Colors.white,
          child: Icon(Icons.admin_panel_settings, color: Colors.black, size: 30),
        ),
      ),
      Expanded(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            _buildDrawerItem(
              icon: Icons.group,
              text: 'Camp Coordinator Management',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CampCoordinatorPage()),
                );
              },
            ),
            _buildDrawerItem(
              icon: Icons.feedback,
              text: 'View Feedbacks',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ViewFeedbacksPage()),
                );
              },
            ),
            Divider(color: Colors.grey[600]),
            _buildDrawerItem(
              icon: Icons.logout,
              text: 'Logout',
              onTap: () {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen(),));
              },
            ),
          ],
        ),
      ),
    ],
  ),
),


      bottomNavigationBar: BottomAppBar(
        shape: AutomaticNotchedShape( RoundedRectangleBorder(),
          // StadiumBorder(side: BorderSide(width: 0)),
          ),
        color: const Color.fromARGB(255, 155, 148, 147),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: Icon(Icons.publish, color: Colors.white),
                onPressed: () {
                  setState(() {
                    _currentIndex = 0;
                  });
                },
              ),
              IconButton(
                icon: Icon(Icons.storage, color: Colors.white),
                onPressed: () {
                  setState(() {
                    _currentIndex = 1;
                  });
                },
              ),
              SizedBox(width: 50), // Add space for the floating action button
              IconButton(
                icon: Icon(Icons.notifications, color: Colors.white),
                onPressed: () {
                  setState(() {
                    _currentIndex = 3;
                  });
                },
              ),
              IconButton(
                icon: Icon(Icons.report_problem, color: Colors.white),
                onPressed: () {
                  setState(() {
                    _currentIndex = 4;
                  });
                },
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _currentIndex = 2; // Center tab
          });
        },
        backgroundColor: const Color(0xFF1D1F2A),
        child: Icon(
          Icons.assignment,
          size: 35.0,
          color: Colors.white,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

// Placeholder for different screens
class PublishNoticeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('Create and publish notices with location')),
    );
  }
}

class CampCoordinatorScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('Manage camp coordinators')),
    );
  }
}


