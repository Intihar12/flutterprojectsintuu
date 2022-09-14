import 'dart:async';

import 'package:antrakuserinc/controllers/splash_controller/splash_controller.dart';
import 'package:antrakuserinc/ui/auth/walkthrough.dart';
import 'package:antrakuserinc/ui/values/dimens.dart';
import 'package:antrakuserinc/ui/values/my_colors.dart';
import 'package:antrakuserinc/ui/values/my_fonts.dart';
import 'package:antrakuserinc/ui/values/my_imgs.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/map_controller/map_controller.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    LocationController locationController = Get.put(LocationController());
    final splashController = Get.put(SplashController());
    super.initState();
    Timer(Duration(seconds: 5), () => splashController.checkInternet());
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isLandScape = mediaQuery.orientation == Orientation.landscape;
    var height;
    setState(() {
      if (isLandScape) {
        height = mediaQuery.size.width;
      } else {
        height = mediaQuery.size.height;
      }
    });
    return Scaffold(
        body: Container(
      color: Get.theme.primaryColor,
      height: height * 1,
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: Dimens.size200),
              child: Container(
                height: 210,
                width: 210,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(MyImgs.splashLogo))),
              ),
            ),
            Text(
              "Let’s move something better",
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: MyColors.secondaryColor),
            ),
          ],
        ),
      ),
    ));
  }
}
