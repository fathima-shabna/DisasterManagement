import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ManageResourcesPage extends StatefulWidget {
  @override
  _ManageResourcesPageState createState() => _ManageResourcesPageState();
}

class _ManageResourcesPageState extends State<ManageResourcesPage> {
  final List<Resource> _availableResources = [
    Resource(name: 'Food', quantity: 500, type: 'Food'),
    Resource(name: 'Jackets', quantity: 100, type: 'Clothes'),
    Resource(name: 'Medical Kits', quantity: 50, type: 'First Aid'),
    Resource(name: 'Blankets', quantity: 200, type: 'Clothes'),
  ];

  final List<ResourceRequest> _resourceRequests = [
    ResourceRequest(
      coordinatorName: 'John Doe',
      resourceName: 'Food',
      requestedQuantity: 100,
      reason: 'For feeding refugees.',
    ),
    ResourceRequest(
      coordinatorName: 'Jane Smith',
      resourceName: 'Tents',
      requestedQuantity: 50,
      reason: 'To accommodate displaced people.',
    ),
  ];

  final double _availableMoney = 5000.00;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F0F0),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildSummaryDashboard(),
            SizedBox(height: 16),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSectionHeader('Available Resources'),
                    _buildUpdatedResourcesGrid(),
                    SizedBox(height: 16),
                    _buildSectionHeader('Resource Requests'),
                    _buildUpdatedRequestsList(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryDashboard() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildDashboardCard(
          title: 'Available Money',
          value: '\$$_availableMoney',
          icon: Icons.attach_money,
          color: Colors.orangeAccent,
        ),
        _buildDashboardCard(
          title: 'Requests Pending',
          value: '${_resourceRequests.length}',
          icon: Icons.pending_actions,
          color: Colors.redAccent,
        ),
      ],
    );
  }

  Widget _buildDashboardCard({
    required String title,
    required String value,
    required IconData icon,
    required Color color,
  }) {
    return Expanded(
      child: Card(
        color: color,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 30, color: Colors.white),
              SizedBox(height: 8),
              Text(
                title,
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
              SizedBox(height: 8),
              Text(
                value,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }

Widget _buildUpdatedResourcesGrid() {
  // Define a list of colors
  final List<Color> cardColors = [
    Colors.blue.shade100,
    Colors.green.shade100,
    Colors.pink.shade50,
    Colors.orange.shade100,
    Colors.purple.shade100,
    Colors.teal.shade100,
    Colors.amber.shade100,
  ];

  return GridView.builder(
    physics: NeverScrollableScrollPhysics(),
    shrinkWrap: true,
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
      mainAxisSpacing: 16.0,
      crossAxisSpacing: 16.0,
      childAspectRatio: 3 / 2,
    ),
    itemCount: _availableResources.length,
    itemBuilder: (context, index) {
      final resource = _availableResources[index];
      final cardColor = cardColors[index % cardColors.length]; // Cycle through colors

      return Card(
        color: cardColor, // Set unique color for each card
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.inventory_2_outlined, size: 24, color: Colors.blue),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      resource.name,
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8),
              Text('Quantity: ${resource.quantity}',
                  style: TextStyle(fontSize: 16, color: Colors.black87)),
              Text('Type: ${resource.type}',
                  style: TextStyle(fontSize: 14, color: Colors.grey)),
            ],
          ),
        ),
      );
    },
  );
}


  Widget _buildUpdatedRequestsList() {
    return Column(
      children: _resourceRequests.map((request) {
        return Card(
          elevation: 4,
          margin: EdgeInsets.symmetric(vertical: 8),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.person_outline, size: 32, color: Colors.green),
                SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${request.resourceName} Request',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Coordinator: ${request.coordinatorName}',
                        style: TextStyle(fontSize: 14, color: Colors.black87),
                      ),
                      Text(
                        'Quantity: ${request.requestedQuantity}',
                        style: TextStyle(fontSize: 14, color: Colors.black87),
                      ),
                      Text(
                        'Reason: ${request.reason}',
                        style: TextStyle(fontSize: 14, color: Colors.black54),
                      ),
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: () => _allocateResource(request),
                  child: Text('Allocate',style: TextStyle(color: Colors.white),),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    backgroundColor: const Color.fromARGB(255, 54, 131, 94),
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

void _allocateResource(ResourceRequest request) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text('Confirm Allocation'),
        content: Text(
          'Allocate ${request.requestedQuantity} of ${request.resourceName} to ${request.coordinatorName}?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context), // Close the dialog
            child: Text('Cancel'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Color(0xFF1D1F2A),),
            onPressed: () {
              // Process allocation logic
              setState(() {
                _resourceRequests.remove(request); // Update the list
              });

              Navigator.pop(context); // Close the dialog
              _showSuccess(
                'Allocated ${request.requestedQuantity} of ${request.resourceName} to ${request.coordinatorName}.',
              );
            },
            child: Text('Confirm', style: TextStyle(color: Colors.white),),
          ),
        ],
      );
    },
  );
}


// Helper function to show success messages
void _showSuccess(String message) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text('Success'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('OK',style: TextStyle(color: Color(0xFF1D1F2A)),),
          ),
        ],
      );
    },
  );
}

}

class Resource {
  final String name;
  final int quantity;
  final String type;

  Resource({required this.name, required this.quantity, required this.type});
}

class ResourceRequest {
  final String coordinatorName;
  final String resourceName;
  final int requestedQuantity;
  final String reason;

  ResourceRequest({
    required this.coordinatorName,
    required this.resourceName,
    required this.requestedQuantity,
    required this.reason,
  });
}
