import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nepalihiphub/controller/nav_bar_controller.dart';
import 'package:nepalihiphub/controller/producer_details_controller.dart';
import 'package:nepalihiphub/model/artist_model.dart';

class ArtistProfile extends StatefulWidget {
  const ArtistProfile({super.key, required this.artistModel});

  final ArtistModel artistModel;

  @override
  State<ArtistProfile> createState() => _ArtistProfileState();
}

class _ArtistProfileState extends State<ArtistProfile> {
  void followUnfollow() {
    Get.find<ProducerDetailsController>().followUnfollowArtist(
        widget.artistModel.id,
        artistModel: widget.artistModel,
        isFollowing: widget.artistModel.isFollowing);
    widget.artistModel.isFollowing = !widget.artistModel.isFollowing;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
              pinned: true,
              expandedHeight: MediaQuery.of(context).size.height * 0.3,
              flexibleSpace: FlexibleSpaceBar(
                background: Image.network(
                  widget.artistModel.profileUrl,
                  fit: BoxFit.cover,
                ),
                title: Text(widget.artistModel.name),
                centerTitle: false,
              )),
          GetBuilder<ProducerDetailsController>(
              init: ProducerDetailsController(artistId: widget.artistModel.id),
              builder: (controller) {
                return SliverList(
                    delegate: SliverChildBuilderDelegate(
                  childCount: controller.song.length,
                  (context, index) {
                    return Obx(() => controller.song.isEmpty
                        ? const Center(
                            child: Text("No song found"),
                          )
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Visibility(
                                visible: index == 0,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 22),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(
                                        height: 30,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          InkWell(
                                            onTap: () => followUnfollow(),
                                            child: Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 8,
                                                      vertical: 8),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                  border: Border.all(
                                                      color: Colors.white)),
                                              child: Text(
                                                widget.artistModel.isFollowing
                                                    ? "Following"
                                                    : "Follow",
                                                style: const TextStyle(
                                                    fontSize: 12),
                                              ),
                                            ),
                                          ),
                                          const Icon(Icons.menu_outlined)
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      const Text("Popular"),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              ListTile(
                                  onTap: () {
                                    Get.find<NavBarController>().changeMusic(
                                        imageUrl: controller
                                                    .song[index].imageUrl ==
                                                ""
                                            ? "https://scontent.fktm8-1.fna.fbcdn.net/v/t39.30808-6/428657177_122100298364221583_4711367863059791283_n.jpg?_nc_cat=104&ccb=1-7&_nc_sid=5f2048&_nc_ohc=_8fVjhUNfT8AX_Mp5M7&_nc_ht=scontent.fktm8-1.fna&oh=00_AfAkZZibrkJNtCfJ1PreEWs-u6j__F6cpQc-3IkO7U2Vxg&oe=65F3C64C"
                                            : controller.song[index].imageUrl,
                                        name: controller.song[index].songName,
                                        beatId: controller.song[index].id,
                                        beatUrl:
                                            controller.song[index].songUrl);
                                  },
                                  leading: SizedBox(
                                    child: Image.network(controller
                                                .song[index].imageUrl ==
                                            ""
                                        ? "https://scontent.fktm8-1.fna.fbcdn.net/v/t39.30808-6/428657177_122100298364221583_4711367863059791283_n.jpg?_nc_cat=104&ccb=1-7&_nc_sid=5f2048&_nc_ohc=_8fVjhUNfT8AX_Mp5M7&_nc_ht=scontent.fktm8-1.fna&oh=00_AfAkZZibrkJNtCfJ1PreEWs-u6j__F6cpQc-3IkO7U2Vxg&oe=65F3C64C"
                                        : controller.song[index].imageUrl),
                                  ),
                                  title: Text(controller.song[index].songName),
                                  subtitle:
                                      Text(controller.song[index].artist)),
                              if (index == controller.song.length - 1)
                                const SizedBox(
                                  height: 100,
                                ),
                            ],
                          ));
                  },
                ));
              })
        ],
      ),
    );
  }
}
