import 'package:cameramain1/camerataking.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade50,
      appBar: AppBar(
        backgroundColor: Colors.blue.shade100,
        centerTitle: true,
        title: const Text(
          "Photo Capture App",
        ),
        titleTextStyle: const TextStyle(fontSize: 30, color: Colors.black),
      ),
      body: Center(
        child: SizedBox(
          width: 270,
          height: 70,
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return const TakingPhot();
              },));
            },
            style: ButtonStyle(backgroundColor: WidgetStateProperty.all(Colors.green.shade200)),
            child: const Row(
              children: [
                Icon(
                  Icons.camera_alt_rounded,
                  size: 40,
                  color: Colors.black,
                ),
                Text(
                  "  Open Camera",
                  style: TextStyle(fontSize: 25,color: Colors.black),
                ),
                
              ],
            ),
          ),
        ),
      ),
    );
  }
}
