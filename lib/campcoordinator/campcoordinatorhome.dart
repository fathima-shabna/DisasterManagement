import 'package:disastermanagement/authentication/screens/login.dart';
import 'package:disastermanagement/campcoordinator/availableresources.dart';
import 'package:disastermanagement/campcoordinator/demandresources.dart';
import 'package:disastermanagement/models/regModel.dart';
import 'package:flutter/material.dart';

class CoordinatorHomeScreen extends StatelessWidget {
  const CoordinatorHomeScreen({super.key});

  
  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: Text('Confirm Logout'),
          content: Text('Are you sure you want to logout?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Cancel',style: TextStyle(color: const Color(0xFF1D1F2A))),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1D1F2A),
              ),
              onPressed: () {
                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => LoginScreen(),), (Route<dynamic> route) => false,);
                // print('Logged out successfully'); 
              },
              child: Text('Logout',style: TextStyle(color: Colors.white),),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFD9D9DB),
      appBar: AppBar(
        title: Text(
          'Resource Management',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        // backgroundColor: const Color(0xFF1D1F2A),
        elevation: 4,
        actions: [
          IconButton(onPressed: (){
            _showLogoutDialog(context);
          }, icon: Icon(Icons.logout_rounded))
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Welcome, Coordinator!',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: Color(0xFF2C2F3E),
            ),
          ),
          SizedBox(height: 16),
          Text(
            'Choose an option below to manage resources:',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              color: Color(0xFF2C2F3E),
            ),
          ),
          SizedBox(height: 30),
          _buildNavigationCard(
            context,
            title: 'Available Resources',
            description: 'View and manage all available resources.',
            icon: Icons.storage_rounded,
            color: Colors.blue.shade400,
            targetPage: AvailableResourcePage(),
          ),
          SizedBox(height: 20),
          _buildNavigationCard(
            context,
            title: 'Request/Demand Resources',
            description: 'Create and track resource requests.',
            icon: Icons.request_page_rounded,
            color: Colors.green.shade400,
            targetPage: DemandResourcePage(),
          ),
        ],
      ),
    );
  }

  Widget _buildNavigationCard(BuildContext context,
      {required String title,
      required String description,
      required IconData icon,
      required Color color,
      required Widget targetPage}) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => targetPage),
        );
      },
      child: Card(
        elevation: 6,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: 28,
                backgroundColor: Colors.white,
                child: Icon(icon, size: 30, color: color),
              ),
              SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 6),
                    Text(
                      description,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(Icons.arrow_forward_ios_rounded, color: Colors.white),
            ],
          ),
        ),
      ),
    );
  }
}



