//
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// import '../home_page.dart';
//
// class MyDrawer extends StatelessWidget {
//    MyDrawer({
//     Key? key,
//
//   }) : super(key: key);
//
//   final googleController = Get.put(GoogleController());
//
//   @override
//   Widget build(BuildContext context) {
//     var mediaQuery=MediaQuery.of(context).size;
//     return Drawer(
//       elevation: 0,
//       child:Column(
//         mainAxisAlignment: MainAxisAlignment.start,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Container(
//             height: mediaQuery.height*0.2,
//             width: mediaQuery.width,
//             decoration: BoxDecoration(
//                 color: Get.theme.primaryColor,
//             ),
//             child: Padding(
//               padding: const EdgeInsets.all(Dimens.size12),
//               child: Row(
//                 children: [
//                   CircleAvatar(
//                     radius: 30,
//                     backgroundImage:   NetworkImage("${SingleToneValue.instance.storage.read("image")}") ,
//
//                   ),
//                   SizedBox(width: Dimens.size10,),
//                   Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(SingleToneValue.instance.storage.read('name'),style: TextStyle(
//                           fontSize: Dimens.size20,
//                           color: MyColors.white,
//                           fontWeight: FontWeight.bold
//                       ),),
//                       Text(SingleToneValue.instance.storage.read('email'),style: TextStyle(
//                           fontSize: Dimens.size10,
//                           color: MyColors.white,
//                           fontWeight: FontWeight.normal
//                       ),),
//
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(Dimens.size12),
//             child: Column(
//               children: [
//                 SizedBox(height: Dimens.size20,),
//
//                 DrawerItemWidget(title: "Home", icon: Icon(Icons.home, size: Dimens.size30,),
//                   onTap: (){
//                   Get.to(()=>HomePage(),
//                     transition: Transition.leftToRightWithFade,
//                     duration: const Duration(milliseconds: 700),
//                   );
//                 },
//                 ),
//                 SizedBox(height: Dimens.size20,),
//
//
//               ],
//             ),
//           ),
//         ],
//       ) ,
//     );
//   }
// }
//
// class DrawerItemWidget extends StatelessWidget {
//   final String title;
//   final Icon icon;
//   final Function() onTap;
//    DrawerItemWidget({
//     required this.title,
//     required this.icon,
//      required this.onTap,
//     Key? key,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.start,
//         children: [
//           icon,
//           SizedBox(width: Dimens.size10,),
//           Text(title, style: Get.textTheme.headline2!.copyWith(
//               fontWeight: FontWeight.normal
//           ),)
//         ],
//       ),
//     );
//   }
// }
//
