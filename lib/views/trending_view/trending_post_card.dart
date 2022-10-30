import 'package:evika/utils/colors.dart';
import 'package:evika/views/description/description.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class TrendingPostCard extends StatelessWidget {
  final title;
  final postedDate;
  final index;
  const TrendingPostCard(
      {super.key,
      required this.title,
      required this.postedDate,
      required this.index});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 30),
          child: Row(
            children: <Widget>[
              Container(
                margin: const EdgeInsets.only(right: 5),
                child: Row(
                  children: [
                    Text(
                      index.toString(),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Icon(Icons.arrow_right_rounded),
                  ],
                ),
              ),
              Expanded(
                flex: 7,
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 5,
                    bottom: 5,
                    right: 7,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Description(
                                        tag: index.toString(),
                                      )));
                        },
                        child: Text(
                          title,
                          style: const TextStyle(
                              fontWeight: FontWeight.w500,
                              fontFamily: 'LexendDeca',
                              // color: HexColor('#656565'),
                              color: AppColors.primaryColor,
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
                child: Hero(
                  tag: index.toString(),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(3),
                    child: const Image(image: AssetImage('assets/img2.jpeg')),
                  ),
                ),
              ),
            ],
          ),
        ),
        // const Divider(
        //   thickness: 1,
        // ),
      ],
    );
  }
}
