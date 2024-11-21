import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class Screen3 extends StatefulWidget {
  final int idx;
  const Screen3({super.key, required this.idx});

  @override
  State<Screen3> createState() => _Screen3State();
}

class _Screen3State extends State<Screen3> {
  final TextEditingController textController = TextEditingController();
  final FlutterTts flutterTts = FlutterTts();

  bool get hasContent => textController.text.trim().isNotEmpty;
  List<Map<String, String>> voices = [];
  Map<String, String>? selectedVoice;

  @override
  void initState() {
    super.initState();
    initializeTts();
  }

  @override
  void dispose() {
    flutterTts.stop();
    super.dispose();
  }

  // Initialize TTS and set a default voice
  Future<void> initializeTts() async {
    await flutterTts.setLanguage("en-US");
    await flutterTts.setSpeechRate(0.5);
    await flutterTts.awaitSpeakCompletion(true);

    var availableVoices = await flutterTts.getVoices;
    if (availableVoices is List) {
      voices = (availableVoices)
          .map<Map<String, String>>((voice) {
        return {
          'name': voice['name']?.toString() ?? 'Unknown Voice',
          'locale': voice['locale']?.toString() ?? 'en-US',
        };
      })
          .where((voice) => voice['locale'] == 'en-US') // Filter by desired locale
          .toList();
    }

    if (voices.isNotEmpty) {
      selectedVoice = voices[0];
      await flutterTts.setVoice(selectedVoice!);
    }
  }

  // Speak text with the selected voice
  Future<void> speakText() async {
    if (hasContent && selectedVoice != null) {
      await flutterTts.setLanguage("en-US"); // Explicitly set the language
      await flutterTts.speak(textController.text.trim());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Paste & Listen",
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
          Expanded(
            child: Container(
              margin: const EdgeInsets.all(14.0),
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                borderRadius: const BorderRadius.all(Radius.circular(14.0)),
              ),
              child: Center(
                child: TextField(
                  textAlign: TextAlign.center,
                  controller: textController,
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: "Paste your content here...",
                  ),
                  onChanged: (_) {
                    setState(() {}); // Update UI on text change
                  },
                ),
              ),
            ),
          ),
          if (hasContent)
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 8.0),
              width: MediaQuery.of(context).size.width * 0.7,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                borderRadius: const BorderRadius.all(Radius.circular(14.0)),
              ),
              child: TextButton(
                onPressed: speakText,
                child: Text(
                  "Speak",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
