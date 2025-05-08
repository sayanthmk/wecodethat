import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wecodethat/constants/colors.dart';
import 'package:wecodethat/controller/auth_controller.dart';

class PInSetupForm extends StatelessWidget {
  const PInSetupForm({
    super.key,
    required this.provider,
  });

  final AuthcontrolProvider provider;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Choose your PIN',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),

          const SizedBox(height: 6),

          const Text(
            'Make sure it\'s something you can remember',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
          ),

          const SizedBox(height: 24),

          // PIN input
          TextFormField(
            controller: provider.pinController,
            decoration: InputDecoration(
              labelText: 'Enter PIN',
              labelStyle: TextStyle(color: WeCodeThatColors.purple7),
              hintText: '••••',
              prefixIcon: Icon(
                Icons.pin_outlined,
                color: WeCodeThatColors.purple7,
              ),
              suffixIcon: IconButton(
                icon: Icon(
                  provider.isPinVisible
                      ? Icons.visibility_off
                      : Icons.visibility,
                  color: WeCodeThatColors.purple7,
                ),
                onPressed: provider.togglePinVisibility,
              ),
              filled: true,
              fillColor: Colors.grey.shade100,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: WeCodeThatColors.purple7),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: WeCodeThatColors.red),
              ),
            ),
            keyboardType: TextInputType.number,
            obscureText: !provider.isPinVisible,
            maxLength: 4,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 20,
              letterSpacing: 8,
              fontWeight: FontWeight.bold,
            ),
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'PIN is required';
              } else if (value.length != 4) {
                return 'PIN must be exactly 4 digits';
              } else if (!RegExp(r'^\d{4}$').hasMatch(value)) {
                return 'PIN must contain only digits';
              }
              return null;
            },
          ),

          const SizedBox(height: 16),

          // Confirm PIN input
          TextFormField(
            controller: provider.confirmPinController,
            decoration: InputDecoration(
              labelText: 'Confirm PIN',
              labelStyle: TextStyle(color: WeCodeThatColors.purple7),
              hintText: '••••',
              prefixIcon: Icon(
                Icons.check_circle_outline,
                color: WeCodeThatColors.purple7,
              ),
              suffixIcon: IconButton(
                icon: Icon(
                  provider.isConfirmPinVisible
                      ? Icons.visibility_off
                      : Icons.visibility,
                  color: WeCodeThatColors.purple7,
                ),
                onPressed: provider.toggleConfirmPinVisibility,
              ),
              filled: true,
              fillColor: Colors.grey.shade100,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: WeCodeThatColors.purple7),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: WeCodeThatColors.red),
              ),
            ),
            keyboardType: TextInputType.number,
            obscureText: !provider.isConfirmPinVisible,
            maxLength: 4,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 20,
              letterSpacing: 8,
              fontWeight: FontWeight.bold,
            ),
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Confirm your PIN';
              } else if (value != provider.pinController.text) {
                return 'PINs do not match';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }
}
