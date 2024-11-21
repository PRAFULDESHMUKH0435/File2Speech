import 'package:flutter/material.dart';

class Textcontainer extends StatelessWidget {
  const Textcontainer({super.key});

  @override
  Widget build(BuildContext context){
    return Container(
      decoration: const BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.all(Radius.circular(14.0))
      ),
      height: MediaQuery.of(context).size.height*0.1,
      padding: const EdgeInsets.all(5.0),
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Welcome User",
            style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold),
          ),
          Text(
            "Upload ,Copy-Paste , Translate ,Listen",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22,
                color:Theme.of(context).colorScheme.onPrimary,
                fontStyle: FontStyle.italic),
          )
        ],
      ),
    );
  }
}
