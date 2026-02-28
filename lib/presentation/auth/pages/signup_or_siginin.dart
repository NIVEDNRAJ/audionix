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
          /// 🌄 Background Image
          Positioned.fill(
            child: Image.asset(
              context.isDarkMode
                  ? AppImages.dark_bg_auth
                  : AppImages.white_bg_auth,
              fit: BoxFit.cover,
            ),
          ),

          /// 🌈 Gradient Overlay (Better than plain black)
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.black.withOpacity(0.7),
                    Colors.transparent,
                    Colors.black.withOpacity(0.8),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
          ),

          /// 🌙 Theme Toggle (Properly Positioned)
          Positioned(
            top: 50,
            right: 20,
            child: BlocBuilder<ThemeCubit, ThemeMode>(
              builder: (context, themeMode) {
                final isDark = themeMode == ThemeMode.dark;

                return Container(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
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
                        activeColor: Colors.pink,
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

          /// 📱 Main Content
          SafeArea(
            child: LayoutBuilder(
              builder: (context, constraints) {
                final height = constraints.maxHeight;
                final width = constraints.maxWidth;

                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: width * 0.1),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      /// 🎧 Logo
                      SizedBox(
                        height: height * 0.3,
                        child: SvgPicture.asset(
                          context.isDarkMode
                              ? AppVectors.logo_darktheme
                              : AppVectors.logo_lighttheme,
                        ),
                      ),

                      SizedBox(height: height * 0.05),

                      /// 🧠 Main Heading
                      const Text(
                        'Music unites.\nAUDIONIX amplifies.',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                          height: 1.4,
                        ),
                        textAlign: TextAlign.center,
                      ),

                      const SizedBox(height: 12),

                      /// ✍️ Subtitle
                      Text(
                        'Discover the soundtrack of your life.',
                        style: TextStyle(
                          fontSize: 14,
                          color: context.isDarkMode
                              ? Colors.white70
                              : Colors.black87,
                        ),
                        textAlign: TextAlign.center,
                      ),

                      SizedBox(height: height * 0.08),

                      /// 🚀 Buttons
                      Column(
                        children: [
                          /// Register Button (Primary)
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                padding:
                                const EdgeInsets.symmetric(vertical: 16),
                                backgroundColor: Colors.pink,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                elevation: 5,
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => SignupPage(),
                                  ),
                                );
                              },
                              child: Text(
                                'Register',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: context.isDarkMode
                                      ? Colors.white
                                      : Colors.black,
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(height: 15),

                          /// Sign In Button (Glass Effect)
                          SizedBox(
                            width: double.infinity,
                            child: OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                padding:
                                const EdgeInsets.symmetric(vertical: 16),
                                side: BorderSide(
                                  color: Colors.white.withOpacity(0.6),
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => SigninPage(),
                                  ),
                                );
                              },
                              child: Text(
                                'Sign In',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
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
    );
  }
}