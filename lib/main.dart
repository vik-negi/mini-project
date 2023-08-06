import 'package:evika/appTheme.dart';
import 'package:evika/utils/constants.dart';
import 'package:evika/utils/routes.dart';
import 'package:evika/utils/widgets/login_first_dialogbox.dart';
import 'package:evika/view_models/navigation.dart/navigation_viewmodel.dart';
import 'package:evika/views/create_post/create_post.dart';
import 'package:evika/views/profile/profile.dart';
import 'package:evika/views/signin.dart';
import 'package:evika/views/trending_view/tranding.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:evika/views/feed/feed.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hexcolor/hexcolor.dart';

void main() async {
  await GetStorage.init();
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  // await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      // darkTheme: darkThemeData(context),
      theme: lightThemeData(context),
      scrollBehavior: const ScrollBehavior(
          androidOverscrollIndicator: AndroidOverscrollIndicator.stretch),
      // themeMode: ThemeMode.dark,
      // themeMode: ThemeMode.light,
      getPages: AppRotutes.pages,
      initialRoute: AppRotutes.splashScreen,
    );
  }
}

class ScreenNavigate extends StatelessWidget {
  ScreenNavigate({Key? key}) : super(key: key);
  NavigationController nv = Get.put(NavigationController());

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    List<Widget> screens = <Widget>[
      const FeedView(),
      WebFilterWidget(pageWidget: const TrandingPage()),
      WebFilterWidget(pageWidget: CreatePostPage()),
      WebFilterWidget(pageWidget: const ProfilePage()),
    ];
    return GetBuilder<NavigationController>(builder: (nv) {
      return Scaffold(
        body: screens.elementAt(nv.index.value),
        bottomNavigationBar: width > Constants.webWidth
            ? null
            : BottomNavigationBar(
                items: <BottomNavigationBarItem>[
                  navbarItem(icon: Icons.home, label: "Home"),
                  navbarItem(
                      icon: Icons.trending_up_outlined, label: "Trending"),
                  navbarItem(icon: Icons.add, label: "Post"),
                  navbarItem(icon: Icons.account_box, label: "Accounts"),
                ],
                currentIndex: nv.index.value,
                onTap: (int index) {
                  if (index == 2 || index == 3) {
                    if (!nv.isUserLoggedIn) {
                      loginFirstDialog(context);
                      return;
                    }
                  }
                  nv.changeIndex(index);
                  nv.update();
                },
                unselectedItemColor: const Color(0xffa1a1a1),
                selectedItemColor: const Color(0xff415859),
                showUnselectedLabels: true,
                selectedIconTheme: const IconThemeData(size: 30),
                unselectedIconTheme: const IconThemeData(size: 25),
                type: BottomNavigationBarType.fixed,
              ),
      );
    });
  }

  BottomNavigationBarItem navbarItem(
      {required IconData icon, required String label}) {
    return BottomNavigationBarItem(
      icon: Icon(icon),
      label: label,
    );
  }
}

class WebFilterWidget extends StatelessWidget {
  WebFilterWidget({super.key, required this.pageWidget});
  Widget pageWidget;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: width > Constants.webWidth
          ? AppBar(
              toolbarHeight: 0,
            )
          : AppBar(
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
      body: RefreshIndicator(
        onRefresh: () {
          return Future(() => null);
        },
        child: Container(
          width: width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              width < Constants.webWidth
                  ? const SizedBox()
                  : Row(
                      children: [
                        const WebSideBarWidget(),
                        Divider(
                          color: Colors.grey.shade800,
                          thickness: 5,
                        )
                      ],
                    ),
              Container(
                width: Get.width < Constants.webWidth
                    ? width
                    : width - Constants.sizeBarWidth,
                child: Center(
                  child: SizedBox(
                    width: Get.width < Constants.mwidth ? width : 560,
                    child: Center(
                      child: pageWidget,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
