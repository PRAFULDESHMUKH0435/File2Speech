import 'package:flutter/material.dart';
import 'package:texttospeech/Utils/Constants/CustomDrawer.dart';
import 'package:texttospeech/res/ItemsGridView.dart';
import 'package:texttospeech/res/TranslateContainer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: Text(
          "File2Speech",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.onPrimary,
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
        elevation: 5.0,
      ),
      drawer: const Customdrawer(),
      body: Column(
        children: [
          // Top Container (30%)
          Expanded(
            flex: 4, // 3 out of 10
            child: TranslateContainer(),
          ),

          // Bottom Grid View (70%)
          const Expanded(
            flex: 6, // 7 out of 10
            child: ItemsGridView(),
          ),
        ],
      ),
    );
  }
}
