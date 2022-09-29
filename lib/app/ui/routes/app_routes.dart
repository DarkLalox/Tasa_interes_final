import 'package:flutter/widgets.dart';
import 'package:tesis_1/app/ui/pages/home/home_page.dart';
import 'package:tesis_1/app/ui/pages/home/tabs/home/graphic/graphic_TPM.dart';
import 'package:tesis_1/app/ui/pages/home/tabs/home/graphic_page.dart';
import 'package:tesis_1/app/ui/pages/home/tabs/home/interest_rate_page.dart';
import 'package:tesis_1/app/ui/pages/home/tabs/home/language_page.dart';
import 'package:tesis_1/app/ui/pages/home/tabs/home/news/news_page.dart';
import 'package:tesis_1/app/ui/pages/login/login_page.dart';
import 'package:tesis_1/app/ui/pages/register/register_page.dart';
import 'package:tesis_1/app/ui/pages/reset_password/reset_password_page.dart';
import 'package:tesis_1/app/ui/pages/splash/splash_page.dart';
import 'routes.dart';

Map<String, Widget Function(BuildContext)> get appRoutes => {
      Routes.SPLASH: (_) => const SplashPage(),
      Routes.LOGIN: (_) => const LoginPage(),
      Routes.HOME: (_) => const HomePage(),
      Routes.REGISTER: (_) => const RegisterPage(),
      Routes.RESET_PASSWORD: (_) => const ResetPasswordPage(),
      Routes.INTEREST_RATE: (_) => const InterestRate(),
      Routes.NEWS: (_) => const News(),
      Routes.GRAPHIC: (_) => const Graphic(),
      Routes.IDIOMA: (_) => const Idioma(),
      Routes.TPM: (_) => const Graphic_TPM(),
    };
