import 'package:disastermanagement/volunteer/screens/payment.dart';
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

class ViewResourcesPage extends StatefulWidget {
  @override
  _ViewResourcesPageState createState() => _ViewResourcesPageState();
}

class _ViewResourcesPageState extends State<ViewResourcesPage> {
  final List<Resource> resources = [
    Resource(
        category: 'Food',
        name: 'Rice',
        description: '5 kg bag of rice',
        needed: 10),
    Resource(
        category: 'Food',
        name: 'Vegetables',
        description: 'Fresh vegetables',
        needed: 15),
    Resource(
        category: 'Clothes',
        name: 'Winter Jacket',
        description: 'For adults',
        needed: 8),
    Resource(
        category: 'Clothes',
        name: 'Blankets',
        description: 'Warm and cozy',
        needed: 20),
    Resource(
        category: 'First Aid',
        name: 'First Aid',
        description: 'For medical aid',
        needed: 5),
  ];

  String selectedCategory = 'All';
  List<String> categories = ['All', 'Food', 'Clothes', 'First Aid'];

  @override
  Widget build(BuildContext context) {
    List<Resource> filteredResources = selectedCategory == 'All'
        ? resources
        : resources.where((res) => res.category == selectedCategory).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('View Resources'),
        centerTitle: true,
        backgroundColor: Color(0xFF1D1F2A),
      ),
      body: Container(
        color: Colors.grey[100],
        child: Column(
          children: [
            SizedBox(height: 20,),

            ListTile(
              contentPadding: EdgeInsets.all(16),
              title: Text(
                'Cash Donation',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Color(0xFF1D1F2A),
                ),
              ),
              // subtitle: Text(
              //   'Amount Needed: \$50',
              //   style: TextStyle(fontSize: 14),
              // ),
              trailing: ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => PaymentPage(),));
                  // _showCashDonationDialog(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF1D1F2A),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text('Donate', style: TextStyle(color: Colors.white)),
              ),
            ),
            // Dropdown for category selection
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: DropdownButtonFormField<String>(
                value: selectedCategory,
                items: categories
                    .map((category) => DropdownMenuItem(
                          value: category,
                          child: Text(category),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    selectedCategory = value!;
                  });
                },
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
              ),
            ),
            // Display filtered resources
            Expanded(
              child: filteredResources.isEmpty
                  ? Center(
                      child: Text(
                        'No resources available for this category.',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
                    )
                  : ListView.builder(
                      itemCount: filteredResources.length,
                      itemBuilder: (context, index) {
                        Resource resource = filteredResources[index];
                        return Card(
                          margin: EdgeInsets.symmetric(
                              horizontal: 12, vertical: 8),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: ListTile(
                            contentPadding: EdgeInsets.all(16),
                            title: Text(
                              resource.name,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: Color(0xFF1D1F2A),
                              ),
                            ),
                            subtitle: Text(
                              resource.description,
                              style: TextStyle(fontSize: 14),
                            ),
                            trailing: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Needed: ${resource.needed}',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.redAccent,
                                  ),
                                ),
                                // SizedBox(height: 8),
                                ElevatedButton(
                                  onPressed: () {
                                    _showDonateDialog(context, resource);
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Color(0xFF1D1F2A),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  child: Text('Donate',style: TextStyle(color: Colors.white),),
                                ),
                                
                              ],
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  // Function to show the donate dialog
  void _showDonateDialog(BuildContext context, Resource resource) {
    int selectedQuantity = 1;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          title: Text(
            'Donate ${resource.name}',
            style: TextStyle(color: Color(0xFF1D1F2A)),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Select quantity to donate (1 - ${resource.needed}):',
              ),
              SizedBox(height: 10),
              DropdownButton<int>(
                value: selectedQuantity,
                items: List.generate(resource.needed, (index) {
                  int quantity = index + 1;
                  return DropdownMenuItem<int>(
                    value: quantity,
                    child: Text(quantity.toString()),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedQuantity = value!;
                  });
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
              },
              child: Text('Cancel',style: TextStyle(color: Colors.black),),
            ),
            ElevatedButton(
              onPressed: () {
                 setState(() {
                // Reduce the `needed` amount of the resource
                resource.needed -= selectedQuantity;

                // Optionally remove the resource if the needed amount is zero
                if (resource.needed <= 0) {
                  resources.remove(resource);
                }
              });
                Navigator.pop(context); // Close the dialog
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'You donated $selectedQuantity ${resource.name}(s)!',
                    ),
                    backgroundColor: Color(0xFF1D1F2A),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF1D1F2A),
              ),
              child: Text('Confirm',style: TextStyle(color: Colors.white),),
            ),
          ],
        );
      },
    );
  }

  
}
