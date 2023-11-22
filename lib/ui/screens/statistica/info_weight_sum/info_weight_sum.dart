import 'package:calories_calculator/resources/app_fonts.dart';
import 'package:calories_calculator/resources/resources.dart';
import 'package:flutter/material.dart';

class InfoSumWeight extends StatelessWidget {
  const InfoSumWeight({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Image.asset(AppImages.close,
              color:
                  Theme.of(context).bottomNavigationBarTheme.selectedItemColor),
          splashRadius: 20,
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Как считается вес',
              style: TextStyle(
                color: Color(0xFFD75755),
                fontSize: 24,
                height: 1.16,
                fontWeight: FontWeight.w800,
                fontFamily: AppFonts.mPlusRounded,
              ),
            ),
            SizedBox(height: 24),
            Text(
              'Нас основе всяких очень медицинских данных взятых из интернета. Создатели приложения не несут ответсвенность ни за что вообще.',
              style: TextStyle(
                color: Color(0xFF333333),
                fontSize: 18,
                height: 1.333,
                fontWeight: FontWeight.w400,
                fontFamily: AppFonts.ubuntu,
              ),
            ),
            Expanded(child: SizedBox()),
            _SaveButtonWidget(),
          ],
        ),
      ),
    );
  }
}

class _SaveButtonWidget extends StatelessWidget {
  const _SaveButtonWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).bottomNavigationBarTheme.selectedItemColor;
    return Align(
      alignment: Alignment.bottomCenter,
      child: ElevatedButton(
        onPressed: () => Navigator.of(context).pop(),
        style: ButtonStyle(
          minimumSize: MaterialStateProperty.all(
            const Size(double.infinity, 54),
          ),
          elevation: MaterialStateProperty.all(0),
          shape: MaterialStateProperty.all(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
          backgroundColor: MaterialStateProperty.all(color),
        ),
        child: const Text(
          'OK',
          style: TextStyle(
              fontWeight: FontWeight.w800,
              fontFamily: AppFonts.mPlusRounded,
              fontSize: 18,
              height: 1.33),
        ),
      ),
    );
  }
}
