import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tri_karo_2/views/authenticate/authenticate.dart';
import 'package:tri_karo_2/views/login_screen.dart';
import 'package:tri_karo_2/views/singup_screen.dart';
import '../utils/colors.dart';
import '../utils/constant_variables.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);
  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  String heading1 = 'Order your Items',
      heading2 = 'Transfer safe items',
      heading3 = 'Quick Delivery',
      bodyText1 = 'Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam.',
      bodyText2 = 'Ut enim ad minim veniam.',
      bodyText3 = 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do.';
  int sliderIndex = 0;
  bool isLoginVisible = false;

  PageController pageController = PageController();
  updateSliderIndex(int index) => setState(() => sliderIndex = index);

  changePage(int index) => pageController.animateToPage(index, duration: const Duration(milliseconds: 300), curve: Curves.linear);

  @override
  Widget build(BuildContext context) => Scaffold(
      backgroundColor: white,
      body: Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, crossAxisAlignment: CrossAxisAlignment.center, children: [
        Expanded(
            child: PageView(
                physics: const NeverScrollableScrollPhysics(),
                onPageChanged: (index) => updateSliderIndex(index),
                scrollDirection: Axis.horizontal,
                controller: pageController,
                children: [page('0', heading1, bodyText1), page('1', heading1, bodyText1), page('2', heading1, bodyText1)])),
        SafeArea(
            child: Stack(children: [
          AnimatedOpacity(
              duration: const Duration(milliseconds: 150),
              opacity: sliderIndex == 2 ? 1 : 0,
              onEnd: () {
                if (sliderIndex == 2) setState(() => isLoginVisible = true);
              },
              child: Padding(
                  padding: const EdgeInsets.only(right: 16.0, left: 24, bottom: 16),
                  child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                    /*Expanded(
                        child: GestureDetector(
                            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const SignupScreen())),
                            child: Container(
                                padding: const EdgeInsets.symmetric(vertical: 13),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    color: white,
                                    borderRadius: BorderRadius.circular(25),
                                    border: Border.all(color: red_1, width: 1),
                                    boxShadow: [
                                      BoxShadow(color: red_1.withOpacity(0.1), blurRadius: 8, spreadRadius: -4, offset: const Offset(0, 8)),
                                      BoxShadow(color: red_1.withOpacity(0.1), blurRadius: 16, spreadRadius: -8, offset: const Offset(0, 12)),
                                    ]),
                                child: Text('Sign up', style: GoogleFonts.poppins(fontWeight: FontWeight.w500, color: red_1))))),
                    const SizedBox(width: 20),*/
                    Expanded(
                        child: GestureDetector(
                            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const Authenticate())),
                            child: Container(
                                padding: const EdgeInsets.symmetric(vertical: 13),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(color: red_1, borderRadius: BorderRadius.circular(25), boxShadow: [
                                  BoxShadow(color: red_1.withOpacity(0.2), blurRadius: 8, spreadRadius: -4, offset: const Offset(0, 8)),
                                  BoxShadow(color: red_1.withOpacity(0.2), blurRadius: 16, spreadRadius: -8, offset: const Offset(0, 12)),
                                ]),
                                child: Text('Proceed to Signup', style: GoogleFonts.poppins(fontWeight: FontWeight.w500, color: white)))))
                  ]))),
          AnimatedOpacity(
              duration: const Duration(milliseconds: 150),
              opacity: sliderIndex < 2 ? 1 : 0,
              child: Visibility(
                  visible: !isLoginVisible,
                  child: Padding(
                      padding: const EdgeInsets.only(right: 16.0, left: 24, bottom: 16),
                      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                        AnimatedOpacity(
                            duration: const Duration(milliseconds: 150),
                            opacity: sliderIndex == 1 ? 1 : 0,
                            child: GestureDetector(
                                onTap: () => changePage(0),
                                child: Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 8),
                                    child: Text('Previous', style: GoogleFonts.poppins(fontWeight: FontWeight.w500, color: grey_1))))),
                        GestureDetector(
                            onTap: () => changePage(sliderIndex + 1),
                            child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 13),
                                decoration: BoxDecoration(color: red_1, borderRadius: BorderRadius.circular(25), boxShadow: [
                                  BoxShadow(color: red_1.withOpacity(0.2), blurRadius: 8, spreadRadius: -4, offset: const Offset(0, 8)),
                                  BoxShadow(color: red_1.withOpacity(0.2), blurRadius: 16, spreadRadius: -8, offset: const Offset(0, 12)),
                                ]),
                                child: Text('Next', style: GoogleFonts.poppins(fontWeight: FontWeight.w500, color: white))))
                      ]))))
        ]))
      ]));

  Column page(String image, heading, body) => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Image.asset('$imagePath/onboarding_$image.png', fit: BoxFit.cover),
        const SizedBox(height: 40),
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(heading, style: GoogleFonts.poppins(fontSize: 28, fontWeight: FontWeight.w600))),
        const SizedBox(height: 24),
        Padding(padding: const EdgeInsets.symmetric(horizontal: 16), child: Text(body, style: GoogleFonts.poppins(fontSize: 16, color: grey_2)))
      ]);
}
