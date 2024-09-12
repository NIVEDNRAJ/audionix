import 'package:audionix/common/helpers/is_dark_mode.dart';
import 'package:audionix/presentation/auth/pages/signin.dart';
import 'package:audionix/presentation/auth/pages/signup.dart';
import 'package:flutter/material.dart';
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
          // Background image
          Positioned.fill(
            child: Image.asset(
              context.isDarkMode
                  ? AppImages.dark_bg_auth
                  : AppImages.white_bg_auth, // Replace with your background image path
              fit: BoxFit.cover, // Ensures the image covers the entire screen
            ),
          ),

          // Optional overlay if you want to add a tint over the background
          Container(
            color: Colors.black.withOpacity(0.3), // Adjust opacity as needed
          ),

          // Content on top of the background
          const BasicAppbar(),

          Align(
            alignment: Alignment.center,
            child: LayoutBuilder(
              builder: (context, constraints) {
                return Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: constraints.maxWidth * 0.1,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: constraints.maxHeight * 0.4,
                        child: FittedBox(
                          fit: BoxFit.contain,
                          child: SvgPicture.asset(
                            context.isDarkMode
                                ? AppVectors.logo_darktheme
                                : AppVectors.logo_lighttheme,
                          ),
                        ),
                      ),
                      const SizedBox(height: 55),
                      const Text(
                        'Music unites. AUDIONIX amplifies.',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 21),
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
                      const SizedBox(height: 30),
                      Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: BasicAppButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (BuildContext context) => SignupPage(),
                                  ),
                                );
                              },
                              title: 'Register',
                            ),
                          ),
                          const SizedBox(width: 20),
                          Expanded(
                            flex: 1,
                            child: TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (BuildContext context) => SigninPage(),
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
    );
  }
}
