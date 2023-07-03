// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QRCodeScannerScreen extends StatefulWidget {
  const QRCodeScannerScreen({super.key});

  @override
  _QRCodeScannerScreenState createState() => _QRCodeScannerScreenState();
}

class _QRCodeScannerScreenState extends State<QRCodeScannerScreen> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  QRViewController? controller;
  String? qrCode = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scan QR Code'),
        centerTitle: true,
        backgroundColor: Colors.brown[400],

      ),
      body: Column(
        children: [
          Expanded(
            child: QRView(
              key: qrKey,
              onQRViewCreated: _onQRViewCreated,
            ),
          ),
          // Text(
          //   'Scanned QR code is: $qrCode',
          //   style: const TextStyle(
          //     fontSize: 16,
          //     fontWeight: FontWeight.bold,
          //     wordSpacing: 2.0,
          //     ),
          //   ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () => _navigateToNextScreen(qrCode!),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.brown[400],
              foregroundColor: Colors.white,
            ),
            child: const Text('Continue'),
          ),
        ],
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });

    controller.scannedDataStream.listen((scanData) {
      setState(() {
        qrCode = scanData.code;
      });
    });
    
  }

  void _navigateToNextScreen(String qrCode) {
    // Implement your navigation logic here
    // For example:
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => NextScreen(qrCode: qrCode),
      ),
    );
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}

class NextScreen extends StatelessWidget {
  final String qrCode;

  const NextScreen({super.key, required this.qrCode});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('View Results of Scan'),
        centerTitle: true,
        backgroundColor: Colors.brown[400],
        titleSpacing: 2.0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Scanned QR code:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              qrCode,
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
