import 'package:evika/models/user/post_model.dart';
import 'package:evika/utils/widgets/post_container_widget.dart';
import 'package:evika/view_models/home_viewmodel.dart/post_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:hexcolor/hexcolor.dart';

class TrandingPage extends StatefulWidget {
  const TrandingPage({super.key});

  @override
  State<TrandingPage> createState() => _TrandingPageState();
}

class _TrandingPageState extends State<TrandingPage> {
  PostVM postVM = Get.put(PostVM());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: Text(
          "Evika",
          style: TextStyle(
              color: HexColor('#224957').withOpacity(0.7),
              fontFamily: 'LexendDeca',
              fontSize: 28,
              fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 2),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              "Trending",
              style: TextStyle(
                  color: Colors.black45,
                  fontFamily: 'LexendDeca',
                  fontSize: 18),
            ),
            Text("Top 10",
                style: TextStyle(
                    color: Colors.black26,
                    fontFamily: 'LexendDeca',
                    fontSize: 12)),
            Divider(),
            SizedBox(
                child: Row(
              children: <Widget>[
                Expanded(
                    flex: 8,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Health Ministry launches Jan Jagrukta Abhiyaan in New Delhi",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontFamily: 'LexendDeca',
                              color: HexColor('#656565'),
                              fontSize: 14),
                        ),
                        Row(
                          children: <Widget>[
                            Text(
                              "Posted on 24 July 2024",
                              style: TextStyle(
                                  fontFamily: 'LexendDeca',
                                  color: HexColor('#656565'),
                                  fontSize: 11),
                            ),
                            SizedBox(width: 30),
                            Container(
                              height: 14,
                              width: 14,
                              child: Image.asset('assets/like.png'),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              "24K",
                              style: TextStyle(color: HexColor('#656565')),
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Container(
                              height: 14,
                              width: 14,
                              child: Image.asset('assets/share.png'),
                            ),
                          ],
                        )
                      ],
                    )),
                Expanded(
                    flex: 2,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: Image(image: AssetImage('assets/img2.jpeg')),
                    ))
              ],
            )),
            Divider(),
            SizedBox(
                child: Row(
              children: <Widget>[
                Expanded(
                    flex: 8,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Health Ministry launches Jan Jagrukta Abhiyaan in New Delhi",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontFamily: 'LexendDeca',
                              color: HexColor('#656565'),
                              fontSize: 14),
                        ),
                        Row(
                          children: <Widget>[
                            Text(
                              "Posted on 24 July 2024",
                              style: TextStyle(
                                  fontFamily: 'LexendDeca',
                                  color: HexColor('#656565'),
                                  fontSize: 11),
                            ),
                            SizedBox(width: 30),
                            Container(
                              height: 14,
                              width: 14,
                              child: Image.asset('assets/like.png'),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              "24K",
                              style: TextStyle(color: HexColor('#656565')),
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Container(
                              height: 14,
                              width: 14,
                              child: Image.asset('assets/share.png'),
                            ),
                          ],
                        )
                      ],
                    )),
                Expanded(
                    flex: 2,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: Image(image: AssetImage('assets/img2.jpeg')),
                    ))
              ],
            )),
            Divider(),
            SizedBox(
                child: Row(
              children: <Widget>[
                Expanded(
                    flex: 8,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Health Ministry launches Jan Jagrukta Abhiyaan in New Delhi",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontFamily: 'LexendDeca',
                              color: HexColor('#656565'),
                              fontSize: 14),
                        ),
                        Row(
                          children: <Widget>[
                            Text(
                              "Posted on 24 July 2024",
                              style: TextStyle(
                                  fontFamily: 'LexendDeca',
                                  color: HexColor('#656565'),
                                  fontSize: 11),
                            ),
                            SizedBox(width: 30),
                            Container(
                              height: 14,
                              width: 14,
                              child: Image.asset('assets/like.png'),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              "24K",
                              style: TextStyle(color: HexColor('#656565')),
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Container(
                              height: 14,
                              width: 14,
                              child: Image.asset('assets/share.png'),
                            ),
                          ],
                        )
                      ],
                    )),
                Expanded(
                    flex: 2,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: Image(image: AssetImage('assets/img2.jpeg')),
                    ))
              ],
            )),
            Divider(),
            SizedBox(
                child: Row(
              children: <Widget>[
                Expanded(
                    flex: 8,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Health Ministry launches Jan Jagrukta Abhiyaan in New Delhi",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontFamily: 'LexendDeca',
                              color: HexColor('#656565'),
                              fontSize: 14),
                        ),
                        Row(
                          children: <Widget>[
                            Text(
                              "Posted on 24 July 2024",
                              style: TextStyle(
                                  fontFamily: 'LexendDeca',
                                  color: HexColor('#656565'),
                                  fontSize: 11),
                            ),
                            SizedBox(width: 30),
                            Container(
                              height: 14,
                              width: 14,
                              child: Image.asset('assets/like.png'),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              "24K",
                              style: TextStyle(color: HexColor('#656565')),
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Container(
                              height: 14,
                              width: 14,
                              child: Image.asset('assets/share.png'),
                            ),
                          ],
                        )
                      ],
                    )),
                Expanded(
                    flex: 2,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: Image(image: AssetImage('assets/img2.jpeg')),
                    ))
              ],
            )),
            Divider(),
            SizedBox(
                child: Row(
              children: <Widget>[
                Expanded(
                    flex: 8,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Health Ministry launches Jan Jagrukta Abhiyaan in New Delhi",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontFamily: 'LexendDeca',
                              color: HexColor('#656565'),
                              fontSize: 14),
                        ),
                        Row(
                          children: <Widget>[
                            Text(
                              "Posted on 24 July 2024",
                              style: TextStyle(
                                  fontFamily: 'LexendDeca',
                                  color: HexColor('#656565'),
                                  fontSize: 11),
                            ),
                            SizedBox(width: 30),
                            Container(
                              height: 14,
                              width: 14,
                              child: Image.asset('assets/like.png'),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              "24K",
                              style: TextStyle(color: HexColor('#656565')),
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Container(
                              height: 14,
                              width: 14,
                              child: Image.asset('assets/share.png'),
                            ),
                          ],
                        )
                      ],
                    )),
                Expanded(
                    flex: 2,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: Image(image: AssetImage('assets/img2.jpeg')),
                    ))
              ],
            )),
            Divider(),
            SizedBox(
                child: Row(
              children: <Widget>[
                Expanded(
                    flex: 8,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Health Ministry launches Jan Jagrukta Abhiyaan in New Delhi",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontFamily: 'LexendDeca',
                              color: HexColor('#656565'),
                              fontSize: 14),
                        ),
                        Row(
                          children: <Widget>[
                            Text(
                              "Posted on 24 July 2024",
                              style: TextStyle(
                                  fontFamily: 'LexendDeca',
                                  color: HexColor('#656565'),
                                  fontSize: 11),
                            ),
                            SizedBox(width: 30),
                            Container(
                              height: 14,
                              width: 14,
                              child: Image.asset('assets/like.png'),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              "24K",
                              style: TextStyle(color: HexColor('#656565')),
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Container(
                              height: 14,
                              width: 14,
                              child: Image.asset('assets/share.png'),
                            ),
                          ],
                        )
                      ],
                    )),
                Expanded(
                    flex: 2,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: Image(image: AssetImage('assets/img2.jpeg')),
                    ))
              ],
            )),
            Divider(),
            SizedBox(
                child: Row(
              children: <Widget>[
                Expanded(
                    flex: 8,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Health Ministry launches Jan Jagrukta Abhiyaan in New Delhi",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontFamily: 'LexendDeca',
                              color: HexColor('#656565'),
                              fontSize: 14),
                        ),
                        Row(
                          children: <Widget>[
                            Text(
                              "Posted on 24 July 2024",
                              style: TextStyle(
                                  fontFamily: 'LexendDeca',
                                  color: HexColor('#656565'),
                                  fontSize: 11),
                            ),
                            SizedBox(width: 30),
                            Container(
                              height: 14,
                              width: 14,
                              child: Image.asset('assets/like.png'),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              "24K",
                              style: TextStyle(color: HexColor('#656565')),
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Container(
                              height: 14,
                              width: 14,
                              child: Image.asset('assets/share.png'),
                            ),
                          ],
                        )
                      ],
                    )),
                Expanded(
                    flex: 2,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: Image(image: AssetImage('assets/img2.jpeg')),
                    ))
              ],
            )),
            Divider(),
            SizedBox(
                child: Row(
              children: <Widget>[
                Expanded(
                    flex: 8,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Health Ministry launches Jan Jagrukta Abhiyaan in New Delhi",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontFamily: 'LexendDeca',
                              color: HexColor('#656565'),
                              fontSize: 14),
                        ),
                        Row(
                          children: <Widget>[
                            Text(
                              "Posted on 24 July 2024",
                              style: TextStyle(
                                  fontFamily: 'LexendDeca',
                                  color: HexColor('#656565'),
                                  fontSize: 11),
                            ),
                            SizedBox(width: 30),
                            Container(
                              height: 14,
                              width: 14,
                              child: Image.asset('assets/like.png'),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              "24K",
                              style: TextStyle(color: HexColor('#656565')),
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Container(
                              height: 14,
                              width: 14,
                              child: Image.asset('assets/share.png'),
                            ),
                          ],
                        )
                      ],
                    )),
                Expanded(
                    flex: 2,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: Image(image: AssetImage('assets/img2.jpeg')),
                    ))
              ],
            )),
            Divider(),
            SizedBox(
                child: Row(
              children: <Widget>[
                Expanded(
                    flex: 8,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Health Ministry launches Jan Jagrukta Abhiyaan in New Delhi",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontFamily: 'LexendDeca',
                              color: HexColor('#656565'),
                              fontSize: 14),
                        ),
                        Row(
                          children: <Widget>[
                            Text(
                              "Posted on 24 July 2024",
                              style: TextStyle(
                                  fontFamily: 'LexendDeca',
                                  color: HexColor('#656565'),
                                  fontSize: 11),
                            ),
                            SizedBox(width: 30),
                            Container(
                              height: 14,
                              width: 14,
                              child: Image.asset('assets/like.png'),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              "24K",
                              style: TextStyle(color: HexColor('#656565')),
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Container(
                              height: 14,
                              width: 14,
                              child: Image.asset('assets/share.png'),
                            ),
                          ],
                        )
                      ],
                    )),
                Expanded(
                    flex: 2,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: Image(image: AssetImage('assets/img2.jpeg')),
                    ))
              ],
            )),
            Divider(),
            SizedBox(
                child: Row(
              children: <Widget>[
                Expanded(
                    flex: 8,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Health Ministry launches Jan Jagrukta Abhiyaan in New Delhi",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontFamily: 'LexendDeca',
                              color: HexColor('#656565'),
                              fontSize: 14),
                        ),
                        Row(
                          children: <Widget>[
                            Text(
                              "Posted on 24 July 2024",
                              style: TextStyle(
                                  fontFamily: 'LexendDeca',
                                  color: HexColor('#656565'),
                                  fontSize: 11),
                            ),
                            SizedBox(width: 30),
                            Container(
                              height: 14,
                              width: 14,
                              child: Image.asset('assets/like.png'),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              "24K",
                              style: TextStyle(color: HexColor('#656565')),
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Container(
                              height: 14,
                              width: 14,
                              child: Image.asset('assets/share.png'),
                            ),
                          ],
                        )
                      ],
                    )),
                Expanded(
                    flex: 2,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: Image(image: AssetImage('assets/img2.jpeg')),
                    ))
              ],
            )),
            Divider(),
            Container(
              child: Text(
                "Who To Follow",
                style: TextStyle(
                    fontFamily: 'LexendDeca',
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: HexColor('#707070')),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            SizedBox(
              child: Row(children: <Widget>[
                Expanded(
                    flex: 1,
                    child: Container(
                      child: CircleAvatar(
                        backgroundImage: AssetImage('assets/img4.jpg'),
                      ),
                    )),
                SizedBox(
                  width: 15,
                ),
                Expanded(
                    flex: 7,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text("Young Social Reformers",
                            style: TextStyle(
                                fontFamily: 'LexendDeca',
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                color: HexColor('#707070'))),
                        Text(
                          "Followers 100K",
                          style: TextStyle(
                              fontFamily: 'LexendDeca',
                              color: HexColor('#656565'),
                              fontSize: 11),
                        )
                      ],
                    )),
                Expanded(
                    flex: 2,
                    child: Container(
                        margin: EdgeInsets.all(2),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.blueAccent.withOpacity(0.85)),
                        width: 90,
                        height: 25,
                        alignment: Alignment.center,
                        child: Text("Follow",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontFamily: 'LexendDeca')))),
              ]),
            ),
            SizedBox(
              height: 20,
            ),
            SizedBox(
              child: Row(children: <Widget>[
                Expanded(
                    flex: 1,
                    child: Container(
                      child: CircleAvatar(
                        backgroundImage: AssetImage('assets/img4.jpg'),
                      ),
                    )),
                SizedBox(
                  width: 15,
                ),
                Expanded(
                    flex: 7,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text("Younth Promotor Org",
                            style: TextStyle(
                                fontFamily: 'LexendDeca',
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                color: HexColor('#707070'))),
                        Text(
                          "Followers 300K",
                          style: TextStyle(
                              fontFamily: 'LexendDeca',
                              color: HexColor('#656565'),
                              fontSize: 11),
                        )
                      ],
                    )),
                Expanded(
                    flex: 2,
                    child: Container(
                        margin: EdgeInsets.all(2),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.blueAccent.withOpacity(0.85)),
                        width: 90,
                        height: 25,
                        alignment: Alignment.center,
                        child: Text("Follow",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontFamily: 'LexendDeca')))),
              ]),
            ),
            SizedBox(
              height: 20,
            ),
            SizedBox(
              child: Row(children: <Widget>[
                Expanded(
                    flex: 1,
                    child: Container(
                      child: CircleAvatar(
                        backgroundImage: AssetImage('assets/img4.jpg'),
                      ),
                    )),
                SizedBox(
                  width: 15,
                ),
                Expanded(
                    flex: 7,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text("Ministry of Youth Affairs",
                            style: TextStyle(
                                fontFamily: 'LexendDeca',
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                color: HexColor('#707070'))),
                        Text(
                          "Followers 10K",
                          style: TextStyle(
                              fontFamily: 'LexendDeca',
                              color: HexColor('#656565'),
                              fontSize: 11),
                        )
                      ],
                    )),
                Expanded(
                    flex: 2,
                    child: Container(
                        margin: EdgeInsets.all(2),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.blueAccent.withOpacity(0.85)),
                        width: 90,
                        height: 25,
                        alignment: Alignment.center,
                        child: Text("Follow",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontFamily: 'LexendDeca')))),
              ]),
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              "See More",
              style: TextStyle(
                  decoration: TextDecoration.underline,
                  color: Colors.blueAccent,
                  fontFamily: 'LexendDeca'),
            ),
            SizedBox(
              height: 30,
            )
          ]),
        ),
      ),
    );
  }
}
