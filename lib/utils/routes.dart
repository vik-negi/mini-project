import 'package:evika/auth/signup.dart';
import 'package:evika/main.dart';
import 'package:evika/utils/bindings.dart';
import 'package:evika/views/create_post/create_post.dart';
import 'package:evika/views/description/description.dart';
import 'package:evika/views/mypost/my_post_details.dart';
import 'package:evika/views/profile/profile.dart';
import 'package:evika/views/feed/feed.dart';
import 'package:evika/views/signin.dart';
import 'package:evika/views/splash_screen.dart';
import 'package:evika/views/trending_view/tranding.dart';
import 'package:get/get.dart';

class AppRotutes {
  static const feed = '/';
  static const signin = '/signin';
  static const signup = '/signup';
  // static const forgotPassword = '/forgotPassword';
  static const screenNavigator = '/ScreenNavigator';
  static const profile = '/profile';
  static const tranding = '/tranding';
  static const createPost = '/createPost';
  static const splashScreen = '/splashScreen';
  static const postDescription = '/postDescription';
  static const myPostDetails = '/myPostDetails';

  static final pages = [
    GetPage(
      name: AppRotutes.postDescription,
      page: () => const Description(),
      binding: DescriptionBinding(),
    ),
    GetPage(
      name: AppRotutes.myPostDetails,
      page: () => const MyPostDetails(),
      binding: MyPostDetailsBinding(),
    ),
    GetPage(
      name: AppRotutes.signin,
      page: () => const SigninPage(),
      binding: SigninBindings(),
    ),

    GetPage(
      name: AppRotutes.signup,
      page: () => const RegisterPage(),
    ),
    GetPage(
      name: AppRotutes.screenNavigator,
      page: () => ScreenNavigate(),
      binding: FeedBinding(),
    ),
    GetPage(name: AppRotutes.tranding, page: () => const TrandingPage()),
    GetPage(
      name: AppRotutes.createPost,
      page: () => CreatePostPage(),
      binding: CreatePostBinding(),
    ),
    GetPage(
      name: AppRotutes.profile,
      page: () => const ProfilePage(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: AppRotutes.feed,
      page: () => const FeedView(),
      binding: FeedBinding(),
    ),
    GetPage(
      name: AppRotutes.splashScreen,
      page: () => const SplashScreen(),
    ),
    // GetPage(name: AppRotutes.postDescription, page: () => Description()),
  ];
}
