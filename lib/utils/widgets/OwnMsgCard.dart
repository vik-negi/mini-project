import 'package:flutter/material.dart';

class OwnMsgCard extends StatelessWidget {
  const OwnMsgCard({Key? key, required this.text, required this.time}) : super(key: key);
  final String text;
  final String time;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width - 45,
        ),
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          color: const Color(0xffdcf8c6),
          margin: const EdgeInsets.only(top: 15, right: 15),
          child: Stack(
            children: [
              Padding(
                  padding: EdgeInsets.only(
                    top: 5,
                    bottom: ((text.length % 47)) < 38 ? 10 : 25,
                    left: 10,
                    right: text.length > 37 ? 20 : 75,
                  ),
                  child: Text(
                    text,
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  )),
              text.length > 30
                  ? const SizedBox(
                      width: 45,
                    )
                  : const SizedBox(width: 0),
              Positioned(
                bottom: 4,
                right: 10,
                child: Row(
                  children:  [
                    Text(time,
                        overflow: TextOverflow.ellipsis,
                        softWrap: false,
                        style: const TextStyle(
                            fontSize: 12, fontWeight: FontWeight.w400)),
                    const SizedBox(
                      width: 3,
                    ),
                    Icon(
                      Icons.done_all,
                      size: 18,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
