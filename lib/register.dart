import 'package:flutter/material.dart';


class Register extends StatelessWidget {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Register({super.key});

  void _register(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      // String firstName = _firstNameController.text;
      // String lastName = _lastNameController.text;
      // String country = _countryController.text;
      // String email = _emailController.text;
      // String password = _passwordController.text;

      // Perform registration logic here, e.g., API call, database update, etc.
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Registration Successful',
            textAlign: TextAlign.center,
            ),
          backgroundColor: Colors.brown,

        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Builder(
        builder: (context) {
          return Scaffold(
             resizeToAvoidBottomInset : false,
            appBar: AppBar(
              title: const Text('Registration Form'),
              centerTitle: true,
              backgroundColor: Colors.brown[900],

            ),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _firstNameController,
                      decoration: const InputDecoration(
                        labelText: 'FirstName',
                        labelStyle: TextStyle(color: Colors.brown),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your firstname.';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16.0),
                
                    TextFormField(
                      controller: _lastNameController,
                      decoration: const InputDecoration(
                        labelText: 'LastName',
                        labelStyle: TextStyle(color: Colors.brown),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your lastname.';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16.0),
                
                    TextFormField(
                      controller: _countryController,
                      decoration: const InputDecoration(
                        labelText: 'Country',
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
                        // Add email validation logic here if required
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
                        // Add password validation logic here if required
                        return null;
                      },
                    ),
                    const SizedBox(height: 16.0),

                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () => _register(context),
                            style: ButtonStyle(
                            //  backgroundColor: Colors.brown, // Set the button background color to brown
                             backgroundColor: MaterialStateProperty.all<Color>(Colors.brown), // Change button background color
                              foregroundColor: MaterialStateProperty.all<Color>(Colors.white), // Change button text color
                              padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                                const EdgeInsets.symmetric(vertical: 16.0, horizontal: 14.0), // Change button padding                             
                            ),
                          ),
                            child: const Text('Register'),
                          ),
                          ),
                      ],
                    )],
                ),
              ),
            ),
          );
        }
      ),
    );
  }
}