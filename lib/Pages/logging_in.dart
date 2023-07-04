import 'dart:convert';

import 'package:coffee_app/Pages/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../Constants/api.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  

  String _message = '';

  Future<void> _login() async {
    String email = _emailController.text;
    String password = _passwordController.text;

    var url = Uri.parse(loginApi);
    var response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'email': email, 'password': password}),
    );

    if (response.statusCode == 200) {
      // Login successful
      setState(() {
        _message = 'Login successful!';

      });

      // Do something with the response data, if needed
      var responseData = json.decode(response.body);

        // ignore: use_build_context_synchronously
        Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const Dashboard(),
        ),
      );
      // ...

    } else {
      // Login failed
      setState(() {
        _message = 'Invalid credentials. Please try again.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: _login,
              child: Text('Login'),
            ),
            SizedBox(height: 20.0),
            Text(_message),
          ],
        ),
      ),
    );
  }
}

                  




// import 'dart:convert';

// import 'package:coffee_app/Pages/dashboard.dart';
// import 'package:coffee_app/Pages/register.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
// import 'package:provider/provider.dart';

// import '../Constants/api.dart';
// import 'auth_provider.dart';

// // ignore: must_be_immutable
// class HomePage extends StatefulWidget {
//   HomePage({Key? key}) : super(key: key);

//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//   final String correctEmail = 'wabwiireedrick@gmail.com';
//   final String correctPassword = 'yesorno12';

//   String _email = '';
//   String _password = '';
  
//   get dio => null;

//   Future<String> loginUser(String email, String password) async {
//     // final response = await http.post(
//     //   Uri.parse(loginApi), // Replace `loginApi` with your actual API endpoint
//     //   headers: {
//     //     'Content-Type': 'application/json',
//     //   },
//     //   body: json.encode({
//     //     'username': email,
//     //     'password': password,
//     //   }),
//     // );
//     final response = await dio.get(loginApi, queryParameters: {
//       'username': email,
//       'password': password,
//     });

//     if (response.statusCode == 200) {
//       // Login successful, extract the token from the response
//       final token = json.decode(response.body)['token'];
//       return token;
//     } else {
//       // Login failed
//       throw Exception('Failed to login');
//     }
//   }

//   void _submitLoginForm(BuildContext context) async {
//     try {
//       String token = await loginUser(_email, _password);
//       // ignore: use_build_context_synchronously
//       final authProvider = Provider.of<AuthProvider>(context, listen: false);
//       authProvider.setToken(token);
    
//       // ignore: use_build_context_synchronously
//       Navigator.push(
//         context,
//         MaterialPageRoute(builder: (context) => const Dashboard()),
//       );
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Invalid email or password')),
//       );
//     }
//   }

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   bool isKeyboardVisible = false;

//   @override
//   void initState() {
//     super.initState();

//     KeyboardVisibilityController().onChange.listen((bool visible) {
//       setState(() {
//         isKeyboardVisible = visible;
//       });
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         title: const Text('The Coffee App'),
//         centerTitle: true,
//         backgroundColor: Colors.brown[900],
//         elevation: 0.0,
//       ),
//       body: isKeyboardVisible ? SingleChildScrollView(child: buildLoginForm()) : buildLoginForm(),
//     );
//   }

//   Widget buildLoginForm() {
//     return SingleChildScrollView(
//       child: Container(
//         padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const Text(
//               'COFFEE QUALITY',
//               style: TextStyle(
//                 color: Colors.black,
//                 letterSpacing: 2.0,
//                 fontSize: 28.0,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             const SizedBox(height: 30.0),
//             const Row(
//               children: [
//                 Expanded(
//                   flex: 1,
//                   child: Image(
//                     image: AssetImage('assets/roasted_coffee_beans.jpg'),
//                     height: 200.0,
//                     fit: BoxFit.fill,
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 30.0),
//             const Text(
//               'Login Your Account',
//               style: TextStyle(
//                 color: Colors.black,
//                 letterSpacing: 2.0,
//                 fontSize: 28.0,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             const SizedBox(height: 30.0),
//             Form(
//               key: widget._formKey,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.stretch,
//                 children: <Widget>[
//                   TextFormField(
//                     decoration: const InputDecoration(
//                       labelText: 'Email',
//                       border: OutlineInputBorder(),
//                     ),
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return 'Please enter your email';
//                       }
//                       return null;
//                     },
//                     onSaved: (value) {
//                       widget._email = value!;
//                     },
//                   ),
//                   const SizedBox(height: 16.0),
//                   TextFormField(
//                     decoration: const InputDecoration(
//                       labelText: 'Password',
//                       border: OutlineInputBorder(),
//                     ),
//                     obscureText: true,
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return 'Please enter your password';
//                       }
//                       return null;
//                     },
//                     onSaved: (value) {
//                       widget._password = value!;
//                     },
//                   ),
//                   const SizedBox(height: 16.0),
//                   ElevatedButton(
//                     onPressed: () => widget._submitLoginForm(context),
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.brown[600],
//                       foregroundColor: Colors.white,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(32.0),
//                       ),
//                     ),
//                     child: const Text(
//                       'Login',
//                       style: TextStyle(
//                         fontSize: 16.0,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             GestureDetector(
//               onTap: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => Register()),
//                 );
//               },
//               child: const Text(
//                 'Register here',
//                 style: TextStyle(
//                   fontSize: 16.0,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.brown,
//                   decoration: TextDecoration.underline,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }


