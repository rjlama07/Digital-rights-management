import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nepalihiphub/constant/app_colors.dart';
import 'package:nepalihiphub/controller/producer_profile_controller.dart';
import 'package:nepalihiphub/model/artist_model.dart';
import 'package:nepalihiphub/view/producer_view/artist_profile.dart';

class ProducerView extends StatelessWidget {
  const ProducerView({Key? key, required this.artistProfile}) : super(key: key);
  final List<ArtistModel> artistProfile;

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ProducerProfileController>();
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemCount: controller.artist.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ArtistProfile(
                    artistModel: controller.artist[index],
                  ),
                )),
                child: Container(
                  decoration: BoxDecoration(
                    color: secondaryBackgroundColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        height: 100.h,
                        width: 126.w,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          image: DecorationImage(
                            fit: BoxFit.fill,
                            image: NetworkImage(
                                controller.artist[index].profileUrl),
                          ),
                          borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(8),
                            topLeft: Radius.circular(8),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: Text(
                            controller.artist[index].name,
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
