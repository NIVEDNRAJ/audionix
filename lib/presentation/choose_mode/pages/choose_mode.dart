// import 'dart:ui';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import '../../../common/widgets/button/basic_app_button.dart';
// import '../../../core/configs/assets/app_images.dart';
// import '../../../core/configs/assets/app_vectors.dart';
// import '../../../core/configs/theme/app_colors.dart';
// import '../../auth/pages/signup_or_siginin.dart';
// import '../../auth/bloc/theme_cubit.dart';

// class ChooseModePage extends StatelessWidget {
//   const ChooseModePage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.lightBackground,
//       body: Stack(
//         children: [
//           Container(
//             padding: EdgeInsets.symmetric(
//               vertical: MediaQuery.of(context).size.height * 0.05,
//               horizontal: MediaQuery.of(context).size.width * 0.1,
//             ),
//             decoration: const BoxDecoration(
//               image: DecorationImage(
//                 fit: BoxFit.fill,
//                 image: AssetImage(AppImages.introBG),
//               ),
//             ),
//           ),
//           Container(
//             color: Colors.black.withOpacity(0.15),
//           ),
//           Padding(
//             padding: EdgeInsets.symmetric(
//               vertical: MediaQuery.of(context).size.height * 0.05,
//               horizontal: MediaQuery.of(context).size.width * 0.1,
//             ),
//             child: Column(
//               children: [
//                 Align(
//                   alignment: Alignment.topCenter,
//                   child: SizedBox(
//                     height: MediaQuery.of(context).size.height * 0.5,
//                     child: FittedBox(
//                       fit: BoxFit.contain,
//                       child: SvgPicture.asset(
//                         AppVectors.logo_darktheme,
//                       ),
//                     ),
//                   ),
//                 ),
//                 const Spacer(),
//                 const Text(
//                   'Choose Mode',
//                   style: TextStyle(
//                     fontWeight: FontWeight.bold,
//                     color: Colors.white,
//                     fontSize: 18,
//                   ),
//                 ),
//                 const SizedBox(height: 40),
//                 BlocBuilder<ThemeCubit, ThemeMode>(
//                   builder: (context, themeMode) {
//                     final isDark = themeMode == ThemeMode.dark;

//                     return Column(
//                       children: [
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             const Icon(Icons.dark_mode, color: Colors.white),
//                             const SizedBox(width: 10),
//                             Switch(
//                               value: isDark,
//                               activeColor: Colors.white,
//                               inactiveThumbColor: Colors.black,
//                               onChanged: (value) {
//                                 context.read<ThemeCubit>().updateTheme(
//                                       value ? ThemeMode.dark : ThemeMode.light,
//                                     );
//                               },
//                             ),
//                             const SizedBox(width: 10),
//                             const Icon(Icons.light_mode, color: Colors.white),
//                           ],
//                         ),
//                         const SizedBox(height: 10),
//                         Text(
//                           isDark ? "Dark Mode" : "Light Mode",
//                           style: const TextStyle(
//                             color: Colors.white,
//                             fontWeight: FontWeight.w500,
//                             fontSize: 16,
//                           ),
//                         ),
//                       ],
//                     );
//                   },
//                 ),
//                 const SizedBox(height: 10),
//                 BasicAppButton(
//                   onPressed: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (BuildContext context) =>
//                             const SignupOrSigninPage(),
//                       ),
//                     );
//                   },
//                   title: 'Continue',
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
