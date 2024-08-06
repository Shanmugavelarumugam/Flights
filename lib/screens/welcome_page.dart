import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WelcomePage extends StatelessWidget {
  final String imagePath;
  final VoidCallback onSkipButtonPressed;
  final VoidCallback onNextButtonPressed;

  const WelcomePage({
    Key? key,
    required this.imagePath,
    required this.onSkipButtonPressed,
    required this.onNextButtonPressed,
  }) : super(key: key);

  static const IconData nextPlanOutlined =
      IconData(0xf20f, fontFamily: 'MaterialIcons');
  static const IconData skipNextOutlined =
      IconData(0xf5d0, fontFamily: 'MaterialIcons');

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            height: 540.h,
            child: Image.asset(
              imagePath,
              fit: BoxFit.contain,
            ),
          ),
          SizedBox(height: 2.h),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Find\nYour Perfect\nTickets To Fly',
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: 36.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Spacer(),
          Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: 48.h,
                  child: TextButton(
                    onPressed: onSkipButtonPressed,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(skipNextOutlined, color: Colors.black),
                        SizedBox(width: 8.w),
                        Text(
                          'Skip',
                          style: TextStyle(color: Colors.black),
                        ),
                      ],
                    ),
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.transparent),
                      padding: MaterialStateProperty.all(
                          EdgeInsets.symmetric(vertical: 12.h)),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r))),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: SizedBox(
                  height: 48.h,
                  child: ElevatedButton(
                    onPressed: onNextButtonPressed,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r)),
                      padding: EdgeInsets.symmetric(vertical: 12.h),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Next',
                          style: TextStyle(color: Colors.white),
                        ),
                        SizedBox(width: 8.w),
                        Icon(nextPlanOutlined, color: Colors.white),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
