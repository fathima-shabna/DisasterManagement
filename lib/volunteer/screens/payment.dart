import 'package:flutter/material.dart';

class PaymentPage extends StatefulWidget {
  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  final TextEditingController _amountController = TextEditingController();
  bool _isPaymentSuccessful = false;

  // Method to show the confirmation dialog
  void _showConfirmationDialog() {
    String amount = _amountController.text;

    // Validate the input
    if (amount.isEmpty || int.tryParse(amount) == null || int.parse(amount) <= 0) {
      // Show error message if the amount is invalid
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Please enter a valid amount'),
        backgroundColor: Colors.red,
      ));
      return;
    }

    showDialog(
      context: context,
      barrierDismissible: false, // Prevent closing by tapping outside
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Payment'),
          content: Text(
              'Are you sure you want to make a payment of \$${_amountController.text}?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text(
                'Cancel',
                style: TextStyle(color: const Color(0xFF1D1F2A)),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green[200],
              ),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                _makePayment(); // Proceed with payment
              },
              child: Text('Proceed', style: TextStyle(color: const Color(0xFF1D1F2A))),
            ),
          ],
        );
      },
    );
  }

  // Method to process the payment
  void _makePayment() {
    String amount = _amountController.text;
    if (amount.isNotEmpty && int.tryParse(amount) != null) {
      setState(() {
        _isPaymentSuccessful = true;
      });

      // Show the success dialog for a few seconds and then close it
      Future.delayed(Duration(seconds: 2), () {
        setState(() {
          _isPaymentSuccessful = false;
        });
      });

      // Clear the text field and dispose the controller
      _amountController.clear();
    }
  }

  @override
  void dispose() {
    _amountController.dispose(); // Dispose of the controller when the page is disposed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment Page'),
        centerTitle: true,
        backgroundColor: Color(0xFF1D1F2A),
      ),
      body: Stack(
        children: [
          // Content of the page (Column)
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Amount input field
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: TextField(
                    controller: _amountController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Enter Amount',
                      hintText: 'Amount to pay',
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
                SizedBox(height: 20),
                // Payment button
                ElevatedButton(
                  onPressed: _showConfirmationDialog, // Show confirmation dialog
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF1D1F2A),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    'Make Payment',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
          // Success Dialog (appears only if payment is successful)
          if (_isPaymentSuccessful)
            Positioned.fill(
              bottom: 100,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: AnimatedOpacity(
                  opacity: _isPaymentSuccessful ? 1 : 0,
                  duration: Duration(seconds: 1),
                  child: Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.green[200],
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 10,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.check_circle_outline,
                          color: Colors.green[800],
                          size: 30,
                        ),
                        SizedBox(width: 10),
                        Text(
                          'Payment Successful!',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.green[800],
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
