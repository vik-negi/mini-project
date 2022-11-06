import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 65),
      child:
          Column(crossAxisAlignment: CrossAxisAlignment.end, children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(
              width: 10,
            ),
            Text(
              "Signout",
              style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'LexendDeca',
                  color: HexColor('#224957').withOpacity(0.85)),
            )
          ],
        ),
        const Center(
          child: CircleAvatar(
            radius: 60,
            backgroundImage: AssetImage('assets/man.png'),
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        Container(
          child: Row(
            children: <Widget>[
              Expanded(
                  flex: 8,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Username",
                          style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'LexendDeca',
                              color: HexColor('#656565'))),
                      Text("@shivamgupta",
                          style: TextStyle(
                              fontSize: 28,
                              fontFamily: 'LexendDeca',
                              color: HexColor('#224957').withOpacity(0.85))),
                      Text("shivamgupta@gmail.com",
                          style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'LexendDeca',
                              color: HexColor('#656565').withOpacity(0.85)))
                    ],
                  )),
              Expanded(
                  flex: 2,
                  child: Container(
                      margin: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.blueAccent.withOpacity(0.85)),
                      width: 90,
                      height: 25,
                      alignment: Alignment.center,
                      child: const Text("Edit",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontFamily: 'LexendDeca')))),
            ],
          ),
        ),
        const Divider(),
        Container(
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Account Type",
                        style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'LexendDeca',
                            color: HexColor('#656565'))),
                    Text("Individual",
                        style: TextStyle(
                            fontSize: 14,
                            fontFamily: 'LexendDeca',
                            color: HexColor('#224957').withOpacity(0.85)))
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Verification Status",
                        style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'LexendDeca',
                            color: HexColor('#656565'))),
                    const Text("Unverified",
                        style: TextStyle(
                            fontSize: 14,
                            fontFamily: 'LexendDeca',
                            color: Colors.lightBlueAccent,
                            decoration: TextDecoration.underline))
                  ],
                )
              ]),
        ),
        const Divider(),
        const SizedBox(
          height: 30,
        ),
        ElevatedButton.icon(
            onPressed: () {
              Get.to(() => const ProfilePage());
            },
            icon: const Icon(Icons.message),
            label: const Text("Chart"))
      ]),
    ));
  }
}
