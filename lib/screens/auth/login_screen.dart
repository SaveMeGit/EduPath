// Login Screen: lib/screens/auth/login_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
import '../../../../providers/auth_provider.dart';
import '../../verification_screen.dart';
import '../../../../widgets/custom_button.dart';
import '../../../../utils/app_theme.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _phoneController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  String _selectedCountryCode = '+1';

  final List<String> _countryCodes = ['+1', '+44', '+91', '+92', '+971', '+966'];

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  Future<void> _sendOTP() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
    });

    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final phoneNumber = '$_selectedCountryCode${_phoneController.text.trim()}';

    try {
      final success = await authProvider.sendOTP(phoneNumber);

      if (success) {
        if (mounted) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => VerificationScreen(
                phoneNumber: phoneNumber,
              ),
            ),
          );
        }
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content: Text('Failed to send OTP. Please try again.')),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${e.toString()}')),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Logo
                Container(
                  width: 80,
                  height: 80,
                  decoration: const BoxDecoration(
                    color: AppTheme.primaryColor,
                    shape: BoxShape.circle,
                  ),
                  child: const Center(
                    child: Text(
                      'S',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                // App Title
                const Text(
                  'Smart Learning',
                  style: TextStyle(
                    color: AppTheme.primaryColor,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),

                // Subtitle
                const Text(
                  'Learn with AI assistance in your preferred language',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppTheme.subtitleColor,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 48),

                // Phone Number Form
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          // Country Code Dropdown
                          Container(
                            decoration: BoxDecoration(
                              color: AppTheme.backgroundColor,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: AppTheme.borderColor),
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                value: _selectedCountryCode,
                                items: _countryCodes.map((code) {
                                  return DropdownMenuItem<String>(
                                    value: code,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 12),
                                      child: Text(code),
                                    ),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  if (value != null) {
                                    setState(() {
                                      _selectedCountryCode = value;
                                    });
                                  }
                                },
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),

                          // Phone Number Field
                          Expanded(
                            child: TextFormField(
                              controller: _phoneController,
                              decoration: const InputDecoration(
                                hintText: 'Phone Number',
                                prefixIcon: Icon(Icons.phone),
                              ),
                              keyboardType: TextInputType.phone,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your phone number';
                                }
                                if (value.length < 9) {
                                  return 'Please enter a valid phone number';
                                }
                                return null;
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),

                      // Send OTP Button
                      _isLoading
                          ? const CircularProgressIndicator()
                          : CustomButton(
                              text: 'Send OTP',
                              onPressed: _sendOTP,
                            ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}




// import 'package:flutter/material.dart';
// import 'package:flutter_application_for_testing/screens/login_screen_with_otp.dart';
// import 'package:provider/provider.dart';
// import 'package:flutter/services.dart';
// import '../../../../providers/auth_provider.dart';
// import '../../verification_screen.dart';
// import '../../../../widgets/custom_button.dart';

// class LoginScreen extends StatefulWidget {
//   const LoginScreen({super.key});

//   @override
//   State<LoginScreen> createState() => _LoginScreenState(); // Proper state definition
// }

// class _LoginScreenState extends State<LoginScreen> {
//   final _phoneController = TextEditingController();
//   final _formKey = GlobalKey<FormState>();
//   bool _isLoading = false;
//   String _selectedCountryCode = '+1';

//   final List<String> _countryCodes = ['+1', '+44', '+91', '+92', '+971', '+966'];

//   @override
//   void dispose() {
//     _phoneController.dispose();
//     super.dispose();
//   }

//   Future<void> _sendOTP() async {
//     if (!_formKey.currentState!.validate()) return;

//     setState(() {
//       _isLoading = true;
//     });

//     final authProvider = Provider.of<AuthProvider>(context, listen: false);
//     final phoneNumber = '$_selectedCountryCode${_phoneController.text.trim()}';

//     try {
//       final success = await authProvider.sendOTP(phoneNumber);

//       if (success && mounted) {
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) => VerificationScreen(phoneNumber: phoneNumber),
//           ),
//         );
//       } else {
//         _showSnackBar('Failed to send OTP. Please try again.');
//       }
//     } catch (e) {
//       _showSnackBar('Error: ${e.toString()}');
//     } finally {
//       if (mounted) {
//         setState(() {
//           _isLoading = false;
//         });
//       }
//     }
//   }

//   void _proceedToLoginScreenWithOtp() {
//     Navigator.push(
//       context,
//       MaterialPageRoute(builder: (context) => const LoginScreenWithOtp()),
//     );
//   }

//   void _showSnackBar(String message) {
//     if (mounted) {
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Center(
//           child: SingleChildScrollView(
//             padding: const EdgeInsets.all(24.0),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 // Logo
//                 Container(
//                   width: 80,
//                   height: 80,
//                   decoration: BoxDecoration(
//                     color: Theme.of(context).primaryColor, // Using theme color
//                     shape: BoxShape.circle,
//                   ),
//                   child: const Center(
//                     child: Text(
//                       'S',
//                       style: TextStyle(color: Colors.white, fontSize: 40, fontWeight: FontWeight.bold),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 24),

//                 // App Title
//                 Text(
//                   'Smart Learning',
//                   style: TextStyle(
//                     color: Theme.of(context).primaryColor,
//                     fontSize: 28,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 const SizedBox(height: 8),

//                 // Subtitle
//                 Text(
//                   'Learn with AI assistance in your preferred language',
//                   textAlign: TextAlign.center,
//                   style: TextStyle(
//                     color: Theme.of(context).textTheme.bodySmall?.color,
//                     fontSize: 16,
//                   ),
//                 ),
//                 const SizedBox(height: 48),

//                 // Phone Number Form
//                 Form(
//                   key: _formKey,
//                   child: Column(
//                     children: [
//                       Row(
//                         children: [
//                           // Country Code Dropdown
//                           Container(
//                             decoration: BoxDecoration(
//                               color: Theme.of(context).cardColor,
//                               borderRadius: BorderRadius.circular(8),
//                               border: Border.all(color: Theme.of(context).dividerColor),
//                             ),
//                             child: DropdownButtonHideUnderline(
//                               child: DropdownButton<String>(
//                                 value: _selectedCountryCode,
//                                 items: _countryCodes.map((code) {
//                                   return DropdownMenuItem<String>(
//                                     value: code,
//                                     child: Padding(
//                                       padding: const EdgeInsets.symmetric(horizontal: 12),
//                                       child: Text(code),
//                                     ),
//                                   );
//                                 }).toList(),
//                                 onChanged: (value) {
//                                   if (value != null) {
//                                     setState(() {
//                                       _selectedCountryCode = value;
//                                     });
//                                   }
//                                 },
//                               ),
//                             ),
//                           ),
//                           const SizedBox(width: 12),

//                           // Phone Number Field
//                           Expanded(
//                             child: TextFormField(
//                               controller: _phoneController,
//                               decoration: const InputDecoration(
//                                 hintText: 'Phone Number',
//                                 prefixIcon: Icon(Icons.phone),
//                               ),
//                               keyboardType: TextInputType.phone,
//                               inputFormatters: [FilteringTextInputFormatter.digitsOnly],
//                               validator: (value) {
//                                 if (value == null || value.isEmpty) {
//                                   return 'Please enter your phone number';
//                                 }
//                                 if (value.length < 9) {
//                                   return 'Please enter a valid phone number';
//                                 }
//                                 return null;
//                               },
//                             ),
//                           ),
//                         ],
//                       ),
//                       const SizedBox(height: 24),

//                       // Send OTP Button
//                       _isLoading
//                           ? const CircularProgressIndicator()
//                           : CustomButton(text: 'Send OTP', onPressed: _sendOTP),
//                       const SizedBox(height: 16),

//                       // Proceed Button
//                       ElevatedButton(
//                         onPressed: _proceedToLoginScreenWithOtp,
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: Theme.of(context).primaryColor,
//                           padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
//                         ),
//                         child: const Text(
//                           "Proceed",
//                           style: TextStyle(color: Colors.white, fontSize: 16),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
