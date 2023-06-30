// import 'package:coffee_app/about_coffee.dart';
// import 'package:coffee_app/batch_results.dart';
// import 'package:coffee_app/capture_batch.dart';
// import 'package:coffee_app/scan_qrcode.dart';
// import 'package:flutter/material.dart';
// import 'package:logger/logger.dart';

// class Dashboard extends StatefulWidget {
//   const Dashboard({Key? key}) : super(key: key);

//   @override
//   State<Dashboard> createState() => _DashboardState();
// }

// class _DashboardState extends State<Dashboard> {
//   final logger = Logger();
//   String qrCode = '';
//   String userName = 'Edrick';
//   String avatarImage = 'assets/avatar.png';

//   void logout() {
//     // Perform logout logic here
//     logger.d('User logged out');
//     // Navigate to login page
//     Navigator.of(context).pushReplacementNamed('/login');
//   }

//   String getBatchImage(double radius) {
//     if (radius < 120) {
//       return 'assets/coffeeBag.jpg';
//     } else {
//       return 'assets/coffeeBag_large.jpg';
//     }
//   }

//   String getQRImage(double radius) {
//     if (radius < 120) {
//       return 'assets/qrImage.jpeg';
//     } else {
//       return 'assets/qrImage_large.jpeg';
//     }
//   }

//   String getResultsImage(double radius) {
//     if (radius < 120) {
//       return 'assets/results.jpg';
//     } else {
//       return 'assets/results_large.jpg';
//     }
//   }

import 'package:coffee_app/capture_batch.dart';
import 'package:coffee_app/scan_qrcode.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
// import 'package:coffee_app/about_coffee.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final logger = Logger();
  String qrCode = '';
  String userName = 'Edrick';
  String avatarImage = 'assets/avatar.png';

  void logout() {
    // Perform logout logic here
    logger.d('User logged out');
    // Navigate to login page
    Navigator.of(context).pushReplacementNamed('/login');
  }

  String getBatchImage(double radius) {
    if (radius < 120) {
      return 'assets/coffeeBag.jpg';
    } else {
      return 'assets/coffeeBag_large.jpg';
    }
  }

  String getQRImage(double radius) {
    if (radius < 120) {
      return 'assets/qrImage.jpeg';
    } else {
      return 'assets/qrImage_large.jpeg';
    }
  }

  String getResultsImage(double radius) {
    if (radius < 120) {
      return 'assets/results.jpg';
    } else {
      return 'assets/results_large.jpg';
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.brown[400],
          actions: [
            GestureDetector(
              onTap: logout,
              child: Container(
                margin: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 16,
                      backgroundImage: AssetImage(avatarImage),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      userName,
                      style: const TextStyle(fontSize: 16),
                    ),
                    const Icon(Icons.logout),
                  ],
                ),
              ),
            ),
          ],
        ),
        body: Container(
          color: Colors.brown[200],
          child: Column(
            children: [
              // const SizedBox(height: 10.0),
              Container(
                color: Colors.brown[200],
                child: Image.asset(
                  'assets/appstore2.png',
                  height: 150,
                  width: 150,
                  // fit: BoxFit.fitWidth,
                ),
              ),
              const SizedBox(height: 10.0),
              const Center(
                child: Text(
                  'CQTS',
                  style: TextStyle(
                    fontSize: 28.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 10.0),
              Container(
                padding: const EdgeInsets.fromLTRB(32.0, 0, 10.0, 0),
                margin: const EdgeInsets.fromLTRB(0.0, 2.0, 0.0, 2.0),
                child: Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Column(
                        children: [
                          SizedBox(height: 20.0),
                        ],
                      ),
                      const SizedBox(height: 10.0),
                      Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.brown[100],
                              borderRadius: BorderRadius.circular(10.0),
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.black26,
                                  offset: Offset(0, 2),
                                  blurRadius: 6.0,
                                ),
                              ],
                            ),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => const CaptureBatch(),
                                  ),
                                );
                              },
                              child: Column(
                                children: [
                                  SizedBox(
                                    width: 120,
                                    height: 120,
                                    child: Image.asset(
                                      getBatchImage(100), // Update radius value
                                      height: 80,
                                      width: 100,
                                      // fit: BoxFit.fitWidth,
                                    ),
                                  ),
                                  const Center(
                                    child: Text(
                                      'Capture Batch',
                                      style: TextStyle(fontSize: 20.0),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(width: 60.0),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.brown[100],
                              borderRadius: BorderRadius.circular(10.0),
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.black26,
                                  offset: Offset(0, 2),
                                  blurRadius: 6.0,
                                ),
                              ],
                            ),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => const QRCodeScannerScreen(),
                                  ),
                                );
                              },
                              child: Column(
                                children: [
                                  SizedBox(
                                    width: 120,
                                    height: 120,
                                    child: Image.asset(
                                      getQRImage(100), // Update radius value
                                      height: 80,
                                      width: 100,
                                      // fit: BoxFit.fitWidth,
                                    ),
                                  ),
                                  const Center(
                                    child: Text(
                                      'Scan QR Code',
                                      style: TextStyle(fontSize: 20.0),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 60.0),
                      Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.brown[100],
                              borderRadius: BorderRadius.circular(10.0),
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.black26,
                                  offset: Offset(0, 2),
                                  blurRadius: 6.0,
                                ),
                              ],
                            ),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => NextScreen(qrCode: qrCode),
                                  ),
                                );
                              },
                              child: Column(
                                children: [
                                  SizedBox(
                                    width: 140,
                                    height: 120,
                                    child: Image.asset(
                                      getResultsImage(100), // Update radius value
                                      height: 80,
                                      width: 100,
                                      // fit: BoxFit.fitWidth,
                                    ),
                                  ),
                                  const Center(
                                    child: Text(
                                      'View Results',
                                      style: TextStyle(fontSize: 20.0),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          const SizedBox(width: 60.0),

                          Container(
                            decoration: BoxDecoration(
                              color: Colors.brown[100],
                              borderRadius: BorderRadius.circular(10.0),
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.black26,
                                  offset: Offset(0, 2),
                                  blurRadius: 6.0,
                                ),
                              ],
                            ),
                            child: GestureDetector(
                              onTap: () {
                                // Navigator.of(context).push(
                                //   MaterialPageRoute(
                                //     builder: (context) => const BatchResult(qrCode: '',),
                                //   ),
                                // );
                                Navigator.pushReplacementNamed(context, '/batchResult');
                              },

                              child: Column(
                                children: [
                                  SizedBox(
                                    width: 140,
                                    height: 120,
                                    child: Image.asset(
                                      'assets/coffee.jpeg',
                                      height: 80,
                                      width: 80,
                                      fit: BoxFit.fitWidth,
                                    ),
                                  ),
                                  const Center(
                                    child: Text(
                                      'About Coffee',
                                      style: TextStyle(fontSize: 20.0),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 30.0),
              Container(
                color: Colors.brown[200],
                child: GestureDetector(
                  onTap: () {
                    logger.d('Link to the webapp');
                  },
                  child: const Text(
                    'Link to the webapp',
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 16.0,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
