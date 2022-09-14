import 'package:antrakuserinc/ui/values/dimens.dart';
import 'package:antrakuserinc/ui/values/my_colors.dart';
import 'package:antrakuserinc/ui/values/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:get/get.dart';

class AddressWidget extends StatelessWidget {
  final String aptName;
  final String aptNum;
  final String title;
  final String city;
  final String state;

  final String zipCode;
  final String phone;
  final String exactAddress;

  void  Function() onTap;


  AddressWidget({
    Key? key,
    required this.aptName,
    required this.aptNum,
    required this.title,
    required this.city,
    required this.state,

    required this.zipCode,
    required this.phone,
    required this.exactAddress,
    required this.onTap,


  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var theme = Theme.of(context);
    var textTheme = theme.textTheme;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
            color: MyColors.addressCon,
            borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: textTheme.bodyText2!.copyWith(fontWeight: FontWeight.bold, fontSize: getFont(14)),
            ),
            Text(
              aptName,
              style: textTheme.bodyText2!.copyWith( fontSize: getFont(14)),
            ),
            Text(
              exactAddress,
              softWrap: true,
              overflow: TextOverflow.ellipsis,
              style: textTheme.bodyText2!.copyWith(fontSize: getFont(14)),
            ),
            Text(
              "$city, $state, $zipCode",
              softWrap: true,
              overflow: TextOverflow.ellipsis,
              style: textTheme.bodyText2!.copyWith( fontSize: getFont(14)),
            ),


            Text(
              phone,
              style: textTheme.bodyText2!.copyWith(fontSize: getFont(14)),
            ),
          ],
        ),
      ),
    );
  }
}
