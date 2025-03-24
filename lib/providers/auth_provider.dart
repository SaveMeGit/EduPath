// Auth Provider: lib/providers/auth_provider.dart

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/user_model.dart';
import '../../services/auth_service.dart';
import 'dart:convert';

class AuthProvider extends ChangeNotifier {
  bool _isLoggedIn = false;
  UserModel? _currentUser;
  String _verificationId = '';
  List<UserModel> _linkedAccounts = [];
  final AuthService _authService = AuthService();

  bool get isLoggedIn => _isLoggedIn;

  UserModel? get currentUser => _currentUser;

  List<UserModel> get linkedAccounts => _linkedAccounts;

  AuthProvider() {
    _loadUserFromPrefs();
  }

  Future<void> _loadUserFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final userString = prefs.getString('user');

    if (userString != null) {
      final userMap = jsonDecode(userString) as Map<String, dynamic>;
      _currentUser = UserModel.fromJson(userMap);
      _isLoggedIn = true;

      // Load linked accounts
      final linkedAccountsString = prefs.getString('linkedAccounts');
      if (linkedAccountsString != null) {
        final linkedAccountsList = jsonDecode(linkedAccountsString) as List;
        _linkedAccounts = linkedAccountsList
            .map((account) => UserModel.fromJson(account))
            .toList();
      }

      notifyListeners();
    }
  }

  Future<void> _saveUserToPrefs() async {
    final prefs = await SharedPreferences.getInstance();

    if (_currentUser != null) {
      await prefs.setString('user', jsonEncode(_currentUser!.toJson()));
      await prefs.setString(
          'linkedAccounts',
          jsonEncode(
              _linkedAccounts.map((account) => account.toJson()).toList()));
    } else {
      await prefs.remove('user');
      await prefs.remove('linkedAccounts');
    }
  }

  Future<bool> sendOTP(String phoneNumber) async {
    try {
      _verificationId = await _authService.sendOTP(phoneNumber);
      return true;
    } catch (e) {
      debugPrint('Error sending OTP: $e');
      return false;
    }
  }

  Future<bool> verifyOTP(String otp) async {
    try {
      final verified = await _authService.verifyOTP(_verificationId, otp);
      return verified;
    } catch (e) {
      debugPrint('Error verifying OTP: $e');
      return false;
    }
  }

  Future<bool> registerUser({
    required String phoneNumber,
    required String name,
    required String language,
    String? grade,
    String accountType = 'Student',
  }) async {
    try {
      // In a real app, you would make an API call to register the user
      final user = UserModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        name: name,
        phoneNumber: phoneNumber,
        language: language,
        grade: grade,
        accountType: accountType,
        linkCode: _generateLinkCode(),
        createdAt: DateTime.now(),
      );

      _currentUser = user;
      _isLoggedIn = true;
      await _saveUserToPrefs();
      notifyListeners();
      return true;
    } catch (e) {
      debugPrint('Error registering user: $e');
      return false;
    }
  }

  bool checkUserExists(String phoneNumber) {
    // In a real app, you would make an API call to check if the user exists
    // For demo purposes, we'll simulate it
    return false;
  }

  Future<void> addLinkedAccount(UserModel user) async {
    _linkedAccounts.add(user);
    await _saveUserToPrefs();
    notifyListeners();
  }

  Future<void> removeLinkedAccount(String userId) async {
    _linkedAccounts.removeWhere((user) => user.id == userId);
    await _saveUserToPrefs();
    notifyListeners();
  }

  Future<void> updateUserProfile({
    String? name,
    String? language,
    String? grade,
  }) async {
    if (_currentUser != null) {
      _currentUser = _currentUser!.copyWith(
        name: name ?? _currentUser!.name,
        language: language ?? _currentUser!.language,
        grade: grade ?? _currentUser!.grade,
      );
      await _saveUserToPrefs();
      notifyListeners();
    }
  }

  Future<void> logout() async {
    _currentUser = null;
    _isLoggedIn = false;
    _linkedAccounts = [];
    await _saveUserToPrefs();
    notifyListeners();
  }

  String _generateLinkCode() {
    // Generate a random 6-character alphanumeric code
    const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    return List.generate(
        6,
        (index) =>
            chars[DateTime.now().millisecondsSinceEpoch % chars.length]).join();
  }
}
