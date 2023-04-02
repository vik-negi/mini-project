import 'package:evika/appTheme.dart';
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

void main() async {
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
    List<Widget> screens = <Widget>[
      const FeedView(),
      const TrandingPage(),
      CreatePostPage(),
      const ProfilePage(),
    ];
    return GetBuilder<NavigationController>(builder: (nv) {
      return Scaffold(
        body: screens.elementAt(nv.index.value),
        bottomNavigationBar: BottomNavigationBar(
          items: <BottomNavigationBarItem>[
            navbarItem(icon: Icons.home, label: "Home"),
            navbarItem(icon: Icons.trending_up_outlined, label: "Trending"),
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
