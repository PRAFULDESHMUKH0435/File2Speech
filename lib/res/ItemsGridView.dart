import 'package:flutter/material.dart';
import 'package:texttospeech/Screens/Screen1.dart';
import 'package:texttospeech/Screens/Screen2.dart';
import 'package:texttospeech/Screens/Screen3.dart';
import 'package:texttospeech/Screens/Screen4.dart';

class ItemsGridView extends StatelessWidget {
  const ItemsGridView({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: GridView(
        // Remove the height constraint and allow it to expand
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        children: const [
          ReUsableCard(
            icon: Icons.picture_as_pdf,
            title: "PDF & Doc",
            subtitle: "Upload PDF Or Doc Files and Start Listening",
            idx: 1,
          ),
          ReUsableCard(
            icon: Icons.qr_code_scanner_outlined,
            title: "Scan Text",
            subtitle: "Scan Text From images and Read",
            idx: 2,
          ),
          ReUsableCard(
            icon: Icons.copy,
            title: "Text 2 Speech",
            subtitle: "Paste Text and Start Listening",
            idx: 3,
          ),
          ReUsableCard(
            icon: Icons.translate,
            title: "Translate",
            subtitle: "Translate from One Language to Another",
            idx: 4,
          ),
        ],
      ),
    );
  }
}

class ReUsableCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final int idx;

  const ReUsableCard({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.idx,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (idx == 1) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const Screen1(idx: 1)),
          );
        } else if (idx == 2) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const Screen2(idx: 2)),
          );
        } else if (idx == 3) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const Screen3(idx: 3)),
          );
        } else {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const Screen4(idx: 4)),
          );
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          borderRadius: const BorderRadius.all(Radius.circular(14.0)),
        ),
        margin: const EdgeInsets.all(5.0),
        padding: const EdgeInsets.only(left: 12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Icon(
                icon,
                size: 40,
                color: Theme.of(context).colorScheme.onPrimary,
              ),
            ),
            // Use Flexible widget here to allow text to grow and not overflow
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                    overflow:
                        TextOverflow.ellipsis, // Ensure text doesn't overflow
                  ),
                  Text(
                    subtitle,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                    overflow:
                        TextOverflow.ellipsis, // Ensure text doesn't overflow
                    maxLines: 2, // Limit subtitle to 2 lines
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
