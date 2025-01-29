import 'package:flutter/material.dart';

class ViewAlertWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      // title: Row(
      //   children: [
      //     Icon(Icons.warning_amber_rounded, color: Colors.red, size: 30),
      //     SizedBox(width: 10),
      //     Text("Emergency Alert!", style: TextStyle(color: Colors.red)),
      //   ],
      // ),
      content: Container(height: 400,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(Icons.warning_amber_rounded, color: Colors.red, size: 60),
              SizedBox(height: 10),
              Text(
                "🚨 Emergency Alert!",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.red),
              ),
              SizedBox(height: 20),
              // SizedBox(height: 20),
              Container(
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.yellow[100],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  "⚠️ Alert Message: \nUnusual activity detected in your area. Please stay safe and follow emergency protocols.",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, color: Colors.black87),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: () => Navigator.pop(context),
                icon: Icon(Icons.close,color: Colors.white,),
                label: Text("Dismiss"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
