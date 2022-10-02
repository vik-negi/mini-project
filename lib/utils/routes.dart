import 'package:evika/main.dart';
import 'package:evika/view_models/signup_form_vm.dart';
import 'package:evika/views/create_post.dart';
import 'package:evika/views/profile.dart';
import 'package:evika/views/sample_post.dart';
import 'package:evika/views/sign_up_from_view.dart';
import 'package:evika/views/signin.dart';
import 'package:evika/views/tranding.dart';
import 'package:get/get.dart';

class AppRotutes {
  static const home = '/';
  static const signin = '/signin';
  static const signup = '/signup';
  // static const forgotPassword = '/forgotPassword';
  static const screenNavigator = '/ScreenNavigator';
  static const profile = '/profile';
  static const tranding = '/tranding';
  static const createPost = '/createPost';

  static final pages = [
    GetPage(name: AppRotutes.signin, page: () => SigninPage()),
    GetPage(name: AppRotutes.signup, page: () => SignUpFrom()),
    // GetPage(name: AppRotutes.forgotPassword, page: () => ForgotPasswordPage()),
    GetPage(name: AppRotutes.screenNavigator, page: () => ScreenNavigate()),
    GetPage(name: AppRotutes.profile, page: () => const ProfilePage()),
    GetPage(name: AppRotutes.tranding, page: () => const TrandingPage()),
    GetPage(name: AppRotutes.createPost, page: () => const CreatePostPage()),
    GetPage(name: AppRotutes.home, page: () => SamplePost()),
  ];
}
