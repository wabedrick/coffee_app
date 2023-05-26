// import 'package:flutter/material.dart';


// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       title: 'Flutter Demo',
//       home: UIPage(),
//     );
//   }
// }

// class UIPage extends StatefulWidget {
//   const UIPage({super.key});

//   @override
//   // ignore: library_private_types_in_public_api
//   _UIPageState createState() => _UIPageState();
// }

// class _UIPageState extends State<UIPage> {
//   int _selectedIndex = 0;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Flutter Demo'),
//       ),
//       body: IndexedStack(
//         index: _selectedIndex,
//         children: const <Widget>[
//           // First page
//           Text('This is the first page.'),

//           // Second page
//           Text('This is the second page.'),

//           // Third page
//           Text('This is the third page.'),
//         ],
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//         items: const <BottomNavigationBarItem>[
//           BottomNavigationBarItem(
//             icon: Icon(Icons.home),
//             label: 'Home',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.settings),
//             label: 'Settings',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.person),
//             label: 'Profile',
//           ),
//         ],
//         currentIndex: _selectedIndex,
//         onTap: (int index) {
//           setState(() {
//             _selectedIndex = index;
//           });
//         },
//       ),
//     );
//   }
// }
import 'package:logger/logger.dart';
import 'package:flutter/material.dart';

class UIPage extends StatefulWidget {
   const UIPage({super.key});

  @override
  State<UIPage> createState() => _UIPageState();
}

class _UIPageState extends State<UIPage> {
  var logger = Logger();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Clickable Cards Example'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  // Handle card 1 click action
                  logger.d('Card 1 clicked!');
                },
                child: Card(
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.asset(
                        'assets/coffeeBag.jpg',
                        fit: BoxFit.cover,
                      ),
                      const Center(
                        child: Text(
                          'Card 1',
                          style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              GestureDetector(
                onTap: () {
                  // Handle card 2 click action
                  logger.d('Card 2 clicked!');
                },
                child: Card(
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.asset(
                        'assets/qrImage.jpeg',
                        fit: BoxFit.cover,
                      ),
                      const Center(
                        child: Text(
                          'Card 2',
                          style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              GestureDetector(
                onTap: () {
                  // Handle card 3 click action
                  logger.d('Card 3 clicked!');
                },
                child: Card(
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.asset(
                        'assets/appstore.png',
                        fit: BoxFit.cover,
                      ),
                      const Center(
                        child: Text(
                          'Card 3',
                          style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              GestureDetector(
                onTap: () {
                  // Handle card 4 click action
                  logger.d('Card 4 clicked!');
                },
                child: Card(
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.asset(
                        'assets/roasted_coffee_beans.jpg',
                        fit: BoxFit.cover,
                      ),
                      const Center(
                        child: Text(
                          'Card 4',
                          style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
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
