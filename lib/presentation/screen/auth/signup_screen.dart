import 'package:flutter/material.dart';
import 'package:musix/logic/provider/cpassword_visiblity.dart';
import 'package:musix/logic/provider/password_visiblity.dart';
import 'package:musix/logic/provider/signup_provider.dart';
import 'package:provider/provider.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SignupProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: provider.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 250,
                width: 250,
                child: Image.asset('assets/images/signup.jpg'),
              ),
              if (provider.errormsg.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: Text(
                    provider.errormsg,
                    style: const TextStyle(color: Colors.red),
                  ),
                ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextFormField(
                  controller: provider.emailController,
                  decoration: const InputDecoration(
                    focusedBorder: OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(),
                    labelText: 'Email',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    // Optional: Add more validation for email format if needed
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Consumer<PasswordVisiblityProvider>(
                  builder: (context, passwordVisibility, child) {
                    return TextFormField(
                      controller: provider.passwordController,
                      obscureText: passwordVisibility.isvisible,
                      decoration: InputDecoration(
                        suffixIcon: InkWell(
                          onTap: () {
                            passwordVisibility.setVisiblity();
                          },
                          child: Icon(
                            passwordVisibility.isvisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                        ),
                        labelText: 'Password',
                        focusedBorder: const OutlineInputBorder(),
                        enabledBorder: const OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        }
                        return null;
                      },
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Consumer<CpasswordVisibility>(
                  builder: (context, cpasswordVisibility, child) {
                    return TextFormField(
                      controller: provider.cpasswordController,
                      obscureText: cpasswordVisibility.isVisible,
                      decoration: InputDecoration(
                        suffixIcon: InkWell(
                          onTap: () {
                            cpasswordVisibility.toggleVisibility();
                          },
                          child: Icon(
                            cpasswordVisibility.isVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                        ),
                        labelText: 'Confirm Password',
                        focusedBorder: const OutlineInputBorder(),
                        enabledBorder: const OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please confirm your password';
                        }
                        if (value != provider.passwordController.text) {
                          return 'Passwords do not match';
                        }
                        return null;
                      },
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: ElevatedButton(
                  onPressed: provider.isLoading ? null : provider.signUp,
                  child: provider.isLoading
                      ? const CircularProgressIndicator()
                      : const Text('Sign Up'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
