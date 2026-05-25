import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import '../services/session_service.dart';
import '../services/notification_service.dart';
import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _userController = TextEditingController();
  final _passController = TextEditingController();
  
  final AuthService _authService = AuthService();
  final SessionService _sessionService = SessionService();
  final NotificationService _notificationService = NotificationService();

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _notificationService.init();
    _notificationService.requestPermissions();
  }

  Future<void> _handleLogin() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);
    final userData = await _authService.loginWithApi(_userController.text, _passController.text);
    setState(() => _isLoading = false);

    if (userData != null) {
      await _sessionService.saveSession(userData['accessToken'], "${userData['firstName']} ${userData['lastName']}");
      await _notificationService.showNotification("Login Success", "Welcome back, ${userData['firstName']}!");
      
      if (!mounted) return;
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomeScreen()));
    } else {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Invalid credentials")));
    }
  }

  Future<void> _handleGoogleSignIn() async {
    setState(() => _isLoading = true);
    final user = await _authService.signInWithGoogle();
    setState(() => _isLoading = false);

    if (user != null) {
      await _sessionService.saveSession(user.uid, user.displayName);
      await _notificationService.showNotification("Google Login Success", "Hi ${user.displayName}!");
      
      if (!mounted) return;
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomeScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Lab 10 - Integration")),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: _userController,
                decoration: const InputDecoration(labelText: "Username (emilys)", border: OutlineInputBorder()),
                validator: (v) => v!.isEmpty ? "Enter username" : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _passController,
                obscureText: true,
                decoration: const InputDecoration(labelText: "Password (emilyspass)", border: OutlineInputBorder()),
                validator: (v) => v!.isEmpty ? "Enter password" : null,
              ),
              const SizedBox(height: 24),
              _isLoading 
                ? const CircularProgressIndicator() 
                : Column(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(onPressed: _handleLogin, child: const Text("LOGIN")),
                      ),
                      const SizedBox(height: 16),
                      const Text("OR"),
                      const SizedBox(height: 16),
                      SizedBox(
                        width: double.infinity,
                        child: OutlinedButton.icon(
                          onPressed: _handleGoogleSignIn,
                          icon: const Icon(Icons.login),
                          label: const Text("Sign in with Google"),
                        ),
                      ),
                    ],
                  ),
            ],
          ),
        ),
      ),
    );
  }
}
