import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:nepalihiphub/controller/homepagecontroller.dart';

import 'package:nepalihiphub/view/login/login.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    Box box = Hive.box('localData');
    bool isLoggedIn = box.get("isLoggedin") ?? false;
    final controller = Get.put(HomepageContoller());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        centerTitle: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("NepaliHibHub"),
            if (!isLoggedIn) ...[
              InkWell(
                  onTap: () {
                    Get.to(const Login());
                  },
                  child: const Text(
                    "Login",
                    style: TextStyle(color: Colors.blue),
                  )),
            ] else ...[
              InkWell(
                  onTap: () {
                    box.put("isLoggedin", false);
                  },
                  child: const Text(
                    "Logout",
                    style: TextStyle(color: Colors.red),
                  )),
            ]
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),
              const Text(
                "From Earth to the\nUniverse",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              const SizedBox(
                height: 10,
              ),
              const Center(
                child: CircleAvatar(
                  backgroundImage: AssetImage("assets/images/yamabuddha.jpg"),
                  radius: 100,
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                height: 250,
                width: double.maxFinite,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(18)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 12),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.circular(8)),
                      child: const Text(
                        "We miss you Yama Buddha",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(
                      height: 3,
                    ),
                    const Text(
                      "Click on rose to react",
                      style: TextStyle(color: Colors.blue),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    InkWell(
                      onTap: () {
                        controller.addLike();
                      },
                      child: CircleAvatar(
                        radius: 30,
                        child: Image.asset(
                          "assets/images/rose.png",
                          height: 50,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 12),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.circular(8)),
                        child: Obx(
                          () => Text(
                            "Total Reaction: ${controller.totalLikes}",
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ))
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
