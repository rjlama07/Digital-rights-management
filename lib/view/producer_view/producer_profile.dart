import 'package:flutter/material.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:nepalihiphub/controller/producer_profile_controller.dart';
import 'package:nepalihiphub/model/producermodel.dart';

class ProducerProfile extends StatelessWidget {
  const ProducerProfile({super.key, required this.producerModel});
  final ProducerModel producerModel;

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ProducerProfileController>();

    List<String> items = ["Basic", "Standard", "Premium"];
    final PackageModel basicPackage =
        PackageModel.fromJson(producerModel.package["basic"]);
    final PackageModel standard =
        PackageModel.fromJson(producerModel.package["standard"]);
    final PackageModel premium =
        PackageModel.fromJson(producerModel.package["premium"]);

    Widget package(PackageModel packageModel) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 22),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(26),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(0.4),
                  offset: const Offset(0, 3),
                  blurRadius: 2,
                  spreadRadius: 1)
            ]),
        child: Column(children: [
          rowData(titile: "Version", info: packageModel.version),
          const SizedBox(height: 12),
          rowData(titile: "Revision", info: "${packageModel.revision} times"),
          const SizedBox(height: 15),
          rowData(titile: "Price", info: "Rs ${packageModel.price}")
        ]),
      );
    }

    List<Widget> packageWidget = [
      package(basicPackage),
      package(standard),
      package(premium)
    ];

    Widget tabBarButton({required String title, required int index}) {
      return Expanded(
        child: InkWell(
            onTap: () {
              controller.index.value = index;
            },
            child: Obx(
              () => Container(
                decoration: BoxDecoration(
                    color: controller.index.value == index ? Colors.blue : null,
                    borderRadius: BorderRadius.circular(12)),
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                child: Center(
                  child: Text(
                    title,
                    style: controller.index.value == index
                        ? controller.selectedTextStyle
                        : controller.unselectedTextStyle,
                  ),
                ),
              ),
            )),
      );
    }

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.06,
                ),
                CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(producerModel.profileUrl),
                ),
                const SizedBox(height: 8),
                Text(producerModel.name,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold)),
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                        5,
                        (index) => Icon(
                              Icons.star,
                              color: index < (int.parse(producerModel.rating))
                                  ? Colors.yellow[400]
                                  : Colors.grey,
                            )))
              ],
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.black)),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 22, vertical: 22),
                    child: Column(
                      children: [
                        rowData(
                            titile: "Active Since",
                            info: producerModel.activeSince),
                        const SizedBox(height: 10),
                        rowData(
                            titile: "Average Delivery time",
                            info: producerModel.averageDeliveryTime),
                        const SizedBox(height: 10),
                        rowData(titile: "Genre", info: producerModel.genre),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    width: double.maxFinite,
                    height: 60,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(26),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey.withOpacity(0.4),
                              offset: const Offset(0, 3),
                              blurRadius: 2,
                              spreadRadius: 1)
                        ]),
                    child: Row(
                      children: items
                          .map((e) =>
                              tabBarButton(title: e, index: items.indexOf(e)))
                          .toList(),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Obx(() => IndexedStack(
                        index: controller.index.value,
                        children: packageWidget,
                      ))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget rowData({
    required String titile,
    required String info,
  }) {
    return Row(
      children: [
        Text(
          "$titile:",
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        const Spacer(),
        Text(
          info,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        )
      ],
    );
  }
}
