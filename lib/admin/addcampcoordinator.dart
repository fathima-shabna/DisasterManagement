import 'package:flutter/material.dart';

class CampCoordinatorPage extends StatefulWidget {
  @override
  _CampCoordinatorPageState createState() => _CampCoordinatorPageState();
}

class _CampCoordinatorPageState extends State<CampCoordinatorPage> {
  final _formKey = GlobalKey<FormState>();

  // Controllers for input fields
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  List<Coordinator> coordinators = [];

  void _addCoordinator() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        coordinators.add(Coordinator(
          fullName: _nameController.text,
          email: _emailController.text,
          phone: _phoneController.text,
          address: _addressController.text,
          password: _passwordController.text,
        ));
      });

      // Clear fields after adding
      _nameController.clear();
      _emailController.clear();
      _phoneController.clear();
      _addressController.clear();
      _passwordController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFD9D9DB),
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Add Camp Coordinator'),
        backgroundColor: const Color(0xFF1D1F2A),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Form Section
            Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Add New Coordinator",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1D1F2A),
                        ),
                      ),
                      const SizedBox(height: 15),

                      // Full Name
                      _buildTextField(_nameController, "Full Name", Icons.person),
                      const SizedBox(height: 10),

                      // Email
                      _buildTextField(_emailController, "Email", Icons.email, isEmail: true),
                      const SizedBox(height: 10),

                      // Phone Number
                      _buildTextField(_phoneController, "Phone Number", Icons.phone, isNumber: true),
                      const SizedBox(height: 10),

                      // Address
                      _buildTextField(_addressController, "Address", Icons.home),
                      const SizedBox(height: 10),

                      // Password
                      _buildTextField(_passwordController, "Password", Icons.lock, isPassword: true),
                      const SizedBox(height: 20),

                      // Add Button
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _addCoordinator,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF1D1F2A),
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Text(
                            "Add Coordinator",
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold,color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),

            // View Coordinators Section
            if (coordinators.isNotEmpty) ...[
              const Text(
                "Registered Coordinators",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1D1F2A),
                ),
              ),
              const SizedBox(height: 10),

              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: coordinators.length,
                itemBuilder: (context, index) {
                  return CoordinatorCard(coordinator: coordinators[index]);
                },
              ),
            ],
          ],
        ),
      ),
    );
  }

  // TextField Builder Function
  Widget _buildTextField(
    TextEditingController controller,
    String label,
    IconData icon, {
    bool isEmail = false,
    bool isPassword = false,
    bool isNumber = false,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: isNumber ? TextInputType.phone : TextInputType.text,
      obscureText: isPassword,
      decoration: InputDecoration(
        fillColor: const Color.fromARGB(255, 232, 226, 226),
                    floatingLabelStyle: TextStyle(backgroundColor: Colors.transparent,color: Colors.black54,fontSize: 20),
                    labelStyle: TextStyle(color: Colors.black54,fontSize: 16),
        labelText: label,
        prefixIcon: Icon(icon, color: Color(0xFF1D1F2A)),
        border: OutlineInputBorder(borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) return "This field is required";
        if (isEmail && !RegExp(r"^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$").hasMatch(value)) {
          return "Enter a valid email";
        }
        return null;
      },
    );
  }
}

// Coordinator Model
class Coordinator {
  final String fullName;
  final String email;
  final String phone;
  final String address;
  final String password;

  Coordinator({
    required this.fullName,
    required this.email,
    required this.phone,
    required this.address,
    required this.password,
  });
}

// Coordinator Card Widget
class CoordinatorCard extends StatelessWidget {
  final Coordinator coordinator;

  const CoordinatorCard({Key? key, required this.coordinator}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: CircleAvatar(
          backgroundColor: const Color(0xFF1D1F2A),
          child: Text(
            coordinator.fullName[0],
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
        title: Text(
          coordinator.fullName,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("📧 ${coordinator.email}"),
            Text("📞 ${coordinator.phone}"),
            Text("🏠 ${coordinator.address}"),
          ],
        ),
      ),
    );
  }
}