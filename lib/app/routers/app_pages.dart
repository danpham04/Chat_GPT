import 'package:chat_gpt/app/routers/app_routes.dart';
import 'package:chat_gpt/presentation/controller/auth/auth_binding.dart';
import 'package:chat_gpt/presentation/page/auth/login_page.dart';
import 'package:chat_gpt/presentation/page/auth/signup_page.dart';
import 'package:chat_gpt/presentation/page/home_page/home_screen.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

class AppPage {
  static final pages = [

    //  GetPage(
    //   name: AppRoutes.root,
    //   middlewares: [
    //     RedirectMiddleware(),
    //   ],
    //   page: () => Container(),
    // ),

    // Auth
    GetPage(
      name: AppRoutes.loginPage,
      page: () => const LoginPage(),
      binding: AuthBinding(),
      
    ),
    GetPage(
      name: AppRoutes.homescreen,
      page: () => const HomeScreen(),
      
    ),

    //Page
    GetPage(
      name: AppRoutes.signUp,
      page: () => const SignupPage(),
      binding: AuthBinding(),
    )
  ];
  
  

}
