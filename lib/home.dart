
import 'package:coffee_app/register.dart';
import 'package:flutter/material.dart';


class HomePage extends StatefulWidget {
   HomePage({super.key,});

   final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

   void _login(BuildContext context) {
    if (_formKey.currentState!.validate()) {
    
      String email = _emailController.text;
      String password = _passwordController.text;

      // Perform registration logic here, e.g., API call, database update, etc.
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Logged In Successful',
            textAlign: TextAlign.center,
            ),
          backgroundColor: Colors.brown,

        ),
      );
    }
  }

   
     @override
     State<HomePage> createState() => _HomePageState();
  
  }

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(

      resizeToAvoidBottomInset : false,
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
            const Row(
              children: [
                Text(
                'COFFEE QUALITY',
                
                style: TextStyle(
                  color: Colors.black,
                  letterSpacing: 2.0,
                  fontSize: 28.0,
                  fontWeight: FontWeight.bold,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
      
          ]),
      
            // Divider(
            //   height: 80.0,
            //   color: Colors.grey[800],
            // ),
           //Insert Image here
      
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
      
              const Row(
              children: [
                Text(
                'Login Your Account',
                
                style: TextStyle(
                  color: Colors.black,
                  letterSpacing: 2.0,
                  fontSize: 28.0,
                  fontWeight: FontWeight.bold,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
      
          ]),
      
      
          const SizedBox(height: 30.0),
         
         Expanded(
         child: Column(
           children: [
             const TextField(
              // focusNode: _focusNode,
              // controller: _emailController,
               decoration: InputDecoration(
                 border: OutlineInputBorder(),

                 focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.brown), // Change focused border color
                  ),

                 labelText: 'Email',

                  labelStyle: TextStyle(color: Colors.brown),

               ),

              //  validator: (value) {
              //           if (value == null || value.isEmpty) {
              //             return 'Please enter your firstname.';
              //           }
              //           return null;
             ),
         
             const SizedBox(height: 20.0),
             
             const TextField(
               obscureText: true,
               decoration: InputDecoration(
                 border: OutlineInputBorder(),

                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.brown), // Change border color
                  ),

                 labelText: 'Password',

                 labelStyle: TextStyle(color: Colors.brown),

               ),
             ),
             
              const SizedBox(height: 20.0),

              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {

                        
                      },

                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(Colors.brown), // Change button background color
                        foregroundColor: MaterialStateProperty.all<Color>(Colors.white), // Change button text color
                        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                          const EdgeInsets.symmetric(vertical: 16.0, horizontal: 14.0), // Change button padding
                        ),
                      ),
                      
                      child: const Text('Login'),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20.0),

               GestureDetector(
                onTap: () {
                  // Navigate to the registration page
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Register(),
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
          
        ]),

      ),
    );
  }
}