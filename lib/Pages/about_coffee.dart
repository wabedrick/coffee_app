
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DataScreen extends StatefulWidget {
  final String itemId;

  const DataScreen({Key? key, required this.itemId}) : super(key: key);

  @override
  _DataScreenState createState() => _DataScreenState();
}

class _DataScreenState extends State<DataScreen> {
  String data = '';

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      // Make API request and fetch data
      var response = await http.get(Uri.parse('https://example.com/api/items/${widget.itemId}'));
      
      if (response.statusCode == 200) {
        // Parse the response body
        var responseData = jsonDecode(response.body);
        
        // Extract the required data
        var itemData = responseData['data'];
        
        // Update the state with the fetched data
        setState(() {
          data = itemData;
        });
      } else {
        // Handle error case
        setState(() {
          data = 'Failed to fetch data';
        });
      }
    } catch (error) {
      // Handle exception
      setState(() {
        data = 'Error: $error';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Item Details'),
      ),
      body: Center(
        child: Text(data),
      ),
    );
  }
}
