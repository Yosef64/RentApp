import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: OnboardingScreen(),
    );
  }
}

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  final _backgroundImageKey = GlobalKey();
  static const urlPrefix = 'https://docs.flutter.dev/cookbook/img-files/effects/parallax';
  List<Widget> _buildPages() {
    return [
      _buildPage(
        image: "$urlPrefix/01-mount-rushmore.jpg", // replace with your asset image
        title: 'Apartment In Town',
        description:
        'Purus sapien urna enim ipsum pret ium dictum. Volutpat tristique lect us vive pellentesque lect us vive pellentesque',
      ),
      _buildPage(
        image: '$urlPrefix/02-singapore.jpg', // replace with your asset image
        title: 'Easy To Find',
        description:
        'Find your dream apartment easily with our app. It\'s fast, secure, and reliable.',
      ),
      _buildPage(
        image: '$urlPrefix/03-machu-picchu.jpg', // replace with your asset image
        title: 'Safe & Secure',
        description:
        'Your data is safe with us. We use top-notch security measures to protect your information.',
      ),
    ];
  }

  Widget _buildPage({required String image, required String title, required String description}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.network(image,key: _backgroundImageKey,
          fit: BoxFit.cover,), // replace with your asset image
        const SizedBox(height: 20),
        Text(
          title,
          style: GoogleFonts.poppins(
            textStyle: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40.0),
          child: Text(
            description,
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              textStyle: const TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _pageController,
            onPageChanged: (int page) {
              setState(() {
                _currentPage = page;
              });
            },
            children: _buildPages(),
          ),
          Positioned(
            bottom: 20,
            left: 20,
            right: 20,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    _buildPages().length,
                        (int index) => _buildDots(index: index),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (_currentPage < _buildPages().length - 1) {
                      _pageController.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    } else {
                      // Go to the next screen or perform some action
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 100,
                      vertical: 15,
                    ),
                  ),
                  child: const Text('Next' ,style: TextStyle(
                    color: Colors.white,
                    fontSize: 15
                  ),),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDots({required int index}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5),
      height: 10,
      width: _currentPage == index ? 12 : 8,
      decoration: BoxDecoration(
        color: _currentPage == index ? Colors.purple : Colors.grey,
        borderRadius: BorderRadius.circular(5),
      ),
    );
  }
}
