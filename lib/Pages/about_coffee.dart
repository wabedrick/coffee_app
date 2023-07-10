
import 'package:flutter/material.dart';

class DataScreen extends StatefulWidget {
  const DataScreen({Key? key}) : super(key: key);

  @override
  _DataScreenState createState() => _DataScreenState();
}

class _DataScreenState extends State<DataScreen> {
  String data = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About Coffee'),
        centerTitle: true,
        backgroundColor: Colors.brown[400],
      ),
      body: Center(
        child: ListView(
          children: [
            const Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Image(
                    image: AssetImage('assets/roasted_coffee_beans.jpeg'),
                    height: 200.0,
                    fit: BoxFit.fill,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              child: const Text(
                "Welcome to our Coffee Quality Tracking system! We are dedicated to ensuring the consistency and excellence of coffee batches throughout the supply chain. Our app empowers cooperatives, exporters and buyers to collaborate and make informed decisions based on accurate and reliable data. \n\nWith our app, cooperatives can register farmers, register batches, and perform quality tests to ensure only the finest coffee makes its way to the market. Our intuitive interface makes it easy to capture batch details, generate unique QR codes, and track the journey of each coffee batch from origin to destination. \n\nExporters and buyers can rely on our app to scan QR codes and access comprehensive batch information, including moisture content, color, grade and type. This allows them to make well-informed purchasing decisions and support sustainable sourcing practices. \n\n We prioritize security and data integrity, employing robust measures to protect sensitive information and ensure the confidentiality of our users' data. For any inquiries or support, please reach out to our dedicated customer service team at kayegrace14@gmail.com. Cheers to the pursuit of exceptional coffee quality!",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black54,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              alignment: Alignment.center,
              child: Text(
                "©CQTS 2023",
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.brown[400],
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
          ],
        ),
      ),
    );
  }
}
