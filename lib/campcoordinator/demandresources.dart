import 'package:flutter/material.dart';

class Resource {
  final String category;
  final String name;
  final String description;
  int needed;

  Resource({
    required this.category,
    required this.name,
    required this.description,
    required this.needed,
  });
}

class DemandResourcePage extends StatefulWidget {
  @override
  _DemandResourcePageState createState() => _DemandResourcePageState();
}

class _DemandResourcePageState extends State<DemandResourcePage> {
  final List<String> categories = ['Food', 'Clothes', 'First Aid'];
  String selectedCategory = 'Food'; // Default category
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController neededController = TextEditingController();

  // Function to handle form submission
  void _submitDemand() {
    String name = nameController.text;
    String description = descriptionController.text;
    int? needed = int.tryParse(neededController.text);

    if (name.isNotEmpty && description.isNotEmpty && needed != null && needed > 0) {
      // Show confirmation dialog
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Confirm Submission'),
            content: Text('Do you want to submit the demand for $name?'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                },
                child: Text('Cancel',style: TextStyle(color: Color(0xFF1D1F2A)),),
              ),
              ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Color(0xFF1D1F2A)),
                onPressed: () {
                  // In real case, this data would be saved to a database or used for further processing
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Demand for $name created successfully!')),
                  );
                  
                  // Clear the input fields after submission
                  nameController.clear();
                  descriptionController.clear();
                  neededController.clear();

                  Navigator.of(context).pop(); // Close the dialog
                },
                child: Text('Confirm',style: TextStyle(color: Colors.white),),
              ),
            ],
          );
        },
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill in all fields correctly.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFD9D9DB),
      appBar: AppBar(
        title: Text('Demand Resource'),
        centerTitle: true,
        backgroundColor: Color(0xFF1D1F2A),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Dropdown for category selection
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 6,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: DropdownButtonFormField<String>(
                  value: selectedCategory,
                  items: categories.map((category) {
                    return DropdownMenuItem(
                      value: category,
                      child: Text(category),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedCategory = value!;
                    });
                  },
                  decoration: InputDecoration(
                    labelText: 'Select Category',
                    // labelStyle: TextStyle(
                    //   color: Color(0xFF1D1F2A),
                    //   fontWeight: FontWeight.bold,
                    // ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    filled: true,
                    // fillColor: Colors.white,
                    contentPadding: EdgeInsets.symmetric(horizontal: 20),
                  ),
                ),
              ),
              SizedBox(height: 16),

              // Field to enter resource name
              _buildTextField(
                controller: nameController,
                label: 'Resource Name',
              ),
              SizedBox(height: 16),

              // Field to enter description
              _buildTextField(
                controller: descriptionController,
                label: 'Description',
                maxLines: 3,
              ),
              SizedBox(height: 16),

              // Field to enter the amount of resource needed
              _buildTextField(
                controller: neededController,
                label: 'Amount Needed',
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 24),

              // Submit button
              ElevatedButton(
                onPressed: _submitDemand,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF1D1F2A),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  minimumSize: Size(double.infinity, 50),
                ),
                child: Text(
                  'Submit Demand',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    int maxLines = 1,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        maxLines: maxLines,
        decoration: InputDecoration(
          labelText: label,
          // labelStyle: TextStyle(
          //   color: Color(0xFF1D1F2A),
          //   fontWeight: FontWeight.bold,
          // ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none
          ),
          filled: true,
          // fillColor: Colors.white,
          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        ),
      ),
    );
  }
}
