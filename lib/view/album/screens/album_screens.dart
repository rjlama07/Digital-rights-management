import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nepalihiphub/constant/app_colors.dart';
import 'package:nepalihiphub/controller/album_controller.dart';
import 'package:nepalihiphub/view/album/screens/album_details.dart';

enum Filter { all, free, paid, myPurchased }

class AlbumScreens extends StatefulWidget {
  const AlbumScreens({super.key});

  @override
  State<AlbumScreens> createState() => _AlbumScreensState();
}

class _AlbumScreensState extends State<AlbumScreens> {
  Filter selectedFilter = Filter.all;
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final contoller = Get.put(AlbumControllr());
    return Scaffold(
        body: SafeArea(
      child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 26),
          child: Obx(
            () {
              if (contoller.isLoading.value) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (contoller.isError.value) {
                return Center(child: Text(contoller.errorMessage));
              } else {
                return Column(
                  children: [
                    SingleChildScrollView(
                      controller: _scrollController,
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: List.generate(
                          Filter.values.length * 2 -
                              1, // Calculate the length needed for both containers and SizedBoxes
                          (index) {
                            if (index.isEven) {
                              return filterContainer(
                                  filter: Filter.values[index ~/ 2]);
                            } else {
                              return const SizedBox(
                                  width: 10.0); // Adjust the width as needed
                            }
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Expanded(
                        child: GridView.builder(
                      itemCount: contoller.filterList.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10),
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Get.to(AlbumDetails(
                              albumModel: contoller.filterList[index],
                            ));
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    colorFilter: ColorFilter.mode(
                                        Colors.black.withOpacity(0.5),
                                        BlendMode.darken),
                                    fit: BoxFit.cover,
                                    image: NetworkImage(
                                        contoller.filterList[index].imageUrl)),
                                color: primaryColor,
                                borderRadius: BorderRadius.circular(20)),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Spacer(),
                                  Text(contoller.filterList[index].albumName),
                                  Text(contoller.filterList[index].type),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ))
                  ],
                );
              }
            },
          )),
    ));
  }

  Container filterContainer({required Filter filter}) {
    final duration = Duration(milliseconds: 300); // Adjust duration as needed
    final curve = Curves.easeOut;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 6),
      decoration: BoxDecoration(
          color: selectedFilter == filter ? Colors.red : Colors.grey,
          borderRadius: BorderRadius.circular(22)),
      child: InkWell(
          onTap: () {
            setState(() {
              selectedFilter = filter;
            });
            if (filter == Filter.all ||
                filter == Filter.free ||
                filter == Filter.paid) {
              _scrollController.animateTo(
                0,
                duration: duration,
                curve: curve,
              );
            } else if (filter == Filter.myPurchased) {
              _scrollController.animateTo(
                _scrollController.position.maxScrollExtent,
                duration: duration,
                curve: curve,
              );
            }
            Get.find<AlbumControllr>().filterAlbum(filter);
          },
          child: Text(filter.name.capitalizeFirst ?? "")),
    );
  }
}
