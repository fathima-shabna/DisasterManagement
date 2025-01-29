import 'package:flutter/material.dart';

class Resource {
  final String category;
  final String name;
  final String description;
  int available;

  Resource({
    required this.category,
    required this.name,
    required this.description,
    required this.available,
  });
}

class AvailableResourcePage extends StatefulWidget {
  const AvailableResourcePage({super.key});

  @override
  _AvailableResourcePageState createState() => _AvailableResourcePageState();
}

class _AvailableResourcePageState extends State<AvailableResourcePage> {
  final List<Resource> resources = [
    Resource(
      category: 'Food',
      name: 'Rice',
      description: '5 kg bag of rice',
      available: 50,
    ),
    Resource(
      category: 'Clothes',
      name: 'Winter Jackets',
      description: 'For adults',
      available: 30,
    ),
    Resource(
      category: 'First Aid',
      name: 'Bandages',
      description: 'Medical-grade adhesive bandages.',
      available: 100,
    ),
    Resource(
      category: 'Food',
      name: 'Vegetables',
      description: 'Fresh vegetables',
      available: 75,
    ),
  ];

  String selectedCategory = 'All'; // Default category filter

  @override
  Widget build(BuildContext context) {
    // Filter resources based on the selected category
    List<Resource> filteredResources = selectedCategory == 'All'
        ? resources
        : resources
            .where((resource) => resource.category == selectedCategory)
            .toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('Available Resources'),
        centerTitle: true,
        backgroundColor: Color(0xFF1D1F2A),
      ),
      body: Column(
        children: [
          // Filter Dropdown
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: DropdownButtonFormField<String>(
              decoration: InputDecoration(
                  labelText: 'Select Category',
                  labelStyle: TextStyle(
                    color: Color(0xFF1D1F2A),
                    fontWeight: FontWeight.bold,
                  ),
                  floatingLabelStyle: TextStyle(
                    backgroundColor: Colors.white,
                    color: Color(0xFF1D1F2A),
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: EdgeInsets.symmetric(horizontal: 20),
                ),
              value: selectedCategory,
              isExpanded: true,
              items: [
                'All',
                'Food',
                'Clothes',
                'First Aid',
              ].map((category) {
                return DropdownMenuItem<String>(
                  value: category,
                  child: Text(category),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedCategory = value!;
                });
              },
            ),
          ),
          // Resource List
          Expanded(
            child: ListView.builder(
              itemCount: filteredResources.length,
              itemBuilder: (context, index) {
                final resource = filteredResources[index];
                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 4,
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: _getCategoryColor(resource.category),
                      child: Icon(
                        _getCategoryIcon(resource.category),
                        color: Colors.white,
                      ),
                    ),
                    title: Text(
                      resource.name,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1D1F2A),
                      ),
                    ),
                    subtitle: Text(resource.description),
                    trailing: Text(
                      'Available: ${resource.available}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // Helper to get icon based on category
  IconData _getCategoryIcon(String category) {
    switch (category) {
      case 'Food':
        return Icons.fastfood;
      case 'Clothes':
        return Icons.checkroom;
      case 'First Aid':
        return Icons.medical_services;
      default:
        return Icons.help;
    }
  }

  // Helper to get color based on category
  Color _getCategoryColor(String category) {
    switch (category) {
      case 'Food':
        return Colors.orange;
      case 'Clothes':
        return Colors.blue;
      case 'First Aid':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}
