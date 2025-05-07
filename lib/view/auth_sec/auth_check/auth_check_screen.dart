import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:wecodethat/controller/auth_controller.dart';
import 'package:wecodethat/view/auth_sec/input_pin/imput_pin.dart';
import 'package:wecodethat/view/auth_sec/pin_setup/pin_setup.dart';

class AuthCheckScreen extends StatelessWidget {
  const AuthCheckScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthcontrolProvider>(
      builder: (context, authProvider, child) {
        if (authProvider.isLoading) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        WidgetsBinding.instance.addPostFrameCallback((_) {
          final nextScreen = authProvider.isPinSet == true
              ? PinAuthScreen()
              : const PinSetupScreen();

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => nextScreen),
          );
        });

        return Scaffold(
          body: Center(
            child: LottieBuilder.asset('asset/loading_animation.json'),
          ),
        );
      },
    );
  }
}
