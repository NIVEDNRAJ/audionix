import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../common/widgets/button/basic_app_button.dart';
import '../../../core/configs/assets/app_images.dart';
import '../../../core/configs/assets/app_vectors.dart';
import '../../../core/configs/theme/app_colors.dart';
import '../../choose_mode/pages/choose_mode.dart';

class GetStartedPage extends StatelessWidget {
  const GetStartedPage({super.key});

  @override
Widget build(BuildContext context) {
  final size = MediaQuery.of(context).size;

  return Scaffold(
    body: Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage(AppImages.introBG),
            ),
          ),
        ),

        Container(
          color: Colors.black.withOpacity(0.15),
        ),

        SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 40,
              vertical: 20,
            ),
            child: SingleChildScrollView(
              child: SizedBox(
                height: size.height * 0.85,
                child: Column(
                  children: [
                    SizedBox(
                      height: size.height * 0.35,
                      child: SvgPicture.asset(
                        AppVectors.logo_darktheme,
                        fit: BoxFit.contain,
                      ),
                    ),

                    const Spacer(),

                    const Text(
                      'Enjoy Listening To Music',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 18,
                      ),
                      textAlign: TextAlign.center,
                    ),

                    const SizedBox(height: 20),

                    const Text(
                      'Let music move you, inspire you, and connect you. With AUDIONIX, experience the world through sound.',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: AppColors.grey,
                        fontSize: 13,
                      ),
                      textAlign: TextAlign.center,
                    ),

                    const SizedBox(height: 25),

                    BasicAppButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const ChooseModePage(),
                          ),
                        );
                      },
                      title: 'Get Started',
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}}