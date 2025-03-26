// // File: lib/screens/auth/verification_screen.dart
// import 'package:flutter/material.dart';

// class VerificationScreen extends StatelessWidget {
//   final String phoneNumber;

//   const VerificationScreen({super.key, required this.phoneNumber});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Verify OTP')),
//       body: Center(
//         child: Text('OTP sent to $phoneNumber'),
//       ),
//     );
//   }
// }






import 'package:flutter/material.dart';
import 'package:flutter_edu_path/screens/login_screen_with_otp.dart';

class VerificationScreen extends StatelessWidget {
  final String phoneNumber;

  const VerificationScreen({super.key, required this.phoneNumber});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Verify OTP')),
      body: Center(
        // padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('OTP sent to $phoneNumber', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreenWithOtp()),
                );
              },
              child: const Text('Proceed'),
            ),
          ],
        ),
      ),
    );
  }
}
