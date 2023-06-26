import 'package:coffee_app/capture_batch.dart';
import 'package:coffee_app/scan_qrcode.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  var logger = Logger();
  String qrCode = '';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.brown[400],
        ),
        body: Container(
          color: Colors.brown[200],
          child: Column(
            children: [
              const SizedBox(height: 10.0),
              Container(
                color: Colors.brown[200],
                child: Image.asset(
                  'assets/appstore2.png',
                  height: 150,
                  width: 150,
                  fit: BoxFit.fitWidth,
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
                                    width: 170,
                                    height: 150,
                                    child: Image.asset(
                                      'assets/coffeeBag.jpg',
                                      height: 150,
                                      width: 150,
                                      fit: BoxFit.fitWidth,
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
                          const SizedBox(width: 10.0),
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
                                    width: 170,
                                    height: 150,
                                    child: Image.asset(
                                      'assets/qrImage.jpeg',
                                      height: 150,
                                      width: 150,
                                      fit: BoxFit.fitWidth,
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
                      const SizedBox(height: 20.0),
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
                                    width: 170,
                                    height: 150,
                                    child: Image.asset(
                                      'assets/results.jpg',
                                      height: 80,
                                      width: 80,
                                      fit: BoxFit.fitHeight,
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
                          const SizedBox(width: 10.0),
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
                                // Handle card 4 click action
                                logger.d('My Account Info!');
                              },
                              child: Column(
                                children: [
                                  SizedBox(
                                    width: 170,
                                    height: 150,
                                    child: Image.asset(
                                      'assets/avatar.png',
                                      height: 100,
                                      width: 100,
                                      fit: BoxFit.fitWidth,
                                    ),
                                  ),
                                  const Center(
                                    child: Text(
                                      'My Account',
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
                      fontSize: 20.0,
                      color: Colors.black,
                      decoration: TextDecoration.underline,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
