import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nepalihiphub/constant/app_colors.dart';

class TrendingMusic extends StatelessWidget {
  const TrendingMusic(
      {super.key,
      required this.musicArtist,
      required this.musicTitle,
      required this.imageUrl,
      required this.requiredViews});

  final String musicTitle;
  final String musicArtist;
  final String requiredViews;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 220.w,
      decoration: BoxDecoration(
        color: secondaryBackgroundColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12), bottomLeft: Radius.circular(12)),
            child: Image.network(
              imageUrl,
              fit: BoxFit.fill,
              height: 80.h,
              width: 80.w,
            ),
          ),
          SizedBox(width: 20.w),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                musicTitle,
                style: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(color: textColor1),
              ),
              SizedBox(height: 1.h),
              Text(
                musicArtist,
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: textColor1,
                      fontWeight: FontWeight.w500,
                    ),
              ),
              SizedBox(height: 2.h),
              Text(
                requiredViews,
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: textColor1,
                    fontWeight: FontWeight.w500,
                    fontSize: 10.sp),
              ),
            ],
          )
        ],
      ),
    );
  }
}
