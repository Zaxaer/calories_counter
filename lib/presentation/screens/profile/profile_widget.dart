import 'package:calories_calculator/resources/app_fonts.dart';
import 'package:calories_calculator/resources/resources.dart';
import 'package:flutter/material.dart';

class ProfileWidget extends StatelessWidget {
  const ProfileWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {},
            icon: Image.asset(
              AppImages.question,
              width: 24,
              height: 24,
              color: const Color(0xFFD75755),
            ),
            splashRadius: 20,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Connect your soc net',
              style: TextStyle(
                color: Color(0xFFD75755),
                fontWeight: FontWeight.w800,
                fontSize: 24,
                height: 1.16,
                fontFamily: AppFonts.mPlusRounded,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'In order to save your results not only on this devise',
              style: TextStyle(
                color: Color(0xFF333333),
                fontWeight: FontWeight.w500,
                fontSize: 18,
                height: 1.33,
                fontFamily: AppFonts.ubuntu,
              ),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
                boxShadow: const [
                  BoxShadow(
                    color: Color(0xFFEBDBAF),
                    spreadRadius: 5,
                    blurRadius: 15,
                    offset: Offset(0, 15),
                  ),
                ],
              ),
              width: double.infinity,
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Image.asset(AppImages.frame43),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
