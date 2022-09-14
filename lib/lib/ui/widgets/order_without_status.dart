import 'package:antrakuserinc/ui/cancel_booking/cancel_ride.dart';
import 'package:antrakuserinc/ui/values/dimens.dart';
import 'package:antrakuserinc/ui/values/my_colors.dart';
import 'package:antrakuserinc/ui/values/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:get/get.dart';

import '../values/size_config.dart';

class OrderWithoutStatus extends StatelessWidget {
  String orderId;
  String status;
  String pickDate;
  int statusId;
  String securityNo;

   OrderWithoutStatus({Key? key, required this.orderId, required this.status,
     required this.statusId,
     required this.pickDate,
   required this.securityNo
   }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    var mediaQuery = MediaQuery.of(context).size;
    var theme = Theme.of(context);
    var textTheme = theme.textTheme;
    return Container(
      height: getHeight(Dimens.size170),
      padding: EdgeInsets.symmetric(
          horizontal: Dimens.size15, vertical: Dimens.size12),
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
                pickDate,
                style:
                    textTheme.headline6!.copyWith(color: MyColors.secondaryColor),
              ),
              // GestureDetector(
              //   onTap: (){
              //     Get.offAll(CancelRide(orderID: orderId,));
              //   },
              //   child: Text(
              //     "Cancel Booking?",
              //     style: textTheme.subtitle2!.copyWith(
              //       decoration: TextDecoration.underline
              //     ),
              //   ),
              // ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Order ID #$orderId${Strings.ant}",
                    style: textTheme.headline4!
                        .copyWith(color: MyColors.greyFont),
                  ),

                  Text(
                    "$status",
                    style: textTheme.bodyText2,
                  )
                ],
              ),
              Column(
                children: [

                  Container(
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
                  ),
                ],
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: getHeight(Dimens.size9),
                width: getWidth(Dimens.size60),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimens.size6),
                  color: MyColors.secondaryColor,
                ),
              ),
              Container(
                height: getHeight(Dimens.size9),
                width: getWidth(Dimens.size60),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimens.size6),
                  color: statusId>1 ? MyColors.secondaryColor :   MyColors.secondaryColor.withOpacity(0.3),
                ),
              ),
              Container(
                height: getHeight(Dimens.size9),
                width: getWidth(Dimens.size60),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimens.size6),
                  color: statusId>2 ? MyColors.secondaryColor :   MyColors.secondaryColor.withOpacity(0.3),
                ),
              ),
              Container(
                height: getHeight(Dimens.size9),
                width: getWidth(Dimens.size60),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimens.size6),
                  color: statusId>3 ? MyColors.secondaryColor :   MyColors.secondaryColor.withOpacity(0.3),
                ),
              ),
              Container(
                height: getHeight(Dimens.size9),
                width: getWidth(Dimens.size60),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimens.size6),
                  color: statusId>4 ? MyColors.secondaryColor :   MyColors.secondaryColor.withOpacity(0.3),
                ),
              ),
            ],
          ),

          Text(
            Strings.orderNote,
            style: textTheme.caption!.copyWith(
                fontSize: getFont(Dimens.size12),
                color: MyColors.black.withOpacity(0.3)),
          )
        ],
      ),
    );
  }
}
