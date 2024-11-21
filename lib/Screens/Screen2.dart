import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart'; // For image picking
import 'package:google_ml_kit/google_ml_kit.dart'; // For text recognition
import 'package:flutter_tts/flutter_tts.dart';
// For text-to-speech

class Screen2 extends StatefulWidget {
  final int idx;
  const Screen2({super.key, required this.idx});

  @override
  State<Screen2> createState() => _Screen2State();
}

class _Screen2State extends State<Screen2> {
  String extractedText = "Captured text will appear here.";
  final FlutterTts flutterTts = FlutterTts();


@override
  void dispose() {
    flutterTts.stop();
    super.dispose();
  }

  Future<void> openCameraAndScanText() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.camera);

    if (image != null) {
      final InputImage inputImage = InputImage.fromFilePath(image.path);
      final TextRecognizer textRecognizer =
          GoogleMlKit.vision.textRecognizer();
      final RecognizedText recognizedText =
          await textRecognizer.processImage(inputImage);

      setState(() {
        extractedText = recognizedText.text.isNotEmpty
            ? recognizedText.text
            : "No text found in the image.";
      });

      textRecognizer.close();
    }
  }



  Future<void> speakText() async {
    await flutterTts.speak(extractedText);
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Scan Text",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.onPrimary,
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
        elevation: 5.0,
      ),
      body: Column(
        children: [
          Container(
            height: screenHeight * 0.7,
            width: double.infinity,
            padding: const EdgeInsets.all(16.0),
            margin: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(color: Colors.grey),
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                SingleChildScrollView(
                  child: Center(
                    child: Text(
                      extractedText,
                      style: const TextStyle(fontSize: 18),
                    ),
                  ),
                ),
                if (extractedText != "Captured text will appear here." &&
                    extractedText != "No text found in the image.") // Updated condition
                  Positioned(
                    bottom: 8,
                    right: 8,
                    child: IconButton(
                      icon: const Icon(Icons.record_voice_over),
                      onPressed: speakText,
                    ),
                  ),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: openCameraAndScanText,
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.primary,
              padding: const EdgeInsets.symmetric(
                  vertical: 12.0, horizontal: 24.0),
            ),
            child: Text(
              "Open Camera & Scan Text",
              style: TextStyle(
                  fontSize: 18, color: Theme.of(context).colorScheme.onPrimary),
            ),
          ),
        ],
      ),
    );
  }
}
