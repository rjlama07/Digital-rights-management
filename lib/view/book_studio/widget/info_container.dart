import 'package:flutter/material.dart';
import 'package:nepalihiphub/model/studio_model.dart';

class StudioInfo extends StatefulWidget {
  const StudioInfo({super.key, required this.studioModel});
  final StudioModel studioModel;

  @override
  State<StudioInfo> createState() => _StudioInfoState();
}

class _StudioInfoState extends State<StudioInfo> {
  bool isExpanded = false;
  @override
  Widget build(BuildContext context) {
    buildText(
        {required String text,
        double size = 15,
        Color color = Colors.white,
        FontWeight fontWeight = FontWeight.bold}) {
      return Text(
        text,
        textAlign: TextAlign.justify,
        style: TextStyle(
            color: color,
            fontSize: size,
            fontFamily: "Montserrat",
            fontWeight: fontWeight),
      );
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.black54)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.fill,
                          image: NetworkImage(widget.studioModel.imageUrl!)),
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    height: 60,
                    width: 60,
                  ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      buildText(text: widget.studioModel.name!),
                      const SizedBox(height: 4),
                      Row(
                        children: List.generate(
                            5,
                            (index) => Icon(
                                  Icons.star,
                                  size: 18,
                                  color: index <
                                          (int.parse(
                                              widget.studioModel.ratings!))
                                      ? Colors.yellow.withOpacity(0.75)
                                      : Colors.grey[300],
                                )),
                      )
                    ],
                  )
                ],
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    isExpanded = !isExpanded;
                  });
                },
                child: Icon(
                  isExpanded
                      ? Icons.keyboard_arrow_up
                      : Icons.keyboard_arrow_down,
                  size: 30,
                ),
              )
            ],
          ),
          if (isExpanded) ...[
            const SizedBox(
              height: 10,
            ),
            buildText(
                fontWeight: FontWeight.w400,
                size: 12,
                text: widget.studioModel.description!),
            const SizedBox(height: 10),
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.black54)),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.location_on,
                        color: Color(0xFF2D5290),
                      ),
                      buildText(
                          text: widget.studioModel.location!,
                          fontWeight: FontWeight.w600,
                          size: 12)
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.black54)),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.monetization_on,
                        color: Color(0xFF2D5290),
                      ),
                      const SizedBox(width: 3),
                      buildText(
                          text: "Rs ${widget.studioModel.price}",
                          fontWeight: FontWeight.w600,
                          size: 12)
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Container(
              decoration: BoxDecoration(
                  color: const Color(0xFF2D5290),
                  borderRadius: BorderRadius.circular(22)),
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 6),
              child: buildText(
                  size: 16,
                  text: "Book Now",
                  color: Colors.white,
                  fontWeight: FontWeight.w500),
            )
          ]
        ],
      ),
    );
  }
}
