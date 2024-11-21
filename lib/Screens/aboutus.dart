import 'package:flutter/material.dart';

class AboutUsScreen extends StatelessWidget {

  String aboutAppText = """
Welcome and Thanks for Downloading Our App!\n\n
We are AppVeda Software, a cross-platform mobile app development company specializing in mobile and desktop app development. We are committed to delivering high-quality solutions that make your life easier and more efficient.\n\n
About File2Speech\n\n
Introducing File2Speech — the ultimate tool for all your speech and text translation needs. This app offers four powerful features to help you communicate and understand information more effectively:\n\n
1. PDF and Document Reader: Upload a PDF file, and the app will read aloud the text content for you, making it easier to digest important documents on the go.\n\n
2. Scan Text: Use your device's camera to scan text, and the app will read it aloud and display it on the screen for your convenience.\n\n
3. Text-to-Speech: Simply type any text, and the app will speak it aloud, making it perfect for quick translations or reading long paragraphs.\n\n
4. Translate: Enter text in one language, and the app will instantly translate it into another language, helping you bridge communication gaps in real-time.\n\n
Additional Features\n\n
- Share App: Easily share the app with friends and family via social media or other platforms with just a tap.\n\n
- More Apps: Discover other innovative apps from Appfeather Software by clicking on this section, which will take you to our Google Play Console.\n\n
- Privacy Policy: Learn about how we handle your data and privacy with our detailed privacy policy.\n\n
- Change Theme: Choose between light mode or dark mode to personalize the app's look based on your preference.\n\n
- Connect with Us: Connect with us on our LinkedIn Profile to learn more about our latest projects and updates.\n\n
We hope Speech Translator enhances your daily life and communication. Thank you for choosing our app!
""";

AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "About App",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.onPrimary,
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
        elevation: 5.0,
      ),
      body: Container(
        padding: const EdgeInsets.all(14.0),
        child: ListView(
          children: [
            Text(aboutAppText)
          ],
        ),
      ),
    );
  }
}