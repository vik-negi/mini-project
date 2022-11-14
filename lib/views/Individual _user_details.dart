// import 'package:evika/models/user/user_chat_model.dart';
// import 'package:evika/utils/widgets/PopUpMenuBtn.dart';
// import 'package:evika/utils/widgets/custom_user_chat.dart';
// import 'package:flutter/material.dart';

// class IndividualUserDetails extends StatefulWidget {
//   const IndividualUserDetails({
//     Key? key,
//     required this.userChatModel,
//   }) : super(key: key);
//   final UserChatModel userChatModel;

//   @override
//   State<IndividualUserDetails> createState() => _IndividualUserDetailsState();
// }

// class _IndividualUserDetailsState extends State<IndividualUserDetails> {
//   ScrollController _scrollController = ScrollController();
//   double _scrollPosition = 0;

//   _scrollListener() {
//     setState(() {
//       _scrollPosition = _scrollController.position.pixels;
//     });
//   }

//   @override
//   void initState() {
//     _scrollController.addListener(_scrollListener);
//     super.initState();
//   }

//   List<String> items = [
//     "Share",
//     "Edit",
//     "View in address book",
//     "Verify security code",
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: CustomScrollView(
//         slivers: [
//           SliverAppBar(
//             expandedHeight: 200,
//             leadingWidth: 75,
//             pinned: true,
//             flexibleSpace: FlexibleSpaceBar(
//               title: CircularAvatarWidget(
//                 userChatModel: widget.userChatModel,
//                 radiusOfAvatar: 50,
//                 isChatPage: true,
//                 isContactPage: false,
//               ),
//             ),
//             leading: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   SizedBox(
//                     width: 25,
//                     child: IconButton(
//                       onPressed: () {
//                         Navigator.pop(context);
//                       },
//                       icon: const Icon(
//                         Icons.arrow_back,
//                       ),
//                     ),
//                   ),
//                   // InkWell(
//                   //   child: CircularAvatarWidget(
//                   //     isContactPage: true,
//                   //     isChatPage: false,
//                   //     userChatModel: widget.userChatModel,
//                   //     radiusOfAvatar: 20,
//                   //     isStatusPage: false,
//                   //   ),
//                   // ),
//                 ]),
//             actions: [
//               IconButton(
//                 onPressed: () {
//                   PopupMenuBtn(items: items);
//                 },
//                 icon: const Icon(Icons.more_vert),
//               ),
//             ],
//           ),
//           SliverToBoxAdapter(
//             child: SingleChildScrollView(
//                 child: Column(
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.symmetric(vertical: 8.0),
//                   child: Text(
//                     widget.userChatModel.name,
//                     style: const TextStyle(
//                       fontSize: 25,
//                       fontWeight: FontWeight.w400,
//                     ),
//                   ),
//                 ),
//                 const Padding(
//                   padding: EdgeInsets.symmetric(vertical: 8.0),
//                   child: Text(
//                     "+91 9821 547 542",
//                     style: TextStyle(color: Colors.grey, fontSize: 18),
//                   ),
//                 ),
//                 Row(
//                   children: [
//                     Column(
//                       children: [
//                         IconButton(
//                           onPressed: () {},
//                           icon: const Icon(Icons.call),
//                           color: Theme.of(context).primaryColor,
//                         ),
//                         const Text(
//                           "Audio",
//                           style: TextStyle(
//                             fontSize: 18,
//                             fontWeight: FontWeight.w400,
//                           ),
//                         )
//                       ],
//                     )
//                   ],
//                 )
//               ],
//             )),
//           )
//         ],
//       ),
//     );
//   }
// }
