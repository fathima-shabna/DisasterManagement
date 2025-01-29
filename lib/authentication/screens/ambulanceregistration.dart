// import 'package:flutter/material.dart';


// class RegistrationScreen extends StatefulWidget {
//   @override
//   _RegistrationScreenState createState() => _RegistrationScreenState();
// }

// class _RegistrationScreenState extends State<RegistrationScreen> {
//   final _formKey = GlobalKey<FormState>();
//   final TextEditingController _passwordController = TextEditingController();

//   String? fullName;
//   String? email;
//   String? phoneNumber;
//   String? password;
//   String? vehicleNumber;

//     @override
//   void dispose() {
//     _passwordController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: const Color(0xFF1D1F2A),
//         title: const Text('Register'),
//         centerTitle: true,
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16.0),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: [
//               SizedBox(height: 30,),
//               // const Text(
//               //   'Register',
//               //   style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//               //   textAlign: TextAlign.center,
//               // ),
//               const SizedBox(height: 20),
//               // Full Name
//               TextFormField(
//                 decoration: const InputDecoration(
//                   labelText: 'Full Name',
//                   border: OutlineInputBorder(),
//                   prefixIcon: Icon(Icons.person),
//                 ),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter your full name';
//                   }
//                   return null;
//                 },
//                 onSaved: (value) => fullName = value,
//               ),
//               const SizedBox(height: 15),
//               // Email
//               TextFormField(
//                 decoration: const InputDecoration(
//                   labelText: 'Email',
//                   border: OutlineInputBorder(),
//                   prefixIcon: Icon(Icons.email),
//                 ),
//                 keyboardType: TextInputType.emailAddress,
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter your email';
//                   } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
//                     return 'Please enter a valid email address';
//                   }
//                   return null;
//                 },
//                 onSaved: (value) => email = value,
//               ),
//               const SizedBox(height: 15),
//               // Phone Number
//               TextFormField(
//                 decoration: const InputDecoration(
//                   labelText: 'Phone Number',
//                   border: OutlineInputBorder(),
//                   prefixIcon: Icon(Icons.phone),
//                 ),
//                 keyboardType: TextInputType.phone,
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter your phone number';
//                   } else if (value.length != 10) {
//                     return 'Phone number must be 10 digits';
//                   }
//                   return null;
//                 },
//                 onSaved: (value) => phoneNumber = value,
//               ),
//               const SizedBox(height: 15),
//               TextFormField(
//                 decoration: const InputDecoration(
//                   labelText: 'Vehicle Number',
//                   border: OutlineInputBorder(),
//                   prefixIcon: Icon(Icons.library_books_outlined),
//                 ),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter your vehicle number';
//                   }
//                   return null;
//                 },
//                 onSaved: (value) => vehicleNumber = value,
//               ),
//               const SizedBox(height: 15),
//               // Password
//               TextFormField(
//                 decoration: const InputDecoration(
//                   labelText: 'Password',
//                   border: OutlineInputBorder(),
//                   prefixIcon: Icon(Icons.lock),
//                 ),
//                 obscureText: true,
//                 controller: _passwordController,
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter your password';
//                   } else if (value.length < 6) {
//                     return 'Password must be at least 6 characters';
//                   }
//                   return null;
//                 },
//                 onSaved: (value) => password = value,
//               ),
//               const SizedBox(height: 15),
//               // Confirm Password
//               TextFormField(
//                 decoration: const InputDecoration(
//                   labelText: 'Confirm Password',
//                   border: OutlineInputBorder(),
//                   prefixIcon: Icon(Icons.lock_outline),
//                 ),
//                 obscureText: true,
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please confirm your password';
//                   } else if (value != _passwordController.text) {
//                     return 'Passwords do not match';
//                   }
//                   return null;
//                 },
//               ),
//               const SizedBox(height: 20),
              
//               // Register Button
//               ElevatedButton(
//                  style: ElevatedButton.styleFrom(fixedSize: Size(380, 50),backgroundColor: const Color(0xFF1D1F2A)), 
//                 onPressed: () {
//                   if (_formKey.currentState!.validate()) {
//                     _formKey.currentState!.save();
//                     // Handle registration logic here
//                     ScaffoldMessenger.of(context).showSnackBar(
//                       const SnackBar(content: Text('Registration successful')),
//                     );
//                   }
//                 },
//                 child: Text("Register",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600,fontSize: 16),),
//               ),
//               const SizedBox(height: 15),
//               // Already have an account?
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   const Text("Already have an account?"),
//                   TextButton(
//                     onPressed: () {
//                       // Navigate to login screen
//                     },
//                     child: const Text('Login',style: TextStyle(color: const Color(0xFF1D1F2A)),),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }


// }
