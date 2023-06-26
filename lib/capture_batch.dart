
// ignore_for_file: library_private_types_in_public_api
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CaptureBatch extends StatefulWidget {
  const CaptureBatch({super.key});

  @override
  _CaptureBatchState createState() => _CaptureBatchState();
}

class _CaptureBatchState extends State<CaptureBatch> {
  final _formKey = GlobalKey<FormState>();
  final _picker = ImagePicker();
  XFile? _image;
  String? _selectedType;
  String? _selectedGrade;
  String? _moistureContent;

  final List<String> _types = ['Arabica', 'Robusta'];
  final List<String> _grades = ['Screen 12', 'Screen 15', 'Screen 18'];

  Future<void> _takePhoto() async {
    final pickedImage = await _picker.pickImage(source: ImageSource.camera);
    if (pickedImage != null) {
      setState(() {
        _image = pickedImage;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Coffee Batch Capture'),
        centerTitle: true,
        backgroundColor: Colors.brown[400],

      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(labelText: 'Type'),
                  value: _selectedType,
                  items: _types.map((String type) {
                    return DropdownMenuItem<String>(
                      value: type,
                      child: Text(type),
                    );
                  }).toList(),
                  onChanged: (String? value) {
                    setState(() {
                      _selectedType = value;
                    });
                  },
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select a type';
                    }
                    return null;
                  },
                ),
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(labelText: 'Grade'),
                  value: _selectedGrade,
                  items: _grades.map((String grade) {
                    return DropdownMenuItem<String>(
                      value: grade,
                      child: Text(grade),
                    );
                  }).toList(),

                  onChanged: (String? value) {
                    setState(() {
                      _selectedGrade = value;
                    });
                  },

                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select a grade';
                    }
                    return null;
                  },
                ),

                TextFormField(
                  decoration: const InputDecoration(labelText: 'Moisture Content'),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter moisture content';
                    }
                    return null;
                  },
                  onChanged: (String value) {
                    _moistureContent = value;
                  },
                ),

                const SizedBox(height: 16.0),

                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _takePhoto();
                    }
                  },

                   style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(Colors.brown[400]!),
                    ),

                  child: const Text(
                    'Take Photo',
                    style: TextStyle(
                      fontSize: 16.0,
                      wordSpacing: 2.0,
                      ),
                    ),

                ),

                if (_image != null)
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 16.0),
                    child: Image.file(File(_image!.path)),
                  ),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // Add your logic to save the form data
                      // and navigate to the next screen.
                    }
                  },

                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(Colors.brown[400]!),
                    ),

                  child: const Text(
                    'Submit',
                    style: TextStyle(
                      fontSize: 16.0,
                      wordSpacing: 2.0,
                      ),
                    ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
