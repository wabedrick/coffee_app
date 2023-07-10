import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class QRCodeScreen extends StatelessWidget {
  const QRCodeScreen({Key? key}) : super(key: key);

Future<List<int>> generateQRCode() async {
  final response = await http.get(Uri.parse('https://your-django-backend.com/qrcode/?data=your-data-here'));

  if (response.statusCode == 200) {
    return response.bodyBytes;
  } else {
    throw Exception('Failed to generate QR code');
  }
}


  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<int>>(
      future: generateQRCode(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            return Center(
              child: Image.memory(
                Uint8List.fromList(snapshot.data!),
                width: 200.0,
                height: 200.0,
              ),
            );
          } else if (snapshot.hasError) {
            return const Text('Failed to generate QR code');
          }
        }
        return const CircularProgressIndicator();
      },
    );
  }
}
