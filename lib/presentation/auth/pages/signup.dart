import 'package:audionix/common/helpers/is_dark_mode.dart';
import 'package:audionix/presentation/auth/pages/signin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../common/widgets/button/basic_app_button.dart';
import '../../../core/configs/assets/app_vectors.dart';
import '../../../data/models/auth/create_user_req.dart';
import '../../../domain/usecases/auth/signup.dart';
import '../../../service_locator.dart';
import '../../home/pages/home.dart';

class SignupPage extends StatelessWidget {
  SignupPage({super.key});

  final TextEditingController _fullName = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  final ValueNotifier<bool> _obscurePassword = ValueNotifier(true);

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;

    return Scaffold(
      body: Stack(
        children: [
          /// 🌄 Background Gradient
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: isDark
                    ? [Colors.black, Colors.grey.shade900]
                    : [Colors.white, Colors.grey.shade300],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),

          /// 📱 Content
          SafeArea(
            child: Column(
              children: [
                /// 🔝 AppBar Logo
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: SvgPicture.asset(
                    isDark
                        ? AppVectors.logo_darktheme
                        : AppVectors.logo_lighttheme,
                    height: 60,
                  ),
                ),

                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 25, vertical: 10),
                    child: Column(
                      children: [
                        /// 🧠 Title
                        const Text(
                          "Create Account",
                          style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 10),

                        Text(
                          "Start your music journey 🎧",
                          style: TextStyle(
                            fontSize: 14,
                            color: isDark
                                ? Colors.white70
                                : Colors.black54,
                          ),
                        ),

                        const SizedBox(height: 30),

                        /// 🧊 Form Card (Glass feel)
                        Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: isDark
                                ? Colors.white.withOpacity(0.05)
                                : Colors.white.withOpacity(0.7),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            children: [
                              _buildField(
                                controller: _fullName,
                                hint: "Full Name",
                                icon: Icons.person,
                              ),
                              const SizedBox(height: 15),
                              _buildField(
                                controller: _email,
                                hint: "Email",
                                icon: Icons.email,
                              ),
                              const SizedBox(height: 15),

                              /// 🔒 Password Field
                              ValueListenableBuilder(
                                valueListenable: _obscurePassword,
                                builder: (context, value, _) {
                                  return _buildField(
                                    controller: _password,
                                    hint: "Password",
                                    icon: Icons.lock,
                                    obscure: value,
                                    suffix: IconButton(
                                      icon: Icon(
                                        value
                                            ? Icons.visibility_off
                                            : Icons.visibility,
                                      ),
                                      onPressed: () =>
                                      _obscurePassword.value = !value,
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 30),

                        /// 🚀 CTA Button
                        BasicAppButton(
                            onPressed: () async {
                              var result =
                              await sl<SignupUseCase>().call(
                                params: CreateUserReq(
                                  fullName: _fullName.text,
                                  email: _email.text,
                                  password: _password.text,
                                ),
                              );

                              result.fold(
                                    (l) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(l),
                                      behavior:
                                      SnackBarBehavior.floating,
                                    ),
                                  );
                                },
                                    (r) {
                                  Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) =>
                                        const HomePage()),
                                        (route) => false,
                                  );
                                },
                              );
                            },
                            title: 'Create Account'),

                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),

                /// 🔁 Bottom Sign In
                Padding(
                  padding: const EdgeInsets.only(bottom: 25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Already have an account? "),
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (_) => SigninPage()),
                          );
                        },
                        child: const Text(
                          "Sign In",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// ✨ Reusable Modern Input Field
  Widget _buildField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    bool obscure = false,
    Widget? suffix,
  }) {
    return TextField(
      controller: controller,
      obscureText: obscure,
      decoration: InputDecoration(
        hintText: hint,
        prefixIcon: Icon(icon),
        suffixIcon: suffix,
        contentPadding: EdgeInsets.symmetric(
          vertical: 18
        ),
        filled: true,
        fillColor: Colors.grey.withOpacity(0.15),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}