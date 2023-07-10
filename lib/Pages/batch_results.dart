import 'dart:io';

import 'package:coffee_app/Constants/api.dart';
import 'package:coffee_app/Pages/Models/users.dart';
import 'package:coffee_app/Pages/capture_batch.dart';
import 'package:coffee_app/Pages/scan_qrcode.dart';
import 'package:coffee_app/main.dart';
import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:screenshot/screenshot.dart';
// import 'package:coffee_app/capture_batch.dart';

class BatchResult extends StatefulWidget {
  BatchResult({super.key, required this.batch, this.capturing});
  dynamic batch;
  bool? capturing;

  @override
  State<BatchResult> createState() => _BatchResultState();
}

class _BatchResultState extends State<BatchResult> {
  Future<Map<String, dynamic>>? _futureBatchResults;
  bool accepted = false;
  bool accepting = false;
  File? testFile;

  @override
  void initState() {
    super.initState();
    User? user = Provider.of<AuthService>(context, listen: false).getUser;
    if (widget.batch["batch_string"] != null &&
        user!.group == "Cooperative" &&
        widget.capturing != null) {
      saveCode();
    }
  }

  Future<void> exporterUpdateBatch(User user) async {
    await updateBatch(user, widget.batch["batch_string"]).then((res) {
      if (res == "done") {
        setState(() {
          accepting = false;
          accepted = true;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              backgroundColor: Colors.green,
              content: Text('Batch updated successfully.')),
        );
      } else {
        setState(() {
          accepting = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              backgroundColor: Colors.red,
              content: Text('Error updating batch.')),
        );
      }
    });
  }

  Future<void> exporterBuyerBatch(User user) async {
    await updateBuyerBatch(user, widget.batch["batch_string"]).then((res) {
      if (res == "done") {
        setState(() {
          accepting = false;
          accepted = true;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              backgroundColor: Colors.green,
              content: Text('Batch updated successfully.')),
        );
      } else {
        setState(() {
          accepting = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              backgroundColor: Colors.red,
              content: Text('Error updating batch.')),
        );
      }
    });
  }

  Future<void> saveCode() async {
    final controller = ScreenshotController();
    final bytes = await controller.captureFromWidget(
      Material(
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          alignment: Alignment.center,
          color: Colors.brown[100],
          height: double.infinity,
          width: double.infinity,
          child: QrImage(
            data: widget.batch["batch_string"],
            version: QrVersions.auto,
            backgroundColor: Colors.white,
            size: 200,
            gapless: false,
          ),
        ),
      ),
    );

    final temp = await getTemporaryDirectory();
    final path = '${temp.path}/batch-${widget.batch["id"]}.jpg';
    File(path).writeAsBytesSync(bytes);

    GallerySaver.saveImage(path, albumName: "CQTS").then((value) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.green,
          content: Text('QRCode saved successfully'),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    User? user = Provider.of<AuthService>(context, listen: false).getUser;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Batch details'),
        centerTitle: true,
        backgroundColor: Colors.brown[400],
      ),
      backgroundColor: Colors.brown[50],
      body: ListView(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            height: 200,
            color: Colors.white,
            alignment: Alignment.center,
            child: (widget.batch["batch_string"] != null)
                ? QrImage(
                    data: widget.batch["batch_string"],
                    version: QrVersions.auto,
                    backgroundColor: Colors.white,
                    size: 180,
                    gapless: false,
                  )
                : const Text(
                    "No QR code provided.",
                    style: TextStyle(fontSize: 20.0),
                  ),
          ),
          detail("Type", widget.batch["type"]),
          detail("Grade", widget.batch["grade"]),
          detail("Moisture", widget.batch["moisture_content"].toString()),
          detail("Color", widget.batch["color"]),
          const SizedBox(
            height: 10,
          ),
          if (user!.group == "Cooperative" && widget.capturing != null)
            Container(
              width: double.infinity,
              margin: const EdgeInsets.symmetric(horizontal: 8),
              alignment: Alignment.center,
              child: (widget.batch["batch_string"] != null)
                  ? const Text(
                      "QR code is automatically saved to pictures/CQTS.",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 20.0, color: Colors.green),
                    )
                  : const Text(
                      "This batch does not meet the minimum quality requirements.",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 17.0, color: Colors.red),
                    ),
            ),
          if (user.group == "Cooperative" && widget.capturing != null)
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child: ElevatedButton(
                onPressed: () async {
                  Navigator.pop(context);
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const CaptureBatch(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.brown[600],
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32.0),
                  ),
                ),
                child: const Text(
                  'capture new batch',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          if (user.group == "Cooperative" && widget.capturing == null)
            Container(
              width: double.infinity,
              margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child: ElevatedButton(
                onPressed: () async {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => const QRCodeScannerScreen(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.brown[600],
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32.0),
                  ),
                ),
                child: const Text(
                  'Scan another batch',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          const SizedBox(
            height: 10,
          ),
          if (user.group == "Exporter")
            (!accepted)
                ? (!accepting)
                    ? Container(
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              accepting = true;
                            });
                            exporterUpdateBatch(user);
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Colors.brown[400]!),
                          ),
                          child: const Text(
                            'Accept Batch',
                            style: TextStyle(
                              fontSize: 16.0,
                              wordSpacing: 2.0,
                            ),
                          ),
                        ),
                      )
                    : Container(
                        width: 30,
                        height: 30,
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        alignment: Alignment.center,
                        child: CircularProgressIndicator(
                          color: Colors.brown[600],
                        ),
                      )
                : Column(
                    children: [
                      const Text(
                        "Batch accepted successfully!",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 17.0, color: Colors.green),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: double.infinity,
                        margin:
                            const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                        child: ElevatedButton(
                          onPressed: () async {
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (context) =>
                                    const QRCodeScannerScreen(),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.brown[600],
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(32.0),
                            ),
                          ),
                          child: const Text(
                            'Scan another batch',
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
          if (user.group == "Buyer")
            (!accepted)
                ? (!accepting)
                    ? Container(
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              accepting = true;
                            });
                            exporterBuyerBatch(user);
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Colors.brown[400]!),
                          ),
                          child: const Text(
                            'Buy Batch',
                            style: TextStyle(
                              fontSize: 16.0,
                              wordSpacing: 2.0,
                            ),
                          ),
                        ),
                      )
                    : Container(
                        width: 30,
                        height: 30,
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        alignment: Alignment.center,
                        child: CircularProgressIndicator(
                          color: Colors.brown[600],
                        ),
                      )
                : Column(
                    children: [
                      const Text(
                        "Batch bought successfully!",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 17.0, color: Colors.green),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: double.infinity,
                        margin:
                            const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                        child: ElevatedButton(
                          onPressed: () async {
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (context) =>
                                    const QRCodeScannerScreen(),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.brown[600],
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(32.0),
                            ),
                          ),
                          child: const Text(
                            'Scan another batch',
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      )
                    ],
                  )
        ],
      ),
    );
  }

  Widget detail(String name, String value) {
    return Container(
      margin: const EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 0),
      padding: const EdgeInsets.all(8),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            name,
            style: const TextStyle(fontSize: 17.0, color: Colors.black54),
          ),
          Text(
            value,
            style: TextStyle(fontSize: 20.0, color: Colors.blue[400]),
          ),
        ],
      ),
    );
  }
}
