import 'package:flutter/material.dart';

class FeedbackPage extends StatefulWidget {
  const FeedbackPage({super.key});

  @override
  _FeedbackPageState createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  final _formKey = GlobalKey<FormState>();
  String? feedback;
  String? rating;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6F9),
      appBar: AppBar(
        title: const Text('Feedback'),
        centerTitle: true,
        backgroundColor: const Color(0xFF1D1F2A),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 20),
              // Title
              Text(
                'We value your feedback!',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              // Rating Section
              // Text(
              //   'Rate your experience:',
              //   style: TextStyle(
              //     fontSize: 18,
              //     fontWeight: FontWeight.w600,
              //     color: Colors.black54,
              //   ),
              // ),
              // const SizedBox(height: 10),
              // DropdownButtonFormField<String>(
              //   decoration: InputDecoration(
              //     labelText: 'Rating (1 to 5)',
              //     labelStyle: TextStyle(color: Colors.black54),
              //     filled: true,
              //     fillColor: Colors.white,
              //     border: OutlineInputBorder(
              //       borderRadius: BorderRadius.circular(12),
              //       borderSide: BorderSide.none,
              //     ),
              //     contentPadding: const EdgeInsets.symmetric(horizontal: 20),
              //   ),
              //   value: rating,
              //   items: ['1', '2', '3', '4', '5']
              //       .map((ratingValue) => DropdownMenuItem(
              //             value: ratingValue,
              //             child: Text(ratingValue),
              //           ))
              //       .toList(),
              //   onChanged: (value) {
              //     setState(() {
              //       rating = value;
              //     });
              //   },
              //   validator: (value) {
              //     if (value == null || value.isEmpty) {
              //       return 'Please select a rating';
              //     }
              //     return null;
              //   },
              // ),
              const SizedBox(height: 20),
              // Feedback Section
              Text(
                'Your Feedback:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.black54,
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Write your feedback here...',
                  labelStyle: TextStyle(color: Colors.black54),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                ),
                maxLines: 5,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please provide your feedback';
                  }
                  return null;
                },
                onSaved: (value) => feedback = value,
              ),
              const SizedBox(height: 30),
              // Submit Button
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1D1F2A),
                  fixedSize: Size(380, 50),
                ),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    // Handle feedback submission logic here
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Feedback submitted successfully')),
                    );
                  }
                },
                child: const Text(
                  'Submit Feedback',
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
