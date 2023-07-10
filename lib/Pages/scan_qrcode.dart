// ignore_for_file: library_private_types_in_public_api

import 'package:coffee_app/Constants/api.dart';
import 'package:coffee_app/Pages/batch_results.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
// import 'package:qr_code_scanner/qr_code_scanner.dart';

class QRCodeScannerScreen extends StatefulWidget {
  const QRCodeScannerScreen({super.key});

  @override
  _QRCodeScannerScreenState createState() => _QRCodeScannerScreenState();
}

class _QRCodeScannerScreenState extends State<QRCodeScannerScreen> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  // QRViewController? controller;
  String? qrCode = '';
  Future<Map<String, dynamic>>? _futureBatchResults;
  bool fetching = false;

  final controller = MobileScannerController(
    detectionSpeed: DetectionSpeed.normal,
    facing: CameraFacing.back,
    autoStart: true,
  );

  void fetchBatch(String batchString) {
    _futureBatchResults = getBatchDetails(batchString: batchString);
    _futureBatchResults!.then((res) async {
      if (res["message"] == "success") {
        controller.stop();
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => BatchResult(
              batch: res["data"],
            ),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              backgroundColor: Colors.red, content: Text('No such batch!')),
        );
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scan QR Code'),
        centerTitle: true,
        backgroundColor: Colors.brown[400],
      ),
      body: Center(
        child: Container(
          color: Colors.white.withOpacity(0.1),
          height: 300,
          margin: const EdgeInsets.symmetric(horizontal: 20),
          // width: double.infinity,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: MobileScanner(
              // fit: BoxFit.contain,
              controller: controller,
              onDetect: (capture) {
                final List<Barcode> barcodes = capture.barcodes;
                for (final barcode in barcodes) {
                  if (barcode.rawValue != null) {
                    String data = barcode.rawValue!;
                    print(
                        "this is the data $data--------------------------------");
                    fetchBatch(data);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        backgroundColor: Colors.red,
                        content: Text(
                          'Error scanning code',
                        ),
                      ),
                    );
                  }
                }
              },
            ),
          ),
        ),
      ),
    );
  }

  // void _onQRViewCreated(QRViewController controller) {
  //   setState(() {
  //     this.controller = controller;
  //   });

  //   controller.scannedDataStream.listen((scanData) {
  //     setState(() {
  //       qrCode = scanData.code;
  //     });
  //   });

  // }

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

  // @override
  // void dispose() {
  //   controller?.dispose();
  //   super.dispose();
  // }
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
