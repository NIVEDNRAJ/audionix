import 'package:audionix/common/helpers/is_dark_mode.dart';
import 'package:audionix/presentation/auth/bloc/theme_cubit.dart';
import 'package:audionix/presentation/auth/pages/signin.dart';
import 'package:audionix/presentation/auth/pages/signup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../common/widgets/appbar/app_bar.dart';
import '../../../common/widgets/button/basic_app_button.dart';
import '../../../core/configs/assets/app_images.dart';
import '../../../core/configs/assets/app_vectors.dart';

class SignupOrSigninPage extends StatelessWidget {
  const SignupOrSigninPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        // Background
        Positioned.fill(
          child: Image.asset(
            context.isDarkMode
                ? AppImages.dark_bg_auth
                : AppImages.white_bg_auth,
            fit: BoxFit.cover,
          ),
        ),

        // Overlay
        Container(
          color: Colors.black.withOpacity(0.3),
        ),

        SafeArea(
          child: SingleChildScrollView(
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Column(
                children: [
                  Positioned(
                    top: 50,
                    right: 20,
                    child: BlocBuilder<ThemeCubit, ThemeMode>(
                      builder: (context, themeMode) {
                        final isDark = themeMode == ThemeMode.dark;

                        return Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.4),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                isDark ? Icons.dark_mode : Icons.light_mode,
                                size: 18,
                                color: Colors.white,
                              ),
                              Switch(
                                value: isDark,
                                onChanged: (value) {
                                  context.read<ThemeCubit>().updateTheme(
                                        value
                                            ? ThemeMode.dark
                                            : ThemeMode.light,
                                      );
                                },
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  Expanded(
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        final height = constraints.maxHeight;
                        final width = constraints.maxWidth;

                        return Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: width * 0.1,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: height * 0.35,
                                child: SvgPicture.asset(
                                  context.isDarkMode
                                      ? AppVectors.logo_darktheme
                                      : AppVectors.logo_lighttheme,
                                  fit: BoxFit.contain,
                                ),
                              ),
                              SizedBox(height: height * 0.06),
                              const Text(
                                'Music unites. AUDIONIX amplifies.',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 15),
                              Text(
                                'Discover the soundtrack of your life. AUDIONIX.',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                  color: context.isDarkMode
                                      ? Color(0xffBCBCBC)
                                      : Color(0xff000000),
                                ),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(height: height * 0.05),
                              Row(
                                children: [
                                  Expanded(
                                    child: BasicAppButton(
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (_) => SignupPage(),
                                          ),
                                        );
                                      },
                                      title: 'Register',
                                    ),
                                  ),
                                  const SizedBox(width: 20),
                                  Expanded(
                                    child: TextButton(
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (_) => SigninPage(),
                                          ),
                                        );
                                      },
                                      child: Text(
                                        'Sign in',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                          color: context.isDarkMode
                                              ? Colors.white
                                              : Colors.black,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    ));
  }
}
