import 'package:evika/main.dart';
import 'package:evika/utils/bindings.dart';
import 'package:evika/views/create_post.dart';
import 'package:evika/views/description/description.dart';
import 'package:evika/views/profile.dart';
import 'package:evika/views/feed/feed.dart';
import 'package:evika/views/sign_up_from_view.dart';
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

  static final pages = [
    GetPage(name: AppRotutes.signin, page: () => SigninPage()),
    GetPage(
        name: AppRotutes.signup,
        page: () => SignUpFrom(),
        binding: SignupBindings()),
    // GetPage(name: AppRotutes.forgotPassword, page: () => ForgotPasswordPage()),
    GetPage(
      name: AppRotutes.screenNavigator,
      page: () => ScreenNavigate(),
      binding: FeedBinding(),
    ),
    GetPage(name: AppRotutes.profile, page: () => const ProfilePage()),
    GetPage(name: AppRotutes.tranding, page: () => const TrandingPage()),
    GetPage(name: AppRotutes.createPost, page: () => const CreatePostPage()),
    GetPage(
        name: AppRotutes.feed, page: () => FeedView(), binding: FeedBinding()),
    GetPage(name: AppRotutes.splashScreen, page: () => SplashScreen()),
    // GetPage(name: AppRotutes.postDescription, page: () => Description()),
  ];
}
