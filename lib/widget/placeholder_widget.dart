import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:i_preview_music/common/placeholder_type.dart';
import 'package:i_preview_music/style/app_dimen.dart';
import 'package:i_preview_music/style/app_text_style.dart';
import 'package:lottie/lottie.dart';

/// Created by rizkyagungramadhan@gmail.com
/// on 5/17/2022.

class PlaceholderWidget extends StatelessWidget {
  final double? animationHeight;
  final PlaceholderType type;

  const PlaceholderWidget({Key? key, this.animationHeight, required this.type})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      margin: const EdgeInsets.all(AppDimen.paddingExtraLarge4),
      child: Column(
        children: [
          Lottie.asset(type.animationPath,
              height: animationHeight ?? Get.height / 4),
          const SizedBox(height: AppDimen.paddingExtraSmall),
          Text(
            type.description,
            style: AppTextStyle.regular(),
            textAlign: TextAlign.center,
            maxLines: 2,
          ),
        ],
      ),
    );
  }
}
