import 'package:coffee_app/Pages/Models/users.dart';
import 'package:coffee_app/Pages/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Pages/auth_provider.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (context) => AuthProvider(),
    child: const Home(),
  ));
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthService>(create: (_) => AuthService()),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: true,
        home: Dashboard(),
      ),
    );
  }
}

class AuthService extends ChangeNotifier {
  User? user;

  User? get getUser => user;

  void setUser(User? currentUser) {
    user = currentUser;
    notifyListeners();
  }
}



// import 'package:coffee_app/dashboard.dart';
// import 'package:coffee_app/loggingin.dart';
// import 'package:flutter/material.dart';


// void main() {
//   runApp(const Home());
// }

// class Home extends StatefulWidget {
//   const Home({super.key});

//   @override
//   State<Home> createState() => _HomeState();
// }

// class _HomeState extends State<Home> {

 
//   @override
//   Widget build(BuildContext context) {
//     return  const MaterialApp(

//          routes: {
//         '/': (context) => HomePage(), // Home screen route
//         '/dashboard': (context) => const Dashboard(), // Dashboard screen route// Profile screen route
//         // Add more routes as needed
//       },

//     );
//   }
// }