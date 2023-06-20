import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:nepalihiphub/view/free_beats/free_beats.dart';

import '../paid_beats/paid_beats.dart';

class BeatPage extends StatelessWidget {
  const BeatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 22),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Our beats",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Color.fromRGBO(37, 76, 104, 1)),
              ),
              const SizedBox(height: 20),
              InkWell(
                  onTap: () {
                    Get.to(const Freebeats());
                  },
                  child: buildContainer(
                      title: "Free Beats",
                      subTitle: "Enjoy Free Beats ",
                      url:
                          "https://images.template.net/wp-content/uploads/2016/06/20091636/Vector-Melody-Music-Logo.jpg")),
              const SizedBox(height: 10),
              InkWell(
                onTap: () {
                  Get.to(const PaidBeats());
                },
                child: buildContainer(
                    title: "Purchase Beats",
                    subTitle: "Buy latest Beats",
                    url:
                        "https://img.freepik.com/premium-vector/hand-holding-money-cartoon-illustration_525134-61.jpg?w=2000"),
              )
            ],
          ),
        ),
      ),
    );
  }
}

Container buildContainer({
  required String title,
  required String subTitle,
  required String url,
}) {
  return Container(
    decoration: BoxDecoration(
        color: Colors.white, borderRadius: BorderRadius.circular(22)),
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 60,
          width: 60,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              image:
                  DecorationImage(fit: BoxFit.fill, image: NetworkImage(url))),
        ),
        const SizedBox(width: 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              subTitle,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
