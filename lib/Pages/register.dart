import 'package:coffee_app/Constants/api.dart';
import 'package:coffee_app/Pages/Models/users.dart';
import 'package:coffee_app/Pages/dashboard.dart';
import 'package:coffee_app/main.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final TextEditingController _firstNameController = TextEditingController();

  final TextEditingController _lastNameController = TextEditingController();

  final TextEditingController _locationController = TextEditingController();

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _phoneNumberController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  final TextEditingController _confirmPasswordController =
      TextEditingController();

  bool registering = false;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Future<void> _register(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      if (_passwordController.text != _confirmPasswordController.text) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Passwords do not match.',
              textAlign: TextAlign.center,
            ),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      setState(() {
        registering = true;
      });

      final formData = {
        'name': "${_firstNameController.text} ${_lastNameController.text}",
        'location': _locationController.text,
        'email': _emailController.text,
        'phone': _phoneNumberController.text,
        'password': _confirmPasswordController.text
      };

      await registerUser(formData).then((res) async {
        setState(() {
          registering = false;
        });
        if (res["status"] == "done") {
          loginUser(
                  email: _emailController.text,
                  password: _passwordController.text)
              .then((res) async {
            if (res["message"] != "failed") {
              User user = User.fromJson(res["data"]);
              context.read<AuthService>().setUser(user);
              SharedPreferences prefs = await SharedPreferences.getInstance();
              await prefs.setString('userEmail', user.email);

              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const Dashboard()),
              );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Invalid email or password')),
              );
            }
          });
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                backgroundColor: Colors.red,
                content: Text('Error occurred during registration.')),
          );
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Registration Form'),
          centerTitle: true,
          backgroundColor: Colors.brown[900],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _firstNameController,
                  decoration: const InputDecoration(
                    labelText: 'First Name',
                    labelStyle: TextStyle(color: Colors.brown),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your first name.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  controller: _lastNameController,
                  decoration: const InputDecoration(
                    labelText: 'Last Name',
                    labelStyle: TextStyle(color: Colors.brown),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your last name.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  controller: _locationController,
                  decoration: const InputDecoration(
                    labelText: 'Location',
                    labelStyle: TextStyle(color: Colors.brown),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your country.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    labelStyle: TextStyle(color: Colors.brown),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email.';
                    }
                    if (!value.contains('@')) {
                      return 'Please enter a valid email address.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  controller: _phoneNumberController,
                  decoration: const InputDecoration(
                    labelText: 'Phone number',
                    labelStyle: TextStyle(color: Colors.brown),
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your phone.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  controller: _passwordController,
                  decoration: const InputDecoration(
                    labelText: 'Password',
                    labelStyle: TextStyle(color: Colors.brown),
                  ),
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a password.';
                    }
                    if (value.length < 8) {
                      return 'Password must be at least 8 characters long.';
                    }
                    return null;
                    // if (!value.contains(RegExp(r'[A-Z]'))) {
                    //   return 'Password must contain at least one uppercase letter.';
                    // }
                    // if (!value.contains(RegExp(r'[a-z]'))) {
                    //   return 'Password must contain at least one lowercase letter.';
                    // }
                    // if (!value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
                    //   return 'Password must contain at least one special character.';
                    // }
                    // return null;
                  },
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  controller: _confirmPasswordController,
                  decoration: const InputDecoration(
                    labelText: 'Confirm Password',
                    labelStyle: TextStyle(color: Colors.brown),
                  ),
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the confirmation password.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),
                Row(
                  children: [
                    Expanded(
                      child: (!registering)
                          ? ElevatedButton(
                              onPressed: () => _register(context),
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.brown),
                                foregroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.white),
                                padding: MaterialStateProperty.all<
                                    EdgeInsetsGeometry>(
                                  const EdgeInsets.symmetric(
                                    vertical: 16.0,
                                    horizontal: 14.0,
                                  ),
                                ),
                              ),
                              child: const Text('Register'),
                            )
                          : Container(
                              width: 25,
                              height: 25,
                              margin: const EdgeInsets.symmetric(vertical: 10),
                              alignment: Alignment.center,
                              child: CircularProgressIndicator(
                                color: Colors.brown[600],
                              ),
                            ),
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
