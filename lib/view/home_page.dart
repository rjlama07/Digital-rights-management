import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nepalihiphub/constant/app_colors.dart';
import 'package:nepalihiphub/widget/tredning_song.dart';

import '../controller/producer_profile_controller.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    // Box box = Hive.box('localData');
    // bool isLoggedIn = box.get("isLoggedin") ?? false;
    // final controller = Get.put(HomepageContoller());
    final controller = Get.put(ProducerProfileController());

    Widget headingText(String text) {
      return Text(text, style: Theme.of(context).textTheme.titleLarge);
    }

    Widget rowHeading({required String text, required Function ontap}) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          headingText(text),
          Icon(
            Icons.arrow_forward_ios_outlined,
            size: 18.h,
          )
        ],
      );
    }

    List<FakeProducer> fakeProducer = [
      FakeProducer(
        name: "Oozai",
        imageUrl:
            "https://instagram.fktm3-1.fna.fbcdn.net/v/t51.2885-15/319069792_838860200722746_4188244303298702076_n.webp?stp=dst-jpg_e35&_nc_ht=instagram.fktm3-1.fna.fbcdn.net&_nc_cat=106&_nc_ohc=NoTfJfKw1wsAX8rLAc1&edm=ACWDqb8BAAAA&ccb=7-5&ig_cache_key=Mjk5MTY5NDE2MjgwNjYyODk0MQ%3D%3D.2-ccb7-5&oh=00_AfAck76_Wwv4D8lgEiaIZ8779J7De4yMX9BEcTBx2kM3Gg&oe=64A8A8C5&_nc_sid=ee9879",
      ),
      FakeProducer(
        name: "Sik Music",
        imageUrl:
            "https://i1.sndcdn.com/avatars-2hzc7jNV4yWzmttf-UIzwDA-t240x240.jpg",
      ),
      FakeProducer(
        name: "The 977",
        imageUrl:
            "https://i.ytimg.com/vi/XTaETiwCgzo/maxresdefault.jpg?sqp=-oaymwEmCIAKENAF8quKqQMa8AEB-AH-CYAC0AWKAgwIABABGGUgTyhIMA8=&rs=AOn4CLC-Dci2Gjje_NO2BA5eqxqKfd7V9g",
      )
    ];

    List<FakeMusic> dummmyMusic = [
      FakeMusic(
          music: "Ravana",
          artist: "Dong",
          view: "100m Streams",
          imageUrl:
              "https://scontent.fktm3-1.fna.fbcdn.net/v/t1.6435-9/176738680_1453450948337103_5132348385065889829_n.jpg?_nc_cat=105&cb=99be929b-59f725be&ccb=1-7&_nc_sid=8bfeb9&_nc_ohc=btj9QrGyLDUAX-5eKZj&_nc_ht=scontent.fktm3-1.fna&oh=00_AfCLS682_S_07wmyHAN69kYqS5HpW40n5KzcJ30qTyam1g&oe=64CBD122"),
      FakeMusic(
          music: "Unwritten",
          artist: "Nasty",
          view: "10k Streams",
          imageUrl: "https://i.ytimg.com/vi/drgmR0gUTNA/maxresdefault.jpg"),
      FakeMusic(
          music: "Sathi",
          artist: "Yama Buddha",
          view: "120m Streams",
          imageUrl: "https://i.ytimg.com/vi/3UL4FXBl2kA/maxresdefault.jpg")
    ];

    return Scaffold(
        body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(22),
                color: secondaryBackgroundColor,
              ),
              child: Padding(
                padding: EdgeInsets.zero,
                child: TextField(
                  readOnly: true,
                  decoration: InputDecoration(
                    hintText: "Search for music",
                    suffixIcon: Icon(
                      size: 18.sp,
                      Icons.mic,
                      color: Colors.white,
                    ),
                    prefixIcon: Icon(
                      Icons.search,
                      color: white,
                      size: 18.sp,
                    ),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
            SizedBox(height: 15.h),
            rowHeading(text: "Trending Music", ontap: () {}),
            SizedBox(height: 15.h),
            SizedBox(
              height: 80.h,
              child: ListView.separated(
                separatorBuilder: (context, index) => const SizedBox(
                  width: 10,
                ),
                scrollDirection: Axis.horizontal,
                itemCount: dummmyMusic.length,
                itemBuilder: (context, index) {
                  return TrendingMusic(
                    musicTitle: dummmyMusic[index].music,
                    musicArtist: dummmyMusic[index].artist,
                    requiredViews: dummmyMusic[index].view,
                    imageUrl: dummmyMusic[index].imageUrl,
                  );
                },
              ),
            ),
            SizedBox(height: 15.h),
            rowHeading(text: "Trending Artist", ontap: () {}),
            SizedBox(height: 15.h),
            SizedBox(
              height: 170.h,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: fakeProducer.length,
                separatorBuilder: (context, index) => const SizedBox(width: 10),
                itemBuilder: (context, index) {
                  return Container(
                    decoration: BoxDecoration(
                        color: secondaryBackgroundColor,
                        borderRadius: BorderRadius.circular(12)),
                    child: Column(
                      children: [
                        Container(
                            height: 140.h,
                            width: 126.w,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    fit: BoxFit.fill,
                                    image: NetworkImage(
                                        fakeProducer[index].imageUrl)),
                                borderRadius: const BorderRadius.only(
                                  topRight: Radius.circular(8),
                                  topLeft: Radius.circular(8),
                                ))),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                            child: Text(
                              fakeProducer[index].name,
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    ));
  }
}

class FakeMusic {
  String music;
  String artist;
  String view;
  String imageUrl;
  FakeMusic(
      {required this.music,
      required this.artist,
      required this.view,
      required this.imageUrl});
}

class FakeProducer {
  String name;
  String imageUrl;
  FakeProducer({required this.name, required this.imageUrl});
}
