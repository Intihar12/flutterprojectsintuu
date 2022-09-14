import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../cancel_booking/cancel_ride.dart';
import '../values/dimens.dart';
import '../values/my_colors.dart';
import '../values/size_config.dart';
import '../values/strings.dart';

class OrderWithStatus extends StatelessWidget {
  String orderID;
  String status;
  int statusId;
  String securityNo;

  OrderWithStatus(
      {Key? key,
      required this.orderID,
      required this.status,
      required this.statusId,
      required this.securityNo})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    var mediaQuery = MediaQuery.of(context).size;
    var theme = Theme.of(context);
    var textTheme = theme.textTheme;
    return Container(
      height: getHeight(Dimens.size170),
      padding: EdgeInsets.symmetric(
          horizontal: Dimens.size15, vertical: Dimens.size15),
      width: getWidth(mediaQuery.width),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Dimens.size5),
          color: MyColors.black.withOpacity(0.05)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "${Strings.ant}$orderID",
                style:
                    textTheme.headline3!.copyWith(color: MyColors.primaryColor),
              ),
              // Container(
              //   height: getHeight(Dimens.size30),
              //   width: getWidth(Dimens.size100),
              //   decoration: BoxDecoration(
              //       borderRadius: BorderRadius.circular(Dimens.size5),
              //       color: MyColors.primaryColor),
              //   child: Center(
              //     child: Text(
              //       Strings.checkStatus,
              //       style: textTheme.headline6!.copyWith(color: MyColors.white),
              //     ),
              //   ),
              // ),
              (statusId < 4)
                  ? GestureDetector(
                      onTap: () {
                        Get.offAll(CancelRide(
                          orderID: orderID,
                        ));
                      },
                      child: Text(
                        "Cancel Booking?",
                        style: textTheme.subtitle2!
                            .copyWith(decoration: TextDecoration.underline),
                      ),
                    )
                  : Container(),
            ],
          ),
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${Strings.currentOrdersStatus} : ${status}",
                    style: textTheme.headline6!
                        .copyWith(color: MyColors.secondaryColor),
                  ),
                  Text(
                    status,
                    style: textTheme.headline6!.copyWith(
                        fontSize: getFont(Dimens.size12),
                        color: MyColors.black.withOpacity(0.3)),
                  ),
                ],
              ),
              Spacer(),
              statusId < 4
                  ? Container(
                      padding: EdgeInsets.all(Dimens.size5),
                      // height: getHeight(Dimens.size50),
                      // width: getWidth(Dimens.size110),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(Dimens.size5),
                          color: MyColors.white),
                      child: Column(
                        children: [
                          Text(
                            Strings.securityCode,
                            style: textTheme.bodyText1,
                          ),
                          Text(
                            "${securityNo}",
                            style: textTheme.subtitle2,
                          )
                        ],
                      ),
                    )
                  : Container(),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: getHeight(Dimens.size9),
                width: getWidth(Dimens.size50),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimens.size6),
                  color: MyColors.secondaryColor,
                ),
              ),
              Container(
                height: getHeight(Dimens.size9),
                width: getWidth(Dimens.size50),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimens.size6),
                  color: statusId > 1
                      ? MyColors.secondaryColor
                      : MyColors.secondaryColor.withOpacity(0.3),
                ),
              ),
              Container(
                height: getHeight(Dimens.size9),
                width: getWidth(Dimens.size50),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimens.size6),
                  color: statusId > 2
                      ? MyColors.secondaryColor
                      : MyColors.secondaryColor.withOpacity(0.3),
                ),
              ),
              Container(
                height: getHeight(Dimens.size9),
                width: getWidth(Dimens.size50),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimens.size6),
                  color: statusId > 3
                      ? MyColors.secondaryColor
                      : MyColors.secondaryColor.withOpacity(0.3),
                ),
              ),
              Container(
                height: getHeight(Dimens.size9),
                width: getWidth(Dimens.size50),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimens.size6),
                  color: statusId > 4
                      ? MyColors.secondaryColor
                      : MyColors.secondaryColor.withOpacity(0.3),
                ),
              ),
              Container(
                height: getHeight(Dimens.size9),
                width: getWidth(Dimens.size50),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimens.size6),
                  color: MyColors.secondaryColor.withOpacity(0.3),
                ),
              ),
            ],
          ),
          Text(
            Strings.orderNote2,
            style: textTheme.caption!.copyWith(
                fontSize: getFont(Dimens.size12),
                color: MyColors.black.withOpacity(0.3)),
          )
        ],
      ),
    );
  }
}
