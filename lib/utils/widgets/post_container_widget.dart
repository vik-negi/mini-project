import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

List<String> images = [
  "https://static.toiimg.com/thumb/msid-67840697,width-400,resizemode-4/67840697.jpg",
  "https://images.news18.com/ibnlive/uploads/2019/06/Turmeric-Festival-1.jpg?impolicy=website&width=0&height=0"
];

var months = [
  'Jan',
  'Feb',
  'Mar',
  'Apr',
  'May',
  'Jun',
  'Jul',
  'Aug',
  'Sep',
  'Oct',
  'Nov',
  'Dec'
];
var postData = {
  "userId": "6335e15917b058c245976c9b",
  "description":
      "This is some description about the post what id the post is about",
  "image": ["imageString"],
  "tags": [],
  "eventCategory": "Other",
  "eventStartAt": "2022-10-01T18:23:05.785Z",
  "eventEndAt": "2022-10-05T18:23:05.786Z",
  "eventId": "63388589fe777a4221da0c39",
  "eventLocation": "Online",
  "eventDescription":
      "Bhandara serves as an agricultural center for farmers in the region, who mostly grow rice. The city speaks Marathi language. Bhandara city is famous for brass and is known as ' Brass City ' also, Bhandara, as a district is famous for lakes and is known as ' District of lakes ' . Bhandara is split between two rivers, the Wainganga and the Sur, and crossed by National Highway No. 6. The city is surrounded by industries like Ashok Leyland, Sunflag Steel and an ordnance factory. The Wainganga is the principal river in the district and the only stream that does not dry up in the hot weather.",
  "likes": 23,
  "noOfComments": 0,
  "_id": "63388589fe777a4221da0c3a",
  "likedUsers": [],
  "comments": [],
  "createdAt": "2022-10-01T18:23:05.787Z",
  "__v": 0
};

// take 2022-10-01T18:23:05.787Z format and retrun 12 hrs format
String convertTime(String time) {
  var date = DateTime.parse(time);
  var hour = date.hour;
  var min = date.minute;
  var ampm = hour >= 12 ? 'pm' : 'am';
  hour = hour % 12;
  hour = hour != 0 ? hour : 12;
  var minStr = min < 10 ? '0$min' : '$min';
  return '$hour:$minStr $ampm';
}

String getDate(String dateTime) {
  var date = DateTime.parse(dateTime);
  var day = date.day;
  var month = date.month;
  var year = date.year;
  // list of months
  return '$day-${months[month - 1]}-$year';
}

class PostContainer extends StatelessWidget {
  const PostContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 330,
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.only(bottom: 10),
      width: Get.width,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 0),
          ),
        ],
      ),
      child: Column(
        children: [
          SizedBox(
            width: Get.width,
            child: Stack(
              children: [
                Container(
                  height: 200,
                  decoration: const BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    child: FadeInImage(
                      width: Get.width - 20,
                      fit: BoxFit.cover,
                      placeholder: const AssetImage(
                          "assets/placeholderimageloading.gif"),
                      image: NetworkImage(images[0]),
                    ),
                  ),
                ),
                // add a container that has a gradinet of two colors
                Container(
                  height: 200,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      tileMode: TileMode.decal,
                      colors: [
                        Colors.black.withOpacity(0.9),
                        Colors.black.withOpacity(0.0),
                        Colors.black.withOpacity(0.0),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  child: Container(
                    width: Get.width - 50,
                    margin: const EdgeInsets.all(11),
                    child: RichText(
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      text: const TextSpan(
                        text: "Bhandara of the Navratri year 2022",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                            fontFamily: "LexendDeca",
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  right: 0,
                  child: Container(
                    margin: const EdgeInsets.all(15),
                    child: const Icon(
                      Icons.favorite_border,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                ),
                Positioned(
                  top: 11,
                  left: 11,
                  child: Container(
                    padding: const EdgeInsets.all(5),
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 0, 68, 227),
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.receipt_long_sharp,
                          size: 10,
                          color: Colors.white,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        RichText(
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          text: const TextSpan(
                            text: "Reginstration Required!",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(5),
            height: 110,
            width: Get.width,
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: Get.width - 85,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Icon(
                                Icons.calendar_month_sharp,
                                // color: Colors.grey,
                                size: 15,
                              ),
                              const SizedBox(
                                width: 3,
                              ),
                              RichText(
                                text: TextSpan(
                                  text: getDate(
                                      postData["eventStartAt"].toString()),
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontFamily: "LexendDeca",
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Container(
                            margin: const EdgeInsets.only(left: 2),
                            child: const Icon(
                              Icons.more_horiz_rounded,
                              // color: Colors.grey,
                              size: 12,
                            ),
                          ),
                          Row(
                            children: [
                              const Icon(
                                Icons.calendar_month_sharp,
                                // color: Colors.grey,
                                size: 15,
                              ),
                              const SizedBox(
                                width: 3,
                              ),
                              RichText(
                                text: TextSpan(
                                  text: getDate(
                                      postData["eventEndAt"].toString()),
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontFamily: "LexendDeca",
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      RichText(
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        text: TextSpan(
                          text: postData["description"].toString(),
                          style: TextStyle(
                            color: Colors.grey.shade800,
                            fontFamily: "LexendDeca",
                            fontSize: 18,
                          ),
                        ),
                      ),
                      Row(
                        // mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.circle,
                            color: Colors.grey,
                            size: 5,
                          ),
                          const SizedBox(
                            width: 3,
                          ),
                          RichText(
                            text: const TextSpan(
                              text: "Bhandara Association of America",
                              style: TextStyle(
                                color: Colors.grey,
                                fontFamily: "LexendDeca",
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(left: 10),
                      child: Icon(
                        // CupertinoIcons.arrow_turn_up_right,
                        CupertinoIcons.arrowshape_turn_up_right,
                        color: Colors.grey.shade600,
                        size: 30,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 10),
                      child: Icon(
                        Icons.notifications_none_outlined,
                        color: Colors.grey.shade600,
                        size: 30,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
