import 'package:evika/models/user/user_model.dart';
// import 'package:evika/utils/sharedPreferenced.dart';
// import 'package:evika/utils/sharedPreferenced.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:share_plus/share_plus.dart';

class ProfileVM extends GetxController {
  logout() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.clear();
  }

  var userData = UserData(
      name: "Yashwant Sahu",
      email: "mlp.yashvantgupta@gmail.com",
      username: "@yash5626",
      password: "somepassword",
      id: "21",
      bio: "I am a Flutter Developer",
      profileImage:
          "https://images.unsplash.com/photo-1511367461989-f85a21fda167?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8cHJvZmlsZXxlbnwwfHwwfHw%3D&w=1000&q=80",
      isBlocked: false,
      isEmailVerified: true,
      isMobileVerified: true,
      mobile: "6306406076",
      gender: "male",
      location: [],
      follower: [
        1,
        1,
        1,
        1,
        1,
        1,
        1,
        1,
        1,
        1,
        1,
        1,
        1,
        1,
        1,
        1,
        1,
        1,
        1,
        1,
        1,
      ],
      following: [
        1,
        1,
        1,
        1,
        1,
        1,
        1,
        1,
        1,
        1,
        1,
        1,
        1,
        1,
        1,
        1,
        1,
        1,
        1,
        1,
        1,
        1,
        1,
        1,
        1,
        1,
        1,
        1,
        1,
        1,
        1,
        1,
      ],
      profileViews: 10232);
}
