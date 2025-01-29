import 'package:disastermanagement/authentication/screens/login.dart';
import 'package:disastermanagement/models/regModel.dart';
import 'package:disastermanagement/volunteer/screens/feedback.dart';
import 'package:disastermanagement/volunteer/screens/profile.dart';
import 'package:disastermanagement/volunteer/screens/report.dart';
import 'package:disastermanagement/volunteer/screens/resources.dart';
import 'package:disastermanagement/volunteer/screens/tasks.dart';
import 'package:disastermanagement/volunteer/screens/viewalert.dart';
import 'package:flutter/material.dart';

class VolunteerHomePage extends StatefulWidget {
  @override
  State<VolunteerHomePage> createState() => _VolunteerHomePageState();
}

class _VolunteerHomePageState extends State<VolunteerHomePage> {
  final String fullName = "John Doe"; 

  final String email = "johndoe@example.com"; 

  final registrationType = 'volunteer';

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false, // Prevent closing by tapping outside
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
                // Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => LoginScreen(regModel: RegistrationModel(fullName: '', email: '', phone: '', address: '', password: '', selectedSkills: [], registrationType: ''),),), (Route<dynamic> route) => false,);
                Navigator.pop(context);
                print('Logged out successfully'); 
              },
              child: Text('Logout',style: TextStyle(color: Colors.white),),
            ),
          ],
        );
      },
    );
  }

   @override
  void initState() {
    super.initState();
    // Navigate to the alert screen when the app opens
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _showEmergencyAlert();
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(builder: (context) => ViewAlertScreen()),
      // );
    });
  }
  
    void _showEmergencyAlert() {
    showDialog(
      context: context,
      builder: (context) => ViewAlertWidget(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dashboard"),
        centerTitle: true,
        actions: [
          IconButton(onPressed: (){
            _showLogoutDialog(context);
          }, icon: Icon(Icons.logout_rounded))
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Welcome Section
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Welcome Back,",
                        style: TextStyle(fontSize: 18, color: Colors.grey),
                      ),
                      Text(
                        fullName,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        email,
                        style: const TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
        
              // Tasks Card
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AssignedTasksPage(),
                    ),
                  );
                },
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  elevation: 5,
                  child: ListTile(
                    leading: const Icon(Icons.task_alt, color:  Color(0xFF1D1F2A), ),
                    title: const Text(
                      "Tasks",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    subtitle: const Text("View your assigned tasks"),
                    trailing: const Icon(Icons.arrow_forward_ios),
                  ),
                ),
              ),
        
              const SizedBox(height: 20),
              if(registrationType == 'volunteer'|| registrationType == 'ambulance') ...[
                GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ReportIncidentPage(),
                    ),
                  );
                },
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  elevation: 5,
                  child: ListTile(
                    leading: const Icon(Icons.report_gmailerrorred, color:  Color(0xFF1D1F2A), ),
                    title: const Text(
                      "Report",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    subtitle: const Text("Report Incidents"),
                    trailing: const Icon(Icons.arrow_forward_ios),
                  ),
                ),
              ),
              ],
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ViewResourcesPage(),
                    ),
                  );
                },
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  elevation: 5,
                  child: ListTile(
                    leading: const Icon(Icons.attach_money, color:  Color(0xFF1D1F2A), ),
                    title: const Text(
                      "Resources",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    subtitle: const Text("View resources and send donation"),
                    trailing: const Icon(Icons.arrow_forward_ios),
                  ),
                ),
              ),
        
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FeedbackPage(),
                    ),
                  );
                },
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  elevation: 5,
                  child: ListTile(
                    leading: const Icon(Icons.feedback_outlined, color:  Color(0xFF1D1F2A), ),
                    title: const Text(
                      "Feedbacks",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    subtitle: const Text("Send your Feedback"),
                    trailing: const Icon(Icons.arrow_forward_ios),
                  ),
                ),
              ),
              SizedBox(height: 20,),
              // Profile Card
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                elevation: 5,
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: const Color(0xFF1D1F2A),
                    child: Text(
                      fullName[0],
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                  title: const Text(
                    "View Profile",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: const Text("Manage your account details"),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => ProfilePage(),));
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
