import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pinput/pinput.dart';
import 'package:wecodethat/constants/colors.dart';
import 'package:wecodethat/constants/validators.dart';
import 'package:wecodethat/controller/auth_controller.dart';

class InputSection extends StatelessWidget {
  const InputSection({
    super.key,
    required this.provider,
  });
  final AuthcontrolProvider provider;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 30,
      ),
      decoration: BoxDecoration(
        color: WeCodeThatColors.primaryWhite,
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
        children: [
          // PIN input
          Pinput(
            length: 4,
            controller: provider.pinController,
            obscureText: !provider.isPinVisible,
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            validator: CustomValidator.validatePinput,
            defaultPinTheme: PinTheme(
              width: 65,
              height: 65,
              textStyle: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.purple.shade900,
              ),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade300),
              ),
            ),
            focusedPinTheme: PinTheme(
              width: 65,
              height: 65,
              textStyle: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.purple.shade900,
              ),
              decoration: BoxDecoration(
                color: WeCodeThatColors.primaryWhite,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: WeCodeThatColors.purple8,
                  width: 2,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.purple.withOpacity(0.1),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
            ),
            submittedPinTheme: PinTheme(
              width: 65,
              height: 65,
              textStyle: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.purple.shade900,
              ),
              decoration: BoxDecoration(
                color: Colors.purple.shade50,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.purple.shade200),
              ),
            ),
            errorPinTheme: PinTheme(
              width: 65,
              height: 65,
              textStyle: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),
              decoration: BoxDecoration(
                color: Colors.red.shade50,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.red),
              ),
            ),
          ),

          const SizedBox(height: 16),

          TextButton.icon(
            onPressed: provider.togglePinVisibility,
            icon: Icon(
              provider.isPinVisible ? Icons.visibility_off : Icons.visibility,
              color: Colors.purple.shade800,
            ),
            label: Text(
              provider.isPinVisible ? "Hide PIN" : "Show PIN",
              style: TextStyle(
                color: WeCodeThatColors.purple8,
              ),
            ),
          ),

          const SizedBox(height: 8),

          // Error message
          if (provider.errorMessage.isNotEmpty)
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.red.shade50,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.red.shade200),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.error_outline,
                    color: Colors.red,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      provider.errorMessage,
                      style: const TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
