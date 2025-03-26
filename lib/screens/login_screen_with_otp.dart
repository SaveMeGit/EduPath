// import 'package:flutter/material.dart';

// class LoginScreenWithOtp extends StatelessWidget {
//   const LoginScreenWithOtp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context); // Using custom theme

//     return Scaffold(
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 20.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               SizedBox(height: 20),
//               Text(
//                 "Login Screen", 
//                 style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
//                 ),
//               Spacer(),
//               Center(
//                 child: Column(
//                   children: [
//                     CircleAvatar(
//                       radius: 40,
//                       backgroundColor: theme.primaryColor,
//                       child: Text("S", style: theme.textTheme.headlineSmall?.copyWith(color: Colors.white)),
//                     ),
//                     SizedBox(height: 10),
//                     Text("Smart Learning", style: theme.textTheme.titleLarge?.copyWith(color: theme.primaryColor)),
//                     Text("Learn with AI assistance", style: theme.textTheme.titleSmall),
//                   ],
//                 ),
//               ),
//               SizedBox(height: 20),
//               TextField(
//                 decoration: InputDecoration(
//                   labelText: "Mobile Number",
//                   border: OutlineInputBorder(),
//                 ),
//               ),
//               SizedBox(height: 15),
//               TextField(
//                 decoration: InputDecoration(
//                   labelText: "Verification Code",
//                   border: OutlineInputBorder(),
//                 ),
//               ),
//               SizedBox(height: 20),
//               SizedBox(
//                 width: double.infinity,
//                 height: 50,
//                 child: ElevatedButton(
//                   onPressed: () {},
//                   child: Text("Login", style: theme.textTheme.labelLarge?.copyWith(color: Colors.white)),
//                 ),
//               ),
//               SizedBox(height: 20),
//               Text("Preferred Language", style: theme.textTheme.titleMedium),
//               SizedBox(height: 10),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: ["EN", "AR", "FR", "ES"].map((lang) => Chip(label: Text(lang))).toList(),
//               ),
//               Spacer(),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }









import 'package:flutter/material.dart';
import 'package:flutter_edu_path/screens/home_screen.dart';

class LoginScreenWithOtp extends StatefulWidget {
  const LoginScreenWithOtp({super.key});

  @override
  State<LoginScreenWithOtp> createState() => _LoginScreenWithOtpState();
}

class _LoginScreenWithOtpState extends State<LoginScreenWithOtp> {
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _otpController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _validateAndProceed() {
    if (_formKey.currentState!.validate()) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const MainScreen(), 
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                Text(
                  "Login Screen",
                  style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                ),
                const Spacer(),
                Center(
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 40,
                        backgroundColor: theme.primaryColor,
                        child: Text("S", style: theme.textTheme.headlineSmall?.copyWith(color: Colors.white)),
                      ),
                      const SizedBox(height: 10),
                      Text("Smart Learning", style: theme.textTheme.titleLarge?.copyWith(color: theme.primaryColor)),
                      Text("Learn with AI assistance", style: theme.textTheme.titleSmall),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _mobileController,
                  decoration: const InputDecoration(
                    labelText: "Mobile Number",
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter your mobile number";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 15),
                TextFormField(
                  controller: _otpController,
                  decoration: const InputDecoration(
                    labelText: "Verification Code",
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter the verification code";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: _validateAndProceed,
                    child: Text("Login", style: theme.textTheme.labelLarge?.copyWith(color: Colors.white)),
                  ),
                ),
                const SizedBox(height: 20),
                Text("Preferred Language", style: theme.textTheme.titleMedium),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: ["EN", "AR", "FR", "ES"].map((lang) => Chip(label: Text(lang))).toList(),
                ),
                const Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
