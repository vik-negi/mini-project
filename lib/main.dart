import 'package:evika/utils/routes.dart';
import 'package:evika/view_models/navigation.dart/navigation_viewmodel.dart';
import 'package:evika/views/create_post.dart';
import 'package:evika/views/profile.dart';
import 'package:evika/views/signin.dart';
import 'package:evika/views/splash_screen.dart';
import 'package:evika/views/trending_view/tranding.dart';
import 'package:flutter/material.dart';
import 'package:evika/views/feed.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      getPages: AppRotutes.pages,
      // home: SplashScreen(),
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
      FeedView(),
      const TrandingPage(),
      const CreatePostPage(),
      true ? ProfilePage() : SigninPage(),
    ];
    return GetBuilder<NavigationController>(builder: (nv) {
      return Scaffold(
        body: screens.elementAt(nv.index.value),
        bottomNavigationBar: BottomNavigationBar(
          items: <BottomNavigationBarItem>[
            navbarItem(icon: Icons.home, label: "Home"),
            navbarItem(icon: Icons.trending_up_outlined, label: "Tranding"),
            navbarItem(icon: Icons.add, label: "Post"),
            navbarItem(icon: Icons.account_box, label: "Accounts"),
          ],
          currentIndex: nv.index.value,
          onTap: (int index) {
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
