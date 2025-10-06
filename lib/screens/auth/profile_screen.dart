
import 'package:flutter/material.dart';
import 'package:galerie_ecom_fe/models/user.dart';
import 'package:galerie_ecom_fe/services/auth_service.dart';
import 'package:galerie_ecom_fe/widgets/spatter_app_bar.dart'; // adjust import path as needed

class UserProfilePage extends StatelessWidget {
  UserProfilePage({super.key});

  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SpatterAppBar(
        title: 'Profile',
        centerTitle: true,
      ),
      // We wrap the part of the UI that depends on the data with a FutureBuilder.
      body: FutureBuilder<User?>(
        // 1. PROVIDE THE FUTURE
        // This is where you call your asynchronous method. The FutureBuilder
        // will "listen" to the result of this call.
        future: _authService.getCurrentUser(),

        // 2. PROVIDE THE BUILDER
        // This builder function runs every time the state of the future changes.
        // The 'snapshot' contains the current state and the data (once it arrives).
        builder: (context, snapshot) {
          // STATE 1: Future is still running (waiting for the user data)
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          // STATE 2: Future completed with an error
          else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          // STATE 3: Future completed, but returned null or no data
          else if (!snapshot.hasData || snapshot.data == null) {
            return const Center(child: Text('User not found. Please log in.'));
          }

          // STATE 4: Success! The future completed and we have user data.
          // We can now safely access the data from the snapshot.
          final user = snapshot.data!;

          // Now we return the actual UI, using the 'user' object we just got.
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.account_circle, size: 100, color: Colors.grey),
                const SizedBox(height: 24),
                Text(
                  'Name: ${user.firstName} ${user.lastName}',
                  style: const TextStyle(fontSize: 18),
                ),
                const SizedBox(height: 8),
                Text(
                  'Email: ${user.email}',
                  style: const TextStyle(fontSize: 18),
                ),
                const SizedBox(height: 8),
                Text(
                  'Username: ${user.username}',
                  style: const TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}