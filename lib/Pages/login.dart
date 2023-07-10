import 'package:coffee_app/Constants/api.dart';
import 'package:coffee_app/Pages/Models/users.dart';
import 'package:coffee_app/Pages/dashboard.dart';
import 'package:coffee_app/Pages/register.dart';
import 'package:coffee_app/main.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: must_be_immutable
class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool signingIn = false;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _submitForm(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      setState(() {
        signingIn = true;
      });
      loginUser(
              email: _emailController.text, password: _passwordController.text)
          .then((res) async {
        setState(() {
          signingIn = false;
        });
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
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('CQTS App'),
        centerTitle: true,
        backgroundColor: Colors.brown[900],
        elevation: 0.0,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const SizedBox(height: 30.0),
                  const Text(
                    'LOGIN',
                    style: TextStyle(
                      color: Colors.black,
                      letterSpacing: 2.0,
                      fontSize: 28.0,
                      fontWeight: FontWeight.bold,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(height: 30.0),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Email'),
                    controller: _emailController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your email';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Password'),
                    controller: _passwordController,
                    obscureText: true,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your password';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16.0),
                  (!signingIn)
                      ? SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () => _submitForm(context),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.brown[600],
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(32.0),
                              ),
                            ),
                            child: const Text(
                              'Login',
                              style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
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
                  const SizedBox(height: 10.0),
                  GestureDetector(
                    onTap: () {
                      // Navigate to the registration page
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Register(),
                        ),
                      );
                    },
                    child: const Text(
                      'Register as Buyer.',
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.brown,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// class SuccessPage extends StatelessWidget {
//   const SuccessPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const Scaffold(
//       body: Center(
//         child: Text('Success Page'),
//       ),
//     );
//   }
// }




// import 'package:coffee_app/register.dart';
// import 'package:flutter/material.dart';


// class LoginScreen extends StatefulWidget {
//    LoginScreen({super.key,});

//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//   final String correctEmail = 'user@example.com';
//   final String correctPassword = 'password';

//   final String _email = '';
//   final String _password = '';

//   void _submitForm(BuildContext context) {
//     if (_formKey.currentState!.validate()) {
//       if (_email == correctEmail && _password == correctPassword) {
//         Navigator.push(
//           context,
//           MaterialPageRoute(builder: (context) => SuccessPage()),
//         );
//       } else {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text('Invalid email or password')),
//         );
//       }
//     }
//   }
   
//      @override
//      State<LoginScreen> createState() => _LoginScreenState();
  
//   }

// class _LoginScreenState extends State<LoginScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return  Scaffold(

//       resizeToAvoidBottomInset : false,
//       backgroundColor: Colors.white,

//       appBar: AppBar(
//         title: const Text('The Coffee App'),
//         centerTitle: true,
//         backgroundColor: Colors.brown[900],
//         elevation: 0.0,
//       ),

//       body: Container(
//         padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0), 
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const Row(
//               children: [
//                 Text(
//                 'COFFEE QUALITY',
                
//                 style: TextStyle(
//                   color: Colors.black,
//                   letterSpacing: 2.0,
//                   fontSize: 28.0,
//                   fontWeight: FontWeight.bold,
//                   overflow: TextOverflow.ellipsis,
//                 ),
//               ),
      
//           ]),
      
//             // Divider(
//             //   height: 80.0,
//             //   color: Colors.grey[800],
//             // ),
//            //Insert Image here
      
//            const SizedBox(height: 30.0),
      
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
      
//              const SizedBox(height: 30.0),
      
//               const Row(
//               children: [
//                 Text(
//                 'Login Your Account',
                
//                 style: TextStyle(
//                   color: Colors.black,
//                   letterSpacing: 2.0,
//                   fontSize: 28.0,
//                   fontWeight: FontWeight.bold,
//                   overflow: TextOverflow.ellipsis,
//                 ),
//               ),
      
//           ]),
      
      
//           const SizedBox(height: 30.0),
         
//          Expanded(

//          child: Padding(

//            padding: const EdgeInsets.all(8.0),
//            child: Form(
//             key: _formKey,
            
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.stretch,
//               children: <Widget>[
//                 TextFormField(
//                   decoration: const InputDecoration(labelText: 'Email'),
//                   validator: (value) {
//                     if (value!.isEmpty) {
//                       return 'Please enter your email';
//                     }
//                     return null;
//                   },
//                   onSaved: (value) {
//                     _email = value!;
//                   },
//                 ),
//                 TextFormField(
//                   decoration: InputDecoration(labelText: 'Password'),
//                   obscureText: true,
//                   validator: (value) {
//                     if (value!.isEmpty) {
//                       return 'Please enter your password';
//                     }
//                     return null;
//                   },
//                   onSaved: (value) {
//                     _password = value!;
//                   },
//                 ),
//                 SizedBox(height: 16.0),
//                 ElevatedButton(
//                   onPressed: () => _submitForm(context),
//                   child: Text('Submit'),
//                 ),
//               ],
//             ),
         
//                  GestureDetector(
//                   onTap: () {
//                     // Navigate to the registration page
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => Register(),
//                       ),
//                     );
//                   },
                  
//                   child: const Text(
//                     'Register here',
//                     style: TextStyle(
//                       fontSize: 16.0,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.brown,
//                       decoration: TextDecoration.underline,
//                     ),
//                   ),
//                 ),
         
              
           
            
               
         
//                ),
//          ),
//     );
//   }
// }

// class Form extends StatelessWidget {
//   const Form({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return const TextField(
//      // focusNode: _focusNode,
//      // controller: _emailController,
//       decoration: InputDecoration(
//         border: OutlineInputBorder(),

//         focusedBorder: OutlineInputBorder(
//            borderSide: BorderSide(color: Colors.brown), // Change focused border color
//          ),

//         labelText: 'Email',

//          labelStyle: TextStyle(color: Colors.brown),

//       ),

//      //  validator: (value) {
//      //           if (value == null || value.isEmpty) {
//      //             return 'Please enter your firstname.';
//      //           }
//      //           return null;
//     );
//   }
// }