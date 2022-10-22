import 'package:evika/views/description/description.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class TrendingPostCard extends StatelessWidget {
  final title;
  final postedDate;
  const TrendingPostCard(
      {super.key, required this.title, required this.postedDate});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          child: Row(
            children: <Widget>[
              Expanded(
                flex: 7,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 5,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              new MaterialPageRoute(
                                  builder: (context) => Description()));
                        },
                        child: Text(
                          title,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontFamily: 'LexendDeca',
                              color: HexColor('#656565'),
                              fontSize: 14),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        // mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "Posted on $postedDate",
                            style: TextStyle(
                                fontFamily: 'LexendDeca',
                                color: HexColor('#656565'),
                                fontSize: 11),
                          ),
                          const SizedBox(width: 30),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const SizedBox(
                                height: 14,
                                width: 14,
                                child: Icon(
                                  Icons.thumb_up_off_alt_rounded,
                                  size: 15,
                                ),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                "24K",
                                style: TextStyle(
                                    fontFamily: 'LexendDeca',
                                    color: HexColor('#656565'),
                                    fontSize: 15),
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                              const SizedBox(
                                height: 14,
                                width: 14,
                                child: Icon(
                                  CupertinoIcons.arrowshape_turn_up_right_fill,
                                  size: 14,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: const Image(image: AssetImage('assets/img2.jpeg')),
                ),
              ),
            ],
          ),
        ),
        const Divider(
          thickness: 1,
        ),
      ],
    );
  }
}
