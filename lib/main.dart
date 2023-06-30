import 'package:coffee_app/batch_results.dart';
import 'package:coffee_app/capture_batch.dart';
import 'package:coffee_app/dashboard.dart';
import 'package:coffee_app/loggingin.dart';
import 'package:coffee_app/scan_qrcode.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'auth_provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
    create: (context) => AuthProvider(),
    child: const Home(),
    )
    );
}

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/': (context) => HomePage(), // Home screen route
        '/dashboard': (context) => const Dashboard(), // Dashboard screen route
        '/captureBatch':(context) => const CaptureBatch(),
        '/scanQRcode': (context) => const QRCodeScannerScreen(),
        '/batchResult': (context) => const BatchResult(qrCode: '',),
        '/login':(context) =>  HomePage(),
      },
      initialRoute: '/',
    );
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