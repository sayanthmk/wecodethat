import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wecodethat/constants/colors.dart';
import 'package:wecodethat/controller/auth_controller.dart';
import 'package:wecodethat/view/auth_sec/input_pin/pininput.dart';
import 'package:wecodethat/view/todo/list_screen/list_screen.dart';

class PinAuthScreen extends StatelessWidget {
  PinAuthScreen({super.key});
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Consumer<AuthcontrolProvider>(
      builder: (context, provider, _) {
        return Scaffold(
          backgroundColor: Colors.grey.shade50,
          appBar: AppBar(
            backgroundColor: WeCodeThatColors.purple8,
            foregroundColor: WeCodeThatColors.primaryWhite,
            elevation: 0,
            title: const Text(
              'Welcome Back',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
            ),
            centerTitle: true,
            automaticallyImplyLeading: false,
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Container(
                        width: size.width * 0.3,
                        height: size.width * 0.3,
                        decoration: BoxDecoration(
                          color: Colors.purple.shade100.withOpacity(0.3),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.lock_outline_rounded,
                          size: size.width * 0.15,
                          color: WeCodeThatColors.purple8,
                        ),
                      ),

                      const SizedBox(height: 32),

                      Text(
                        'Unlock Your Tasks',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: WeCodeThatColors.purple8,
                        ),
                      ),

                      const SizedBox(height: 16),

                      Text(
                        'Enter your 4-digit PIN to access your tasks',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey.shade600,
                        ),
                        textAlign: TextAlign.center,
                      ),

                      const SizedBox(height: 48),

                      // PIN input container
                      InputSection(
                        provider: provider,
                      ),

                      const SizedBox(height: 32),

                      //  button
                      ElevatedButton(
                        onPressed: provider.isAuthenticating
                            ? null
                            : () => _verifyPin(context, provider),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: WeCodeThatColors.purple8,
                          foregroundColor: Colors.white,
                          disabledBackgroundColor: Colors.purple.shade200,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          minimumSize: const Size.fromHeight(58),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          elevation: 2,
                        ),
                        child: provider.isAuthenticating
                            ? const SizedBox(
                                width: 24,
                                height: 24,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2,
                                ),
                              )
                            : const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.login_rounded),
                                  SizedBox(width: 8),
                                  Text(
                                    'Unlock App',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                      ),

                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void _verifyPin(BuildContext context, AuthcontrolProvider provider) async {
    if (_formKey.currentState!.validate()) {
      final isSuccess = await provider.verifyPin();
      if (isSuccess && context.mounted) {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return Dialog(
              backgroundColor: Colors.transparent,
              elevation: 0,
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.check_circle,
                      color: Colors.green,
                      size: 80,
                    ),
                    SizedBox(height: 16),
                    Text(
                      'PIN Verified!',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Accessing your tasks...',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ),
            );
          },
        );

        Future.delayed(const Duration(milliseconds: 1200), () {
          if (context.mounted) {
            Navigator.pop(context);
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (_) => const TodoListScreen(),
              ),
            );
          }
        });
      } else {}
    }
  }
}




 // void _shakeError(BuildContext context) {
  //   // This would need a StatefulWidget implementation
  //   // For now, we'll just show a flash of red background
  //   ScaffoldMessenger.of(context).showSnackBar(
  //     SnackBar(
  //       content: const Text('Incorrect PIN. Please try again.'),
  //       backgroundColor: Colors.red.shade700,
  //       behavior: SnackBarBehavior.floating,
  //       shape: RoundedRectangleBorder(
  //         borderRadius: BorderRadius.circular(10),
  //       ),
  //       margin: const EdgeInsets.all(16),
  //       action: SnackBarAction(
  //         label: 'OK',
  //         textColor: Colors.white,
  //         onPressed: () {},
  //       ),
  //     ),
  //   );
  // }

  // void _showForgotPinDialog(BuildContext context) {
  //   showDialog(
  //     context: context,
  //     builder: (context) => AlertDialog(
  //       shape: RoundedRectangleBorder(
  //         borderRadius: BorderRadius.circular(20),
  //       ),
  //       title: const Text('Forgot PIN?'),
  //       content: const Column(
  //         mainAxisSize: MainAxisSize.min,
  //         children: [
  //           Icon(
  //             Icons.support_agent,
  //             size: 48,
  //             color: Colors.orange,
  //           ),
  //           SizedBox(height: 16),
  //           Text(
  //             'If you forgot your PIN, you will need to reset the application.',
  //             textAlign: TextAlign.center,
  //           ),
  //           SizedBox(height: 8),
  //           Text(
  //             'Note: This will clear all your tasks data.',
  //             style: TextStyle(
  //               fontWeight: FontWeight.bold,
  //               color: Colors.red,
  //             ),
  //             textAlign: TextAlign.center,
  //           ),
  //         ],
  //       ),
  //       actions: [
  //         TextButton(
  //           onPressed: () => Navigator.pop(context),
  //           child: const Text('Cancel'),
  //         ),
  //         ElevatedButton(
  //           style: ElevatedButton.styleFrom(
  //             backgroundColor: Colors.red,
  //             foregroundColor: Colors.white,
  //           ),
  //           onPressed: () {
  //             // Implementation for resetting would go here
  //             Navigator.pop(context);
  //             ScaffoldMessenger.of(context).showSnackBar(
  //               const SnackBar(
  //                 content: Text('This feature is coming soon'),
  //               ),
  //             );
  //           },
  //           child: const Text('Reset App'),
  //         ),
  //       ],
  //     ),
  //   );
  // }