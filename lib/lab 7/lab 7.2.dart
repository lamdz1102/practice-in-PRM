import 'package:flutter/material.dart';

class Lab72ValidationRulesScreen extends StatefulWidget {
  const Lab72ValidationRulesScreen({super.key});

  @override
  State<Lab72ValidationRulesScreen> createState() =>
      _Lab72ValidationRulesScreenState();
}

class _Lab72ValidationRulesScreenState
    extends State<Lab72ValidationRulesScreen> {
  final _formKey = GlobalKey<FormState>();

  String _fullName = '';
  String _email = '';
  String _password = '';
  String _confirmPassword = '';

  String? _validateName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Full name is required';
    }
    return null;
  }

  String? _validateEmail(String? value) {
    final email = value?.trim() ?? '';

    if (email.isEmpty) {
      return 'Email is required';
    }

    if (!email.contains('@') || !email.contains('.')) {
      return 'Enter a valid email';
    }

    return null;
  }

  String? _validatePassword(String? value) {
    final password = value ?? '';

    if (password.isEmpty) {
      return 'Password is required';
    }

    if (password.length < 8) {
      return 'Password must be at least 8 characters';
    }

    if (!password.contains(RegExp(r'[0-9]'))) {
      return 'Password must contain at least 1 digit';
    }

    return null;
  }

  String? _validateConfirmPassword(String? value) {
    final confirmPassword = value ?? '';

    if (confirmPassword.isEmpty) {
      return 'Confirm password is required';
    }

    if (confirmPassword != _password) {
      return 'Passwords do not match';
    }

    return null;
  }

  void _submitForm() {
    final isValid = _formKey.currentState!.validate();

    if (!isValid) {
      return;
    }

    _formKey.currentState!.save();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Account created for $_email'),
      ),
    );

    debugPrint('Full name: $_fullName');
    debugPrint('Email: $_email');
    debugPrint('Password: $_password');
    debugPrint('Confirm password: $_confirmPassword');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lab 7.2 - Validation Rules'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: ListView(
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Full name',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person),
                ),
                textInputAction: TextInputAction.next,
                validator: _validateName,
                onSaved: (value) {
                  _fullName = value!.trim();
                },
              ),

              const SizedBox(height: 16),

              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.email),
                ),
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                validator: _validateEmail,
                onSaved: (value) {
                  _email = value!.trim();
                },
              ),

              const SizedBox(height: 16),

              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.lock),
                ),
                obscureText: true,
                textInputAction: TextInputAction.next,
                validator: _validatePassword,
                onChanged: (value) {
                  _password = value;
                },
                onSaved: (value) {
                  _password = value!;
                },
              ),

              const SizedBox(height: 16),

              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Confirm password',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.lock_outline),
                ),
                obscureText: true,
                textInputAction: TextInputAction.done,
                validator: _validateConfirmPassword,
                onChanged: (value) {
                  _confirmPassword = value;
                },
                onSaved: (value) {
                  _confirmPassword = value!;
                },
              ),

              const SizedBox(height: 24),

              ElevatedButton(
                onPressed: _submitForm,
                child: const Text('Create account'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}