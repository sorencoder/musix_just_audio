import 'package:flutter/material.dart';
import 'package:musix/logic/provider/login_provider.dart';
import 'package:musix/logic/provider/password_visiblity.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LoginProvider>(context);
    return Scaffold(
      body: Form(
          child: Column(
        children: [
          SizedBox(
            height: 250,
            width: 250,
            child: Image.asset('assets/images/login.png'),
          ),
          (provider.errormsg != '')
              ? Text(
                  provider.errormsg,
                  style: const TextStyle(color: Colors.red),
                )
              : const SizedBox(),
          Padding(
            padding: const EdgeInsets.all(8),
            child: TextFormField(
              controller: provider.emailController,
              decoration: const InputDecoration(
                focusedBorder: OutlineInputBorder(),
                enabledBorder: OutlineInputBorder(),
                // disabledBorder: OutlineInputBorder(),
                labelText: 'email',
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Your email';
                }
                return null;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Consumer<PasswordVisiblityProvider>(
              builder: (context, value, child) {
                return TextFormField(
                  controller: provider.passwordController,
                  obscureText: value.isvisible,
                  decoration: InputDecoration(
                      suffixIcon: InkWell(
                          onTap: () {
                            Provider.of<PasswordVisiblityProvider>(context,
                                    listen: false)
                                .setVisiblity();
                          },
                          child: value.isvisible
                              ? const Icon(Icons.visibility)
                              : const Icon(Icons.visibility_off)),
                      labelText: 'password',
                      focusedBorder: const OutlineInputBorder(),
                      enabledBorder: const OutlineInputBorder()),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: ElevatedButton(
                onPressed: provider.signIn,
                child: (provider.isLoading)
                    ? const CircularProgressIndicator()
                    : const Text('Login')),
          )
        ],
      )),
    );
  }
}
