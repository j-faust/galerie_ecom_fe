import 'package:flutter/material.dart';
import 'package:galerie_ecom_fe/widgets/spatter_app_bar.dart';
import '../../services/auth_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() =>  _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
final _formKey = GlobalKey<FormState>();

  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final String _selectedRole = 'user';
  final bool _isLoading = false;
  String? _errorMessage;
  final bool _obscurePassword = true;

  
final AuthService _authService = AuthService();

  Future<void> _login() async {
    if(!_formKey.currentState!.validate()) return;

    bool isLoading = false;
    String? errorMessage;

    setState(() {
      isLoading = true;
      errorMessage = null;
    
    });

    final success = await _authService.login(
      _emailController.text,
      _passwordController.text
    );
 
    }

    void _onForgotPassword() {
      // Navigate to Forgot Password screen
      Navigator.pushNamed(context, '/forgot-password');
    }

    void _onRegister() {
      // Navigate to Register screen
      Navigator.pushNamed(context, '/register');
    }
    @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: const SpatterAppBar(title: 'Galerie'),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Log in',
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                ),
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                

                if (_errorMessage != null)
                  Text(_errorMessage!, style: const TextStyle(color: Colors.red)),
                const SizedBox(height: 16),

                TextFormField(
                  controller: _usernameController,
                  decoration: const InputDecoration(labelText: 'Username'),
                  validator: (value) =>
                      value!.isEmpty ? 'Please enter a username!' : null,
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
                const SizedBox(height: 24),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _login,
                    child: _isLoading
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Text('Login'),
                  ),
                ),

                const SizedBox(height: 12),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: _onForgotPassword, // define this function
                      child: const Text('Forgot Password?'),
                    ),
                    TextButton(
                      onPressed: _onRegister, // define this function
                      child: const Text('Register'),
                    ),
                  ],
                ),

              ],
            ),
          ),
        ),
      ),
          );  
  
    }
  }
  
  