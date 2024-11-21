import 'package:flutter/material.dart';

class TranslateContainer extends StatelessWidget {
  TranslateContainer({super.key});

  final List<String> namasteInLanguages = [
    'नमस्ते (Hindi)',
    'Namaste (English)',
    'Hola (Spanish)',
    'Bonjour (French)',
    'Hallo (German)',
    'こんにちは (Japanese)',
    '안녕하세요 (Korean)',
    'Ciao (Italian)',
    'नমস্কার (Bengali)',
    'ਸਤ ਸ੍ਰੀ ਅਕਾਲ (Punjabi)',
    'ہیلو (Urdu)',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.25,
      margin: const EdgeInsets.all(5.0),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.circular(12.0),
        image: const DecorationImage(image: AssetImage("Assets/Images/banner.jpeg"),fit: BoxFit.cover)
      ),
    );
  }
}
