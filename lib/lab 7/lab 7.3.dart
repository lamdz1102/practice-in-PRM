import 'package:flutter/material.dart';

class Lab73FocusKeyboardScreen extends StatefulWidget {
  const Lab73FocusKeyboardScreen({super.key});

  @override
  State<Lab73FocusKeyboardScreen> createState() =>
      _Lab73FocusKeyboardScreenState();
}

class _Lab73FocusKeyboardScreenState extends State<Lab73FocusKeyboardScreen> {
  final _formKey = GlobalKey<FormState>();

  final FocusNode _nameFocus = FocusNode();
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();
  final FocusNode _confirmPasswordFocus = FocusNode();

  String _fullName = '';
  String _email = '';
  String _password = '';
  String _confirmPassword = '';

  @override
  void dispose() {
    _nameFocus.dispose();
    _emailFocus.dispose();
    _passwordFocus.dispose();
    _confirmPasswordFocus.dispose();
    super.dispose();
  }

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
    FocusScope.of(context).unfocus();

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

  void _moveFocus(FocusNode nextFocusNode) {
    FocusScope.of(context).requestFocus(nextFocusNode);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Lab 7.3 - Focus & Keyboard'),
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
                  focusNode: _nameFocus,
                  decoration: const InputDecoration(
                    labelText: 'Full name',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.person),
                  ),
                  textInputAction: TextInputAction.next,
                  validator: _validateName,
                  onFieldSubmitted: (_) {
                    _moveFocus(_emailFocus);
                  },
                  onSaved: (value) {
                    _fullName = value!.trim();
                  },
                ),

                const SizedBox(height: 16),

                TextFormField(
                  focusNode: _emailFocus,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.email),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  validator: _validateEmail,
                  onFieldSubmitted: (_) {
                    _moveFocus(_passwordFocus);
                  },
                  onSaved: (value) {
                    _email = value!.trim();
                  },
                ),

                const SizedBox(height: 16),

                TextFormField(
                  focusNode: _passwordFocus,
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
                  onFieldSubmitted: (_) {
                    _moveFocus(_confirmPasswordFocus);
                  },
                  onSaved: (value) {
                    _password = value!;
                  },
                ),

                const SizedBox(height: 16),

                TextFormField(
                  focusNode: _confirmPasswordFocus,
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
                  onFieldSubmitted: (_) {
                    _submitForm();
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
      ),
    );
  }
}