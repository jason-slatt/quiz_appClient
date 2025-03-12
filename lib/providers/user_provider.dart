import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  String? _username;
  String? _email;
  String? _uid;
  String? _photoURL;

  // Getters
  String? get username => _username;
  String? get email => _email;
  String? get uid => _uid;
  String? get photoURL => _photoURL;

  // Function to update user data
  void setUser(String username, String email, String uid, String photoURL) {
    _username = username;
    _email = email;
    _uid = uid;
    _photoURL = photoURL;
    notifyListeners(); // Notify listeners to rebuild UI when data changes
  }

  // Function to clear user data on logout
  void clearUser() {
    _username = null;
    _email = null;
    _uid = null;
    _photoURL = null;
    notifyListeners();
  }
}
