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

import 'package:coffee_app/Constants/api.dart';
import 'package:coffee_app/Pages/Models/users.dart';
import 'package:coffee_app/Pages/about_coffee.dart';
import 'package:coffee_app/Pages/capture_batch.dart';
import 'package:coffee_app/Pages/login.dart';
import 'package:coffee_app/Pages/scan_qrcode.dart';
import 'package:coffee_app/main.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
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

  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove("userEmail").then((value) {
      context.read<AuthService>().setUser(null);
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const Dashboard(),
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            backgroundColor: Colors.green,
            content: Text('Logged out successfully')),
      );
    });
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

  checkUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userEmail = prefs.getString('userEmail');
    if (userEmail != null) {
      fetchUsers(email: userEmail).then((users) async {
        if (users != null && users.isNotEmpty) {
          context.read<AuthService>().setUser(users.first);
        }
      });
    } else {
      context.read<AuthService>().setUser(null);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const LoginScreen(),
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    // checkUser();
  }

  @override
  Widget build(BuildContext context) {
    User? user = Provider.of<AuthService>(context, listen: false).getUser;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.brown[400],
        title: ((user != null))
            ? Text(
                user.name,
                style: const TextStyle(fontSize: 16),
              )
            : null,
        actions: [
          (user != null)
              ? GestureDetector(
                  onTap: logout,
                  child: Container(
                    margin: const EdgeInsets.all(8.0),
                    child: const Icon(Icons.logout),
                  ),
                )
              : Container(),
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
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        item(
                          user: user,
                          name: "Capture Batch",
                          image: "assets/coffeeBag.jpg",
                          onTap: () {
                            if (user != null) {
                              if (user.group == "Cooperative") {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => const CaptureBatch(),
                                  ),
                                );
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      backgroundColor: Colors.red,
                                      content: Text(
                                          'You need a cooperative account!')),
                                );
                              }
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    backgroundColor: Colors.red,
                                    content: Text('You need to login first!')),
                              );
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => const LoginScreen(),
                                ),
                              );
                            }
                          },
                        ),
                        const SizedBox(width: 50.0),
                        item(
                          user: user,
                          name: "Scan Qr code",
                          image: 'assets/qrImage.jpeg',
                          onTap: () {
                            if (user != null) {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => const QRCodeScannerScreen(),
                                ),
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    backgroundColor: Colors.red,
                                    content: Text('You need to login first!')),
                              );
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => const LoginScreen(),
                                ),
                              );
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 50.0),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        item(
                          user: user,
                          name: "About coffee",
                          image: 'assets/roasted_coffee_beans.jpeg',
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => const DataScreen(),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30.0),
          ],
        ),
      ),
    );
  }

  Widget item(
      {User? user,
      Widget? page,
      String? image,
      String? name,
      Function()? onTap}) {
    return Container(
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
        onTap: onTap!,
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(5),
              width: 120,
              height: 120,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: Image.asset(
                  image!,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Center(
              child: Text(
                name!,
                style: const TextStyle(fontSize: 17.0),
              ),
            ),
            const SizedBox(
              height: 4,
            )
          ],
        ),
      ),
    );
  }
}
