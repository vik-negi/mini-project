import 'package:evika/views/chat_view/user_Chat_page.dart';
import 'package:flutter/material.dart'; // import 'package:whatsapp/pages/camera.dart';

class MoreOptionsToSend extends StatelessWidget {
  const MoreOptionsToSend({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 380,
      width: MediaQuery.of(context).size.width,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        margin: const EdgeInsets.only(left: 11, right: 11, bottom: 60),
        color: const Color.fromARGB(255, 233, 233, 233),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 65),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  OptionsToSend(
                    name: "Document",
                    iconWidget: Icons.insert_drive_file,
                    color: Colors.indigo,
                  ),
                  OptionsToSend(
                    name: "Camera",
                    iconWidget: Icons.camera_alt,
                    color: Colors.pink,
                    // functionality: Camera(),
                  ),
                  OptionsToSend(
                      name: "Gallery",
                      iconWidget: Icons.insert_photo,
                      color: Colors.purple),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  OptionsToSend(
                      name: "Audio",
                      iconWidget: Icons.headset_rounded,
                      color: Colors.orange),
                  OptionsToSend(
                    name: "Payment",
                    iconWidget: Icons.currency_rupee,
                    color: Colors.teal,
                  ),
                  OptionsToSend(
                    name: "Location",
                    iconWidget: Icons.location_pin,
                    color: Colors.green,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  OptionsToSend(
                    name: "Contact",
                    iconWidget: Icons.person,
                    color: Colors.blue,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class OptionsToSend extends StatelessWidget {
  const OptionsToSend(
      {Key? key, this.iconWidget, this.name, this.color, this.functionality})
      : super(key: key);
  final iconWidget;
  final name;
  final color;
  final functionality;

  @override
  Widget build(BuildContext context) {
    bool isWeb = MediaQuery.of(context).size.width > 700 ? true : false;
    return InkWell(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (builder) => functionality));
      },
      child: Column(
        children: [
          CircleAvatar(
            radius: 25,
            backgroundColor: color,
            child: Icon(
              iconWidget,
              size: 29,
              color: Colors.white,
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          !isWeb
              ? Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    name,
                    style: const TextStyle(
                        // fontSize: 18,
                        ),
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}

class Mots extends StatefulWidget {
  Mots({
    Key? key,
    required this.height,
    this.borderR,
    this.marginC,
    this.paddingC,
    required this.list,
  }) : super(key: key);
  double height;
  double? borderR;
  EdgeInsetsGeometry? marginC;
  EdgeInsetsGeometry? paddingC;
  List<MoreOption> list;
  late int lenList = list.length;
  @override
  State<Mots> createState() => _MotsState();
}

class _MotsState extends State<Mots> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: widget.height,
        width: MediaQuery.of(context).size.width,
        child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(widget.borderR ?? 0),
            ),
            margin: widget.marginC ??
                const EdgeInsets.only(left: 11, right: 11, bottom: 60),
            color: const Color.fromARGB(255, 233, 233, 233),
            child: Padding(
              padding: widget.paddingC ??
                  const EdgeInsets.symmetric(vertical: 30, horizontal: 65),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 9.2,
                  mainAxisSpacing: 18.5,
                ),
                itemCount: widget.list.length,
                itemBuilder: (context, i) {
                  return OptionsToSend(
                    name: widget.list[i].name,
                    color: widget.list[i].color,
                    iconWidget: widget.list[i].iconName,
                  );
                },
              ),
            )));
  }
}

class MotsWeb extends StatelessWidget {
  const MotsWeb({
    Key? key,
    required this.list,
  }) : super(key: key);
  final List<MoreOption> list;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: (MediaQuery.of(context).size.width * 0.5 - 40)),
      child: Container(
        padding: const EdgeInsets.only(bottom: 65),
        width: 80,
        height: 600,
        child: ListView.builder(
          itemCount: list.length,
          itemBuilder: (context, i) {
            return OptionsToSend(
              name: list[i].name,
              color: list[i].color,
              iconWidget: list[i].iconName,
            );
          },
        ),
      ),
    );
  }
}
