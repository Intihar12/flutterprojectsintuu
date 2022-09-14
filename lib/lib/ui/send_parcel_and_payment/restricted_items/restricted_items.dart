import 'package:antrakuserinc/controllers/restricted_controller/restricted_controller.dart';
import 'package:antrakuserinc/data/constants/constants.dart';
import 'package:antrakuserinc/ui/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../../values/size_config.dart';
import '../../values/strings.dart';
import '../../values/values.dart';
import '../order_summary/order_summary.dart';

class RestrictedItems extends GetView<RestrictedController> {
  const RestrictedItems({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var textTheme = theme.textTheme;
    return Scaffold(
      appBar: AppBar(
        title: Text(Strings.restricted),
        centerTitle: true,
        leading: GestureDetector(
            onTap: () {
              return onBack();
            },
            child: Icon(Icons.arrow_back_ios)),
      ),
      body: WillPopScope(
        onWillPop: () {
          return onBack();
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  Strings.restrictedItems,
                  style: textTheme.headline4!.copyWith(
                      color: Colors.black.withOpacity(0.6),
                      fontWeight: FontWeight.normal),
                ),
                SizedBox(
                  height: 20,
                ),
                controller.obx(
                    (data) => GridView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          itemCount: data!.response![0].titles!.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  childAspectRatio: 0.7,
                                  crossAxisCount: 4,
                                  crossAxisSpacing: 10,
                                  mainAxisSpacing: 10),
                          itemBuilder: (BuildContext context, int index) {
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                FadeInImage.assetNetwork(
                                  height: Dimens.size80,
                                  width: Dimens.size80,
                                  placeholder: MyImgs.onLoading,
                                  image:
                                      "${Constants.imagesBaseUrl}${data.response![0].images![index]}",
                                  imageErrorBuilder: (context, e, stackTrace) =>
                                      Image.asset(
                                    MyImgs.errorImage,
                                    height: Dimens.size80,
                                    width: Dimens.size80,
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "${data.response![0].titles![index]}",
                                  style: textTheme.bodyText2!
                                      .copyWith(fontSize: 12),
                                  overflow: TextOverflow.ellipsis,
                                )
                              ],
                            );
                          },
                        ),
                    onLoading: Shimmer.fromColors(
                        baseColor: MyColors.grey.withOpacity(0.08),
                        highlightColor: MyColors.white,
                        child: GridView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          itemCount: 28,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  childAspectRatio: 0.7,
                                  crossAxisCount: 4,
                                  crossAxisSpacing: 10,
                                  mainAxisSpacing: 10),
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                              height: getHeight(Dimens.size160),
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color:
                                      MyColors.tertiaryColor.withOpacity(0.2)),
                            );
                          },
                        )))
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Wrap(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
            child: CustomButton(
                height: getHeight(Dimens.size40),
                width: getWidth(Dimens.size250),
                text: "Confirm",
                onPressed: () {
                 Get.offAll(OrderSummary());
                }),
          ),
        ],
      ),
    );
  }

  onBack() {
    Get.offAll(() => OrderSummary());
  }
}
