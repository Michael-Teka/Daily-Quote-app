import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
// import 'package:url_launcher/url_launcher.dart';

class AboutThisApp extends StatefulWidget {
  const AboutThisApp({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _AboutThisAppState createState() => _AboutThisAppState();
}

class _AboutThisAppState extends State<AboutThisApp>
    with TickerProviderStateMixin {
  bool _visible = false;

  @override
  void initState() {
    super.initState();
    // Trigger animation after a short delay
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        _visible = true;
      });
    });
  }

  // Method to launch URLs (for privacy policy, terms of service, etc.)
  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'About this app',
          style: TextStyle(
            color: Colors.white,
            fontSize: 25,
          ), // Custom title color
        ),
        backgroundColor: Colors.black, // AppBar background color
        iconTheme:
            const IconThemeData(color: Colors.white), // Adjusts icon color
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // App logo with Hero animation
              const Hero(
                tag: 'appLogo',
                child: Center(
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage(
                      'assets/logo.jpg',
                    ), // Replace with your app logo
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // App name and version with fade-in effect
              Center(
                child: AnimatedOpacity(
                  opacity: _visible ? 1.0 : 0.0,
                  duration: const Duration(milliseconds: 800),
                  child: const Column(
                    children: [
                      Text(
                        'Daily',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Quotes App',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Lottie animation (dynamic animation element)
              // Center(
              //   child: Lottie.asset(
              //     'assets/images/homeAni.json', // Add your Lottie animation file here
              //     height: 150,
              //     repeat: true,
              //   ),
              // ),
              // const SizedBox(height: 20),

              // Description with slide-in effect
              AnimatedContainer(
                duration: const Duration(milliseconds: 1000),
                curve: Curves.easeInOut,
                transform: Matrix4.translationValues(_visible ? 0 : -100, 0, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Description',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    RichText(
                      text: const TextSpan(
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.black), // Default style for all text
                        children: <TextSpan>[
                          TextSpan(
                            text:
                                'The **Daily Quotes App** is a beautifully crafted Flutter application designed to inspire and motivate users with a collection of thought-provoking quotes. It delivers a fresh daily quote each time the app is opened, ensuring a constant stream of inspiration. Users can explore a comprehensive library of quotes from renowned authors, save their favorites for quick access, and even share meaningful sayings directly with friends and family via social media or messaging platforms. The app also keeps track of shared quotes, allowing users to revisit their shared wisdom anytime. Featuring a user-friendly interface and a clean, modern design, the app provides easy navigation through its built-in drawer, enabling seamless access to various sections such as Daily Quote, All Quotes, Favorites, and Shared Quotes.'
                                'With its ability to refresh the daily quote and manage personalized favorites, the app offers a personalized and engaging experience. The integration of offline access ensures users can enjoy their curated quotes anytime, even without an internet connection. Built with Flutter for cross-platform compatibility, the app uses JSON to manage its quote data efficiently and incorporates state management techniques for real-time updates. Perfect for anyone seeking daily motivation or curating a library of inspiring sayings, the Daily Quotes App combines practicality, aesthetic appeal, and meaningful content into a single, delightful package. ',
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Developer credits with scaling animation
              AnimatedOpacity(
                opacity: _visible ? 1.0 : 0.0,
                duration: const Duration(milliseconds: 800),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Developed By',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Michael Teka',
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Useful links section with bouncing icons
              AnimatedContainer(
                duration: const Duration(milliseconds: 1000),
                curve: Curves.easeInOut,
                transform: Matrix4.translationValues(_visible ? 0 : 100, 0, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Divider(),

                    // Contact Support Link
                    ListTile(
                      leading: Icon(Icons.support_agent_outlined,
                          color: Colors.blueAccent, size: _visible ? 30 : 20),
                      title: const Text('Contact us by Telegram'),
                      onTap: () => _launchURL('https://t.me/mick2721'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
