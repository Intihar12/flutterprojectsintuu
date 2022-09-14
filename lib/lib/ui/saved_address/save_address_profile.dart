import 'package:antrakuserinc/controllers/address_controller/address_controller.dart';
import 'package:antrakuserinc/ui/profile/profile_drawer.dart';
import 'package:antrakuserinc/ui/saved_address/add_new_address_saved.dart';
import 'package:antrakuserinc/ui/values/dimens.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shimmer/shimmer.dart';

import '../values/my_colors.dart';
import '../values/my_imgs.dart';
import '../values/size_config.dart';
import '../values/strings.dart';
import '../widgets/add_button.dart';

class SavedAddressProfile extends GetView<AddressController> {
  SavedAddressProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var mediaQuery = MediaQuery.of(context).size;
    var theme = Theme.of(context);
    var textTheme = theme.textTheme;
    return WillPopScope(
      onWillPop: () {
        return onBack();
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Saved Address"),
          leading: GestureDetector(
            onTap: () {
              Get.off(() => ProfileDrawer());
            },
            child: Icon(Icons.arrow_back_ios),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: Dimens.size15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: getHeight(Dimens.size30),
              ),
              Text(
                Strings.savedAddress,
                style:
                    textTheme.headline3!.copyWith(color: MyColors.primaryColor),
              ),
              SizedBox(
                height: getHeight(Dimens.size20),
              ),
              controller.obx(
                (data) => data.response.length != 0
                    ? Container(
                        height: getHeight(Dimens.size550),
                        width: getWidth(mediaQuery.width),
                        child: ListView.separated(
                          physics: BouncingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: data.response.length,
                          separatorBuilder: (context, index) => SizedBox(
                            height: getHeight(Dimens.size10),
                          ),
                          itemBuilder: (context, index) {
                            return Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: Dimens.size15,
                                  vertical: Dimens.size10),
                              width: getWidth(mediaQuery.width),
                              decoration: BoxDecoration(
                                  color: MyColors.tertiaryColor,
                                  borderRadius:
                                      BorderRadius.circular(Dimens.size5)),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width: getWidth(Dimens.size320),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          data.response[index].title,
                                          style: textTheme.headline5,
                                        ),
                                        SizedBox(
                                          height: getHeight(Dimens.size5),
                                        ),
                                        SizedBox(
                                          width: getWidth(Dimens.size280),
                                          child: Text(
                                            data.response[index].building+", "+data.response[index].exactAddress,
                                            style: textTheme.bodyText1,
                                            overflow: TextOverflow.ellipsis,
                                            softWrap: true,
                                            maxLines: 1,
                                          ),
                                        ),
                                        SizedBox(
                                          height: getHeight(Dimens.size5),
                                        ),
                                        Text(
                                          data.response[index].city+","+data.response[index].state+", "+data.response[index].zip,
                                          style: textTheme.bodyText1,
                                        ),

                                        SizedBox(
                                          height: getHeight(Dimens.size5),
                                        ),
                                        Text(
                                          data.response[index].phoneNum,
                                          style: textTheme.bodyText1,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          controller.deleteAddressButton(
                                              ID: data.response[index].id);
                                        },
                                        child: Icon(
                                          Icons.delete_outlined,
                                          size: Dimens.size20,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      )
                    : Container(
                        height: getHeight(Dimens.size550),
                        width: getWidth(mediaQuery.width),
                        child: Center(
                            child: Text(
                          "Please add some Addresses first!",
                          style: textTheme.headline6,
                        )),
                      ),
                onLoading: Shimmer.fromColors(
                    baseColor: MyColors.grey.withOpacity(0.08),
                    highlightColor: MyColors.white,
                    child: Container(
                      height: getHeight(Dimens.size550),
                      width: getWidth(mediaQuery.width),
                      child: ListView.separated(
                        physics: BouncingScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: 6,
                        separatorBuilder: (context, index) => SizedBox(
                          height: getHeight(Dimens.size10),
                        ),
                        itemBuilder: (context, index) {
                          return Container(
                            height: getHeight(Dimens.size160),
                            width: double.infinity,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: MyColors.tertiaryColor.withOpacity(0.2)),
                          );
                        },
                      ),
                    )),
                onError: (error) => Text(error!),
              ),
              SizedBox(
                height: getHeight(Dimens.size20),
              ),
              AddButton(
                  height: getHeight(Dimens.size45),
                  width: getWidth(Dimens.size350),
                  text: Strings.addAddress,
                  onPressed: () {
                    Get.off(() => AddNewAddressSaved());
                  }),
            ],
          ),
        ),
      ),
    );
  }

  onBack() {
    Get.offAll(() => ProfileDrawer());
  }
}
