import 'package:flutter/material.dart';
import 'package:galerie_ecom_fe/widgets/spatter_app_bar.dart';
import '../../services/auth_service.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() =>  _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
final _formKey = GlobalKey<FormState>();

  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final String _selectedRole = 'user';
  final bool _isLoading = false;
  String? _errorMessage;
  final bool _obscurePassword = true;

  
final AuthService _authService = AuthService();

  Future<void> _ForgotPassword() async {
    if(!_formKey.currentState!.validate()) return;

    bool isLoading = false;
    String? errorMessage;

    setState(() {
      isLoading = true;
      errorMessage = null;
    
    });

    final success = await _authService.forgot_password(
      _emailController.text
    );
 
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
                  'Forgot Password',
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),

                if (_errorMessage != null)
                  Text(_errorMessage!, style: const TextStyle(color: Colors.red)),
                const SizedBox(height: 16),

                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(labelText: 'Email Address'),
                  validator: (value) =>
                      value!.isEmpty ? 'Please enter your email address!' : null,
                ),
                const SizedBox(height: 16),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _ForgotPassword,
                    child: _isLoading
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Text('Reset Password'),
                  ),
                ),

                const SizedBox(height: 12),

              ],
            ),
          ),
        ),
      ),
          );  
  
    }
  }
  
  