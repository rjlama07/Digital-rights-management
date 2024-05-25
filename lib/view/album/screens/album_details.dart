import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khalti_flutter/khalti_flutter.dart';
import 'package:nepalihiphub/constant/app_colors.dart';
import 'package:nepalihiphub/controller/nav_bar_controller.dart';
import 'package:nepalihiphub/controller/producer_details_controller.dart';
import 'package:nepalihiphub/model/album_model.dart';
import 'package:nepalihiphub/services/album_services.dart';

class AlbumDetails extends StatefulWidget {
  const AlbumDetails({super.key, required this.albumModel});

  final AlbumModel albumModel;

  @override
  State<AlbumDetails> createState() => _AlbumDetailsState();
}

class _AlbumDetailsState extends State<AlbumDetails> {
  // void followUnfollow() {
  //   Get.find<ProducerDetailsController>().followUnfollowArtist(
  //       widget.artistModel.id,
  //       artistModel: widget.artistModel,
  //       isFollowing: widget.artistModel.isFollowing);
  //   widget.artistModel.isFollowing = !widget.artistModel.isFollowing;
  //   setState(() {});
  // }

  void payWithKhaltiApp(AlbumModel album) {
    KhaltiScope.of(context).pay(
      preferences: [PaymentPreference.khalti],
      config: PaymentConfig(
          amount: (int.parse(album.price.toString())) * 100,
          productIdentity: album.id!,
          productName: album.albumName.toString()),
      onSuccess: (value) async {
        final response = await AlbumSercies().buyAlbum(album.id.toString());
        response.fold(
          (l) {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  content: const Text("Payment Sucessfull"),
                  actions: [
                    SimpleDialogOption(
                      child: const Text("Ok"),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    )
                  ],
                );
              },
            );
          },
          (r) {
            Get.snackbar("Error", r);
          },
        );
      },
      onFailure: (value) {
        debugPrint(value.toString());
      },
    );
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
                  widget.albumModel.imageUrl,
                  fit: BoxFit.cover,
                ),
                title: Text(widget.albumModel.albumName),
                centerTitle: false,
              )),
          SliverList(
              delegate: SliverChildBuilderDelegate(
            childCount: widget.albumModel.songs.length,
            (context, index) {
              return widget.albumModel.songs.isEmpty
                  ? const Center(
                      child: Text("No song found"),
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Visibility(
                          visible: index == 0,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 22),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: 30,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    if (widget.albumModel.type == "paid" &&
                                        !widget.albumModel.isBought!)
                                      InkWell(
                                        onTap: () {
                                          payWithKhaltiApp(widget.albumModel);
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8, vertical: 8),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              border: Border.all(
                                                  color: Colors.white)),
                                          child: const Text(
                                            "Buy now",
                                            style: TextStyle(fontSize: 12),
                                          ),
                                        ),
                                      ),
                                    Spacer(),
                                    if (widget.albumModel.type == "free" ||
                                        widget.albumModel.isBought!)
                                      InkWell(
                                        onTap: () {
                                          Get.find<NavBarController>()
                                              .playPlaylist(
                                                  imageUrls: widget
                                                      .albumModel.songs
                                                      .map((element) => element
                                                          .imageUrl)
                                                      .toList(),
                                                  names:
                                                      widget.albumModel.songs
                                                          .map(
                                                              (e) => e.songName)
                                                          .toList(),
                                                  beatIds:
                                                      widget
                                                          .albumModel.songs
                                                          .map((e) => e.id)
                                                          .toList(),
                                                  beatUrls: widget
                                                      .albumModel.songs
                                                      .map((element) =>
                                                          element.songUrl)
                                                      .toList());
                                        },
                                        child: CircleAvatar(
                                            backgroundColor:
                                                secondaryBackgroundColor,
                                            child:
                                                const Icon(Icons.play_arrow)),
                                      )
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
                            onLongPress: !widget.albumModel.isBought!
                                ? null
                                : () {
                                    showModalBottomSheet(
                                      context: context,
                                      builder: (context) {
                                        return Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            ListTile(
                                                onTap: () {
                                                  Get.find<NavBarController>()
                                                      .addLikeSong(
                                                          onSucesss: () {
                                                            Get.back();
                                                          },
                                                          beatId: widget
                                                              .albumModel
                                                              .songs[index]
                                                              .id);
                                                },
                                                title: const Row(
                                                  children: [
                                                    Icon(
                                                      Icons.favorite,
                                                      color: Colors.red,
                                                    ),
                                                    SizedBox(
                                                      width: 20,
                                                    ),
                                                    Text("Add to Favourite"),
                                                  ],
                                                )),
                                            ListTile(
                                                onTap: () {},
                                                title: const Row(
                                                  children: [
                                                    Icon(
                                                      Icons.report,
                                                      color: Colors.red,
                                                    ),
                                                    SizedBox(
                                                      width: 20,
                                                    ),
                                                    Text("Report Song"),
                                                  ],
                                                ))
                                          ],
                                        );
                                      },
                                    );
                                  },
                            onTap: () {
                              if (widget.albumModel.isBought!) {
                                Get.find<NavBarController>().playSingleSong(
                                    imageUrl: widget.albumModel.songs[index]
                                                .imageUrl ==
                                            ""
                                        ? "https://scontent.fktm8-1.fna.fbcdn.net/v/t39.30808-6/428657177_122100298364221583_4711367863059791283_n.jpg?_nc_cat=104&ccb=1-7&_nc_sid=5f2048&_nc_ohc=_8fVjhUNfT8AX_Mp5M7&_nc_ht=scontent.fktm8-1.fna&oh=00_AfAkZZibrkJNtCfJ1PreEWs-u6j__F6cpQc-3IkO7U2Vxg&oe=65F3C64C"
                                        : widget
                                            .albumModel.songs[index].imageUrl,
                                    name:
                                        widget.albumModel.songs[index].songName,
                                    beatId: widget.albumModel.songs[index].id,
                                    beatUrl:
                                        widget.albumModel.songs[index].songUrl);
                              } else {
                                Get.snackbar("Error",
                                    "Please buy the album to play the song");
                              }
                            },
                            leading: SizedBox(
                              child: Image.network(widget
                                          .albumModel.songs[index].imageUrl ==
                                      ""
                                  ? "https://scontent.fktm8-1.fna.fbcdn.net/v/t39.30808-6/428657177_122100298364221583_4711367863059791283_n.jpg?_nc_cat=104&ccb=1-7&_nc_sid=5f2048&_nc_ohc=_8fVjhUNfT8AX_Mp5M7&_nc_ht=scontent.fktm8-1.fna&oh=00_AfAkZZibrkJNtCfJ1PreEWs-u6j__F6cpQc-3IkO7U2Vxg&oe=65F3C64C"
                                  : widget.albumModel.songs[index].imageUrl),
                            ),
                            title:
                                Text(widget.albumModel.songs[index].songName),
                            subtitle:
                                Text(widget.albumModel.songs[index].artist)),
                        if (index == widget.albumModel.songs.length - 1)
                          const SizedBox(
                            height: 100,
                          ),
                      ],
                    );
            },
          ))
        ],
      ),
    );
  }
}
