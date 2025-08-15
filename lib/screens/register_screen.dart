import 'package:flutter/material.dart';
import 'package:galerie_ecom_fe/widgets/spatter_app_bar.dart';
import '../services/auth_service.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();

  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  String _selectedRole = 'user';
  bool _isLoading = false;
  String? _errorMessage;

  final List<String> _roles = ['user', 'seller', 'admin'];

  final AuthService _authService = AuthService();

  Future<void> _register() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    final success = await _authService.register(_usernameController.text,
        _emailController.text, _passwordController.text, [
      _selectedRole,
    ]);

    setState(() {
      _isLoading = false;
    });

    if (success) {
      Navigator.pushReplacementNamed(context, '/signon');
    } else {
      setState(() {
        _errorMessage =
            "Registration failed. Try a different username/password";
      });
    }
  }

 @override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: const SpatterAppBar(title: 'Register'),
    body: Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (_errorMessage != null)
                Text(
                  _errorMessage!,
                  style: const TextStyle(color: Colors.red),
                ),
                const SizedBox(height: 16),
              TextFormField(
                controller: _usernameController,
                decoration: const InputDecoration(labelText: 'Username'),
                validator: (value) =>
                    value!.isEmpty ? 'Please enter a username!' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'Email'),
                validator: (value) =>
                    value!.isEmpty ? 'Please enter an email!' : null,
              ),
              const SizedBox(height: 16),

              TextFormField(
                controller: _passwordController,
                decoration: const InputDecoration(labelText: 'Password'),
                obscureText: true,
                validator: (value) => value!.length < 8
                    ? 'Password must be at least 8 characters!'
                    : null,
              ),
              const SizedBox(height: 16),
              
              DropdownButtonFormField(
                decoration: const InputDecoration(labelText: 'Role'),
                value: _selectedRole,
                items: _roles.map((role) {
                  return DropdownMenuItem(
                    value: role,
                    child: Text(role[0].toUpperCase() + role.substring(1)),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedRole = value!;
                  });
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _isLoading ? null : _register,
                child: _isLoading
                    ? const CircularProgressIndicator()
                    : const Text('Register'),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
}
