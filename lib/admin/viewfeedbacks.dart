import 'package:flutter/material.dart';

class ViewFeedbacksPage extends StatelessWidget {
  final List<FeedbackModel> feedbacks = [
    FeedbackModel(
      senderName: "John",
      message: "Great service! Keep it up.",
      receivedDate: DateTime(2024, 1, 15),
    ),
    FeedbackModel(
      senderName: "Alice",
      message: "The response time was quick and helpful.",
      receivedDate: DateTime(2024, 1, 12),
    ),
    FeedbackModel(
      senderName: "Ananth",
      message: "The response time was quick and helpful.",
      receivedDate: DateTime(2024, 1, 10),
    ),
  ];

  ViewFeedbacksPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6F9),
      appBar: AppBar(
        title: const Text('View Feedbacks'),
        centerTitle: true,
        // backgroundColor: Colors.deepPurple,
        elevation: 0,
      ),
      body: SafeArea(
        child: ListView.builder(
          padding: const EdgeInsets.all(16.0),
          itemCount: feedbacks.length,
          itemBuilder: (context, index) {
            final feedback = feedbacks[index];
            return FeedbackCard(feedback: feedback);
          },
        ),
      ),
    );
  }
}

class FeedbackCard extends StatelessWidget {
  final FeedbackModel feedback;

  const FeedbackCard({Key? key, required this.feedback}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Sender Name
            Text(
              feedback.senderName,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF1D1F2A),
              ),
            ),
            const SizedBox(height: 6),

            // Received Date
            Row(
              children: [
                const Icon(Icons.calendar_today, size: 16, color: Colors.grey),
                const SizedBox(width: 6),
                Text(
                  '${feedback.receivedDate.toLocal()}'.split(' ')[0],
                  style: const TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ],
            ),
            const SizedBox(height: 10),

            // Feedback Message
            Text(
              feedback.message,
              style: const TextStyle(fontSize: 16, color: Colors.black87),
            ),
          ],
        ),
      ),
    );
  }
}

// Feedback Model
class FeedbackModel {
  final String senderName;
  final String message;
  final DateTime receivedDate;

  FeedbackModel({
    required this.senderName,
    required this.message,
    required this.receivedDate,
  });
}
