// import 'dart:io';
// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

class CaptureBatch extends StatefulWidget {
  const CaptureBatch({super.key});

  @override
  _CaptureBatchState createState() => _CaptureBatchState();
}

class _CaptureBatchState extends State<CaptureBatch> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  String _selectedCoffeeType = '';

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    final cameras = await availableCameras();
    final firstCamera = cameras.first;

    _controller = CameraController(firstCamera, ResolutionPreset.medium);
    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _saveForm() {
    if (_formKey.currentState!.validate()) {
      // Save form data
      String name = _nameController.text;
      // Do something with the captured photo
      // ...
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registration'),
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          Form(
            key: _formKey,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: TextFormField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                      labelText: 'Name',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your name';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: DropdownButtonFormField<String>(
                    value: _selectedCoffeeType,
                    onChanged: (value) {
                      setState(() {
                        _selectedCoffeeType = value!;
                      });
                    },
                    decoration: const InputDecoration(
                      labelText: 'Coffee Type',
                      border: OutlineInputBorder(),
                    ),
                    items: const [
                      DropdownMenuItem(
                        value: 'Espresso',
                        child: Text('Espresso'),
                      ),
                      DropdownMenuItem(
                        value: 'Cappuccino',
                        child: Text('Cappuccino'),
                      ),
                      DropdownMenuItem(
                        value: 'Latte',
                        child: Text('Latte'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: FutureBuilder<void>(
              future: _initializeControllerFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return CameraPreview(_controller);
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),
          ElevatedButton(
            onPressed: _saveForm,
            child: const Text('Register'),
          ),
        ],
      ),
    );
  }
}

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Registration App',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: RegistrationScreen(),
//     );
//   }
// }
