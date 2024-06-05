import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {

  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _pageController = PageController();

  int _currentPage = 0;
  List<String> discriptions = [
    'Purus sapien urna enim ipsum pret ium dictum. Volutpat tristique lect us vive pellentesque lect us vive pellentesque',
    'Find your dream apartment easily with our app. It\'s fast, secure, and reliable.',
    'Your data is safe with us. We use top-notch security measures to protect your information.',
  ];
  List<String> titles = [
    'Apartment In Town',
    'Easy To Find',
    'Safe & Secure',
  ];
  List<Widget> _buildPages() {
    return const [
      LandingPage(
        image: "assets/house1.svg", // replace with your asset image
      ),
      LandingPage(
        image: 'assets/house2.svg', // replace with your asset image
      ),
      LandingPage(
        image: 'assets/house3.svg', // replace with your asset image
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Material App',
        theme: ThemeData(
          primarySwatch: Colors.purple,
        ),
        home: Scaffold(
          body: Stack(
            children: [
              PageView(
                onPageChanged: (int page){
                  setState(() {
                    _currentPage = page;
                  });
                },
                controller: _pageController,
                children: _buildPages(),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                // top: 500,
                child: Container(
                  padding:const EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20)
                  ),
                  child: Column(
                    children: [
                      Text(
                        titles[_currentPage],
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
                          discriptions[_currentPage],
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 50,),
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
                          if (_currentPage <_buildPages().length  - 1) {
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
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)
                          )
                        ),
                        child: const Text('Next' ,style: TextStyle(
                            color: Colors.white,
                            fontSize: 15
                        ),),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  Widget _buildDots({required int index}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5),
      height: 7,
      width: _currentPage == index ? 12 : 6,
      decoration: BoxDecoration(
        color: _currentPage == index ? Colors.purple : Colors.grey,
        borderRadius: BorderRadius.circular(5),
      ),
    );
  }
}

class LandingPage extends StatelessWidget {
  final String image;

  const LandingPage({super.key,required this.image});

  @override
  Widget build(BuildContext context) {
    return  Column(
      // mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(image,height: 500), // replace with your asset image
      ],
    );
  }
}




