import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:i_preview_music/api/music/music_track_response.dart';
import 'package:i_preview_music/common/app_assets.dart';
import 'package:i_preview_music/routes/app_route.dart';
import 'package:i_preview_music/style/app_color.dart';
import 'package:i_preview_music/style/app_dimen.dart';
import 'package:i_preview_music/style/app_text_style.dart';
import 'package:i_preview_music/widget/app_text.dart';
import 'package:lottie/lottie.dart';
import 'package:skeletons/skeletons.dart';
import 'package:tap_debouncer/tap_debouncer.dart';

/// Created by rizkyagungramadhan@gmail.com
/// on 5/17/2022.

class MusicItemView extends StatelessWidget {
  final MusicTrackResponse item;
  final bool isPlaying;
  final Future<void> Function()? onPressed;

  const MusicItemView(
      {required this.item,
      required this.onPressed,
      this.isPlaying = false,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color:
          item.isStreamable ? Colors.transparent : CupertinoColors.systemGrey5,
      child: TapDebouncer(
        onTap: onPressed,
        builder: (BuildContext context, Future<void> Function()? onTap) {
          return InkWell(
            onTap: onTap,
            child: Padding(
              padding: const EdgeInsets.all(AppDimen.paddingMedium),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  ///Album ArtWork
                  Hero(
                    tag: item.trackId,
                    child: SizedBox(
                      width: AppDimen.iconSizeMax,
                      height: AppDimen.iconSizeMax,
                      child: ClipRRect(
                          borderRadius:
                              BorderRadius.circular(AppDimen.paddingMedium),
                          child: CachedNetworkImage(
                            fadeInDuration: Duration.zero,
                            fadeOutDuration: Duration.zero,
                            fit: BoxFit.cover,
                            imageUrl: item.trackArtWorkUrl,
                            placeholder: (context, url) => const SkeletonAvatar(
                              style: SkeletonAvatarStyle(
                                width: AppDimen.iconSizeMax,
                                height: AppDimen.iconSizeMax,
                              ),
                            ),
                            errorWidget: (context, url, error) => Image.asset(
                                AppAssets.noImage,
                                fit: BoxFit.cover),
                          )),
                    ),
                  ),

                  ///Song, Artist & Collection name
                  const SizedBox(
                    width: AppDimen.paddingMedium,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AppText(
                          item.trackName,
                          style: AppTextStyle.regular(size: AppDimen.fontLarge),
                        ),
                        AppText(item.artistName),
                        AppText(item.collectionName)
                      ],
                    ),
                  ),

                  ///Beat Animation
                  if (isPlaying)
                    ConstrainedBox(
                      constraints: const BoxConstraints(
                          maxHeight: AppDimen.iconSizeMax,
                          maxWidth: AppDimen.iconSizeMax),
                      child: Lottie.asset(AppAssets.animationBeat),
                    ),
                  if (isPlaying) const SizedBox(width: AppDimen.paddingLarge),

                  ///Track Information
                  InkWell(
                      onTap: () =>
                          Get.toNamed(AppRoute.trackDetail, arguments: item),
                      child: const Icon(
                        Icons.more_vert_rounded,
                        color: AppColor.accent,
                        size: AppDimen.iconSizeExtraLarge,
                      ))
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
