import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:texttospeech/Screens/aboutus.dart';
import 'package:texttospeech/Screens/upcomingfeatures.dart';
import 'package:texttospeech/Utils/Constants/styles.dart';
import 'package:texttospeech/Utils/Theme/theme.dart';
import 'package:texttospeech/Utils/Theme/themeprovider.dart';
import 'package:url_launcher/url_launcher.dart';

class Customdrawer extends StatefulWidget {
  const Customdrawer({super.key});

  @override
  State<Customdrawer> createState() => _CustomdrawerState();
}

class _CustomdrawerState extends State<Customdrawer> {
  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not launch $url')),
      );
    }
  }

  // Function to share the app
  void shareApp(String applink) async {
    try {
      await Share.share(
        'Check out this amazing app! $applink',
        subject: 'App Recommendation',
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error sharing app: ${e.toString()}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.primary,
      child: ListView(
        children: [
          const UserAccountsDrawerHeader(
            currentAccountPicture: CircleAvatar(
              backgroundImage: AssetImage("Assets/Images/splash_image.jpg"),
            ),
            accountName: Text(
              "Welcome",
              style: AppStyles.customdraweritemstitlestyle,
            ),
            accountEmail: Text(
              "Listen, Copy-Paste, and Translate",
              style: AppStyles.customdraweritemstitlestyle,
            ),
          ),
          ListTile(
            leading: const Icon(Icons.night_shelter_outlined),
            title: const Text(
              "Change Theme",
              style: AppStyles.customdraweritemstitlestyle,
            ),
            subtitle: const Text("Change Theme of App"),
            trailing: Consumer<ThemeProvider>(
              builder: (context, themeProvider, child) {
                return IconButton(
                  onPressed: themeProvider.toggleTheme,
                  icon: themeProvider.themeData == lighttheme
                      ? const Icon(Icons.toggle_off_outlined)
                      : const Icon(Icons.toggle_on_outlined),
                );
              },
            ),
          ),
          ListTile(
            leading: const Icon(Icons.info_outline),
            title: const Text(
              "About Us",
              style: AppStyles.customdraweritemstitlestyle,
            ),
            subtitle: const Text("Read About Our Organization and Who We Are"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AboutUsScreen()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.connected_tv_sharp),
            title: const Text(
              "Connect Us",
              style: AppStyles.customdraweritemstitlestyle,
            ),
            subtitle: const Text("Connect With Us on Social Media"),
            onTap: () {
              _launchUrl(
                  'https://www.linkedin.com/company/appveda-software/?viewAsMember=true');
            },
          ),
          ListTile(
            leading: const Icon(Icons.privacy_tip_outlined),
            title: const Text(
              "Privacy Policy",
              style: AppStyles.customdraweritemstitlestyle,
            ),
            subtitle: const Text("Read Our Data Usage and Privacy Policy"),
            onTap: () {
              _launchUrl(
                  'https://docs.google.com/document/d/1q7RWThknBfBLTQpESJcwPD4phbWHcfPSWHklL0PAqW4/edit?usp=sharing');
            },
          ),
          ListTile(
            leading: const Icon(Icons.diamond_outlined,size: 24,),
            title: const Text(
              "Upcoming Features",
              style: AppStyles.customdraweritemstitlestyle,
            ),
            subtitle: const Text("Our Upcoming Features"),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=>UpcomingfeaturesScreen()));
            }
          ),
          const Divider(height: 2.0),
          ListTile(
            leading: const Icon(Icons.share_outlined),
            title: const Text(
              "Share App",
              style: AppStyles.customdraweritemstitlestyle,
            ),
            subtitle:
                const Text("Share Our App With Friends & Family on Social Media"),
            onTap: () {
              shareApp(
                  'https://play.google.com/store/apps/details?id=com.tts.texttospeech&hl=en');
            },
          ),
          ListTile(
            leading: const Icon(Icons.apps),
            title: const Text(
              "More Apps",
              style: AppStyles.customdraweritemstitlestyle,
            ),
            subtitle: const Text("Browse All Our Apps Available on Play Store"),
            onTap: () {
              _launchUrl(
                  'https://play.google.com/store/apps/dev?id=7814871565193201079&hl=en');
            },
          ),
          
        ],
      ),
    );
  }
}
