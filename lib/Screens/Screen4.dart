import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

class Screen4 extends StatefulWidget {
  final int idx;
  const Screen4({super.key, required this.idx});

  @override
  State<Screen4> createState() => _Screen4State();
}

class _Screen4State extends State<Screen4> {
  late StreamSubscription subscription;
  bool _isDeviceConnected = false;

  bool get isDeviceConnected => _isDeviceConnected;

  set isDeviceConnected(bool value) {
    _isDeviceConnected = value;
  }



  String toLanguage = "Marathi"; // Default to language
  TextEditingController fromTextController = TextEditingController();
  TextEditingController toTextController = TextEditingController();
  bool isTranslating = false;

  // Supported languages and their codes
  final List<String> languages = [
    "Bengali",
    "Gujarati",
    "Hindi",
    "Kannada",
    "Malayalam",
    "Marathi",
    "Oriya (Odia)",
    "Punjabi",
    "Tamil",
    "Telugu",
  ];

  final Map<String, String> languageCodes = {
    "Bengali": "bn-IN",
    "Gujarati": "gu-IN",
    "Hindi": "hi-IN",
    "Kannada": "kn-IN",
    "Malayalam": "ml-IN",
    "Marathi": "mr-IN",
    "Oriya (Odia)": "or-IN",
    "Punjabi": "pa-IN",
    "Tamil": "ta-IN",
    "Telugu": "te-IN",
  };

  Future<void> translateText() async {

    if (fromTextController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Enter text to translate")),
      );
      return;
    }

    setState(() {
      isTranslating = true;
    });

    try {
      final response = await http.post(
        Uri.parse('https://api.sarvam.ai/translate'),
        headers: {
          'Content-Type': 'application/json',
          'api-subscription-key':
              '831fc83e-44b4-4e33-b67f-0754fb7a3e0b', // Replace with your Sarvam AI subscription key
        },
        body: jsonEncode({
          "input": fromTextController.text, // Dynamic input text
          "source_language_code": 'en-IN', // Fixed source language as English
          "target_language_code": languageCodes[toLanguage] ?? 'hi-IN',
          "speaker_gender": "Male",
          "mode": "formal",
          "enable_preprocessing": "true"
        }),
      );

      if (response.statusCode == 200) {
        final decodedBody =
            utf8.decode(response.bodyBytes); // Decode response body
        final data = jsonDecode(decodedBody);
        print("Final Data Is ${data}");
        setState(() {
          String txt1 = data['translated_text'] ?? '';
          print("Translated Text Is ${txt1}");
          toTextController.text =
              txt1; // Update as per Sarvam API response structure
        });
      } else {
        throw Exception('Failed to translate text. ${response.body}');
      }
    } catch (e) {
      print("Error 1: ${e}");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(
                "Turn On Internet Connection and Try Again")),
      );
    } finally {
      setState(() {
        isTranslating = false;
      });
    }
  }

  void copyToClipboard() {
    Clipboard.setData(ClipboardData(text: toTextController.text));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Text copied to clipboard")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Translate"),
        backgroundColor: Theme.of(context).colorScheme.primary,
        elevation: 5.0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Card(
          color: Theme.of(context).colorScheme.primary,
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          margin: const EdgeInsets.all(10),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("From", style: TextStyle(fontSize: 18)),
                  // Removed the dropdown for "From" language, as it is fixed to English
                  const Text("English",
                      style: TextStyle(
                          fontSize: 16)), // Display "English" directly
                  const SizedBox(height: 20),
                  const Text("To", style: TextStyle(fontSize: 18)),
                  DropdownButton<String>(
                    value: toLanguage,
                    onChanged: (String? newValue) {
                      setState(() {
                        toLanguage = newValue!;
                      });
                    },
                    items:
                        languages.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: fromTextController,
                          maxLines: 5,
                          decoration: const InputDecoration(
                              labelText: 'Enter Text',
                              border: OutlineInputBorder(),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white))),
                        ),
                      ),
                      const Icon(Icons.arrow_forward, size: 40),
                      Expanded(
                        child: Stack(
                          children: [
                            TextField(
                              controller: toTextController,
                              maxLines: 5,
                              decoration: const InputDecoration(
                                  labelText: 'Translated Text',
                                  border: OutlineInputBorder(),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white))),
                              readOnly: true,
                            ),
                            Positioned(
                              bottom: 10,
                              right: 10,
                              child: IconButton(
                                icon: const Icon(Icons.copy),
                                onPressed: toTextController.text.isEmpty
                                    ? null
                                    : copyToClipboard,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: ElevatedButton(
                      onPressed: isTranslating ? null : translateText,
                      child: isTranslating
                          ? const CircularProgressIndicator(color: Colors.white)
                          : const Text("Translate Text"),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(12.0),
        color: Colors.orangeAccent,
        child: Text(
            "Note : Currently We Are Supporting Some Indian Regional Languages Only , Please Select From To DropDown"),
      ),
    );
  }
}
