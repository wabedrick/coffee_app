// ignore_for_file: library_private_types_in_public_api
import 'dart:io';

import 'package:coffee_app/Constants/api.dart';
import 'package:coffee_app/Pages/Models/users.dart';
import 'package:coffee_app/Pages/batch_results.dart';
import 'package:coffee_app/main.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

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
  bool adding = false;

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
    User? user = Provider.of<AuthService>(context, listen: false).getUser;
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
                  decoration:
                      const InputDecoration(labelText: 'Moisture Content'),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter moisture content';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.number,
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
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.brown[400]!),
                  ),
                  child: Text(
                    (_image == null) ? 'Take Photo' : 'Change Photo',
                    style: const TextStyle(
                      fontSize: 16.0,
                      wordSpacing: 2.0,
                    ),
                  ),
                ),
                if (_image != null)
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 16.0),
                    height: 100,
                    child: Image.file(
                      File(_image!.path),
                      fit: BoxFit.contain,
                    ),
                  ),
                (!adding)
                    ? ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            if (_image != null) {
                              setState(() {
                                adding = true;
                              });
                              final formData = {
                                'type': _selectedType,
                                'grade': _selectedGrade,
                                'moisture_content': _moistureContent,
                                'image': _image!.path,
                                'cooperative': user!.id,
                              };
                              submitBatch(formData).then((res) {
                                setState(() {
                                  adding = false;
                                });
                                if (res["status"] == 'done') {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => BatchResult(
                                        batch: res["data"],
                                        capturing: true,
                                      ),
                                    ),
                                  );
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        backgroundColor: Colors.green,
                                        content: Text(
                                            'Batch captured successfully.')),
                                  );
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text('Error capturing batch')),
                                  );
                                }
                              });
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Please select a photo'),
                                ),
                              );
                            }
                          }
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Colors.brown[400]!),
                        ),
                        child: const Text(
                          'Submit',
                          style: TextStyle(
                            fontSize: 16.0,
                            wordSpacing: 2.0,
                          ),
                        ),
                      )
                    : Column(
                        children: [
                          const Text(
                            'Analysing photo. This should take a few seconds. Please wait...',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16.0,
                              wordSpacing: 2.0,
                            ),
                          ),
                          Container(
                            width: 30,
                            height: 30,
                            margin: const EdgeInsets.symmetric(vertical: 10),
                            alignment: Alignment.center,
                            child: CircularProgressIndicator(
                              color: Colors.brown[600],
                            ),
                          ),
                        ],
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
