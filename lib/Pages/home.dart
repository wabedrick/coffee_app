import 'package:coffee_app/Pages/dashboard.dart';
import 'package:coffee_app/Pages/register.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final String correctEmail = 'user@example.com';
  final String correctPassword = 'password';

  String _email = '';
  String _password = '';

  void _submitForm(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      if (_email == correctEmail && _password == correctPassword) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const Dashboard()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Invalid email or password')),
        );
      }
    }
  }

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('The Coffee App'),
        centerTitle: true,
        backgroundColor: Colors.brown[900],
        elevation: 0.0,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'COFFEE QUALITY',
              style: TextStyle(
                color: Colors.black,
                letterSpacing: 2.0,
                fontSize: 28.0,
                fontWeight: FontWeight.bold,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(height: 30.0),
            const Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Image(
                    image: AssetImage('assets/roasted_coffee_beans.jpg'),
                    height: 200.0,
                    fit: BoxFit.fill,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30.0),
            const Text(
              'Login Your Account',
              style: TextStyle(
                color: Colors.black,
                letterSpacing: 2.0,
                fontSize: 28.0,
                fontWeight: FontWeight.bold,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(height: 30.0),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Form(
                  key: widget._formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      TextFormField(
                        decoration: const InputDecoration(labelText: 'Email'),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your email';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          widget._email = value!;
                        },
                      ),
                      TextFormField(
                        decoration:
                            const InputDecoration(labelText: 'Password'),
                        obscureText: true,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your password';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          widget._password = value!;
                        },
                      ),
                      const SizedBox(height: 16.0),
                      ElevatedButton(
                        onPressed: () => widget._submitForm(context),
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
                    ],
                  ),
                ),
              ),
            ),
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
                'Register here',
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


// class HomePage extends StatefulWidget {
//    HomePage({super.key,});

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
//      State<HomePage> createState() => _HomePageState();
  
//   }

// class _HomePageState extends State<HomePage> {
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