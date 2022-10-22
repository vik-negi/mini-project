import 'package:evika/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class Description extends StatefulWidget {
  const Description({super.key});

  @override
  State<Description> createState() => _DescriptionState();
}

class _DescriptionState extends State<Description> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Description',
          style: TextStyle(
            color: AppColors.secondaryColor,
            fontFamily: "LexendDeca",
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        backgroundColor: Colors.white,
        foregroundColor: AppColors.secondaryColor,
      ),
      body: RefreshIndicator(
        onRefresh: () {
          return Future(() => null);
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            child: Column(
              children: <Widget>[
                SizedBox(
                    width: double.infinity,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: const Image(
                            image: AssetImage('assets/img2.jpeg')))),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'POSHAN JAGRUKTA ABHIYAAN started by central goverment',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: 'LexendDeca',
                      color: HexColor('#656565'),
                      fontSize: 18),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: <Widget>[
                    const Icon(
                      Icons.person,
                    ),
                    Text(
                      "Young Social Reformers",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: 'LexendDeca',
                          color: HexColor('#707070'),
                          fontSize: 14),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    const Icon(Icons.pin_drop),
                    Text(
                      "Azamgarh",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: 'LexendDeca',
                          color: HexColor('#707070'),
                          fontSize: 14),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: <Widget>[
                    const Icon(
                      Icons.date_range_rounded,
                    ),
                    Text(
                      "Starting on 27/10/2022",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: 'LexendDeca',
                          color: HexColor('#707070'),
                          fontSize: 14),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    const Icon(Icons.date_range_rounded),
                    Text(
                      "Ends on 10/12/2022",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: 'LexendDeca',
                          color: HexColor('#707070'),
                          fontSize: 14),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "POSHAN Abhiyaan, strives to induce behavioural change through nutrition centric Jan Andolans in the form of Poshan Pakhwadas, Poshan Maahs and Community Based Events (CBEc) through involvement of Panchayati Raj Institutions/Villages Organizations/SHGs/volunteers etc. and ensuring wide public participation. States/UTs are carrying out IEC activities on regular basis. The month of September is celebrated as Rashtriya Poshan Maah across the country. The Rashtriya Poshan Maah 2021 witnessed wide participation and enthusiasm from convergent Ministries, States/UTs and field functionaries. Besides, community groups, Panchayati Raj Institutions, staff at Block and District level also participated in the month long activities. The activities were monitored online, in real time using the POSHAN Abhiyaan Jan Andolan Dashboard, that provided for data entry at National, State, District and Block levels.",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: 'LexendDeca',
                      color: HexColor('#908080'),
                      fontSize: 16),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
