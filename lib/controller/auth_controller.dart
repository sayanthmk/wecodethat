import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthcontrolProvider extends ChangeNotifier {
  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();
  bool isLoading = true;
  bool? isPinSet;

  AuthcontrolProvider() {
    _checkPin();
  }

  Future<void> _checkPin() async {
    final storedPin = await secureStorage.read(key: 'user_pin');
    isPinSet = storedPin != null;
    isLoading = false;
    notifyListeners();
  }

  final TextEditingController pinController = TextEditingController();
  final TextEditingController confirmPinController = TextEditingController();

  bool isPinVisible = false;
  bool isConfirmPinVisible = false;

  void togglePinVisibility() {
    isPinVisible = !isPinVisible;
    notifyListeners();
  }

  // Toggles the visibility of the confirm PIN field
  void toggleConfirmPinVisibility() {
    isConfirmPinVisible = !isConfirmPinVisible;
    notifyListeners();
  }

  // Saves the entered PIN to secure storage
  Future<void> savePin() async {
    await secureStorage.write(
      key: 'user_pin',
      value: pinController.text,
    );
    pinController.clear();
    confirmPinController.clear();
  }

// Deletes the stored PIN from secure storage
  Future<void> deletePin() async {
    await secureStorage.delete(
      key: 'user_pin',
    );

    isPinSet = false;
    notifyListeners();
  }

  @override
  void dispose() {
    pinController.dispose();
    confirmPinController.dispose();
    super.dispose();
  }

  String errorMessage = '';
  bool isAuthenticating = false;

  Future<bool> verifyPin() async {
    isAuthenticating = true;
    errorMessage = '';
    notifyListeners();

    final enteredPin = pinController.text;
    final storedPin = await secureStorage.read(key: 'user_pin');

    await Future.delayed(const Duration(milliseconds: 300));

    if (enteredPin == storedPin) {
      isAuthenticating = false;
      notifyListeners();
      return true;
    } else {
      errorMessage = 'Incorrect PIN. Please try again.';
      isAuthenticating = false;
      pinController.clear();
      notifyListeners();
      return false;
    }
  }
}
