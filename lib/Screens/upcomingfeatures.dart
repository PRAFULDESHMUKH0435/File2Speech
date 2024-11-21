import 'package:flutter/material.dart';

class UpcomingfeaturesScreen extends StatelessWidget {
  const UpcomingfeaturesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Upcoming Features",style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold,color:Theme.of(context).colorScheme.onPrimary),),backgroundColor: Theme.of(context).colorScheme.primary,elevation: 5.0,),
      body: Center(
        child: Container(
           child: ListView(
            padding: const EdgeInsets.all(14.0),
            children: const [
              Text("1) Speech to Voice Recorder",style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),),
              SizedBox(height: 5,),
              Text("2) Text to Speech and Speech to Video BackGround",style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold)),
            ],
           ),
        ),
      ),
    );
  }
}