
import 'package:antrakuserinc/ui/auth/welcome.dart';
import 'package:antrakuserinc/ui/values/dimens.dart';
import 'package:antrakuserinc/ui/values/my_colors.dart';
import 'package:antrakuserinc/ui/values/my_imgs.dart';
import 'package:antrakuserinc/ui/values/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'login/login.dart';





class WalkThroughScreen extends StatefulWidget {
  @override
  _WalkThroughScreenState createState() => _WalkThroughScreenState();
}

class _WalkThroughScreenState extends State<WalkThroughScreen> {
  final int _numPages = 3;
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  List<Widget> _buildPageIndicator() {
    List<Widget> list = [];
    for (int i = 0; i < _numPages; i++) {
      list.add(i == _currentPage ? _indicator(true) : _indicator(false));
    }
    return list;
  }

  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 10),
      margin: EdgeInsets.symmetric(horizontal: Dimens.size6),
      height: getHeight(Dimens.size12),
      width: isActive ? Dimens.size35 : Dimens.size12,
      decoration: BoxDecoration(
        color: isActive ? Get.theme.colorScheme.primary : MyColors.greyFont,
        borderRadius: BorderRadius.all(Radius.circular(Dimens.size6)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [

            Container(
              height: getHeight(600.0),
             // width: double.infinity,
              //color: MyColors.greyFont,
              child: PageView(
                physics: ClampingScrollPhysics(),
                controller: _pageController,
                onPageChanged: (int page) {
                  setState(() {
                    _currentPage = page;
                  });
                },
                children: [
                  _photos(
                    photo: MyImgs.imgWalk,
                    headline: 'Instant Rates & Bookings',
                    subtitle: 'Get your packages delivered instantly with our super fast delivery service', ),
                  _photos(
                      photo: MyImgs.imgWalk1,
                      headline: 'Track Shipment',
                      subtitle: 'Track your shipment and receive instant mobile notifications'
                  ),
                  _photos(
                      photo: MyImgs.imgWalk2,
                      headline: 'Designed for your convenience',
                      subtitle:'Schedule pick-up and drop-off at your preferred date, time and place.'
                  ),
                ],
              ),
            ),
            SizedBox(height: getHeight(20),),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: _buildPageIndicator(),
            ),
            _currentPage == _numPages - 1
                ? Padding(
              padding: const EdgeInsets.only(

                  left: Dimens.size10,
                  right: Dimens.size10),
              child: GestureDetector(
                onTap: () {
                  // todo: add the next page here
                  Get.offAll(WelcomeScreen());
                },
                child: Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: Container(
                    height: getHeight(50.0),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimens.size5),
                        color: Get.theme.colorScheme.primary
                    ),
                    child: Center(
                      child: Text(
                        'Get Started',
                        style: Theme.of(context)
                            .textTheme
                            .headline3!
                            .copyWith(
                            color: Theme.of(context).colorScheme.secondary),
                      ),
                    ),
                  ),
                ),
              ),
            )
                : Padding(
                  padding: const EdgeInsets.symmetric(horizontal: Dimens.size10),
                  child: GestureDetector(
                        onTap: () {
                          _pageController.nextPage(
                            duration: Duration(milliseconds: 500),
                            curve: Curves.ease,
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(top: 30),
                          child: Container(
                            height: getHeight(50.0),
                            width: MediaQuery.of(context).size.width*0.9,
                            decoration: BoxDecoration(
                              // shape: BoxShape.circle,
                              // color: Colors.transparent,
                                borderRadius: BorderRadius.circular(Dimens.size5),
                                color: Get.theme.colorScheme.primary

                            ),
                            child: Center(
                              child: Text(
                                'Next',
                                style: Get.theme.textTheme.headline3!.copyWith(color: MyColors.secondaryColor),
                              ),
                            ),
                          ),
                        ),
                  ),
                ),
          ],
        ),
      ),
    );
  }

  Widget _photos(
      {required String photo,
        required String headline,
        required String subtitle}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
       //   width: MediaQuery.of(context).size.width*1.0,
          height: getHeight(400),
          decoration:BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(
                  photo,
                ),

              )

          ),

        ),
        SizedBox(height: getHeight(Dimens.size80)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: Dimens.size15),
          child: Text(
            headline,
            style: Theme.of(context).textTheme.headline1!.copyWith(
                color: MyColors.black,
              fontSize: getFont(24)
            ),
            textAlign: TextAlign.center,

          ),
        ),
        SizedBox(height: getHeight(Dimens.size20)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: Dimens.size15),
          child: Text(
            subtitle,
            style: Theme.of(context)
                .textTheme
                .bodyText1!
                .copyWith(color: Colors.black38,
            fontSize: getFont(14)
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
