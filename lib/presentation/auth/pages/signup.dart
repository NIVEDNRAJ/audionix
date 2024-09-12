import 'package:audionix/common/helpers/is_dark_mode.dart';
import 'package:audionix/presentation/auth/pages/signin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../common/widgets/appbar/app_bar.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.isDarkMode? Color(0xff000000):Color(0xffBCBCBC),
      bottomNavigationBar: _siginText(context),
      appBar: BasicAppbar(
        title: SvgPicture.asset(
          context.isDarkMode ? AppVectors.logo_darktheme : AppVectors.logo_lighttheme,
          height: 110,
          width: 40,
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
            vertical: 50,
            horizontal: 30
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _registerText(),
            const SizedBox(height: 50,),
            _fullNameField(context),
            const SizedBox(height: 20,),
            _emailField(context),
            const SizedBox(height: 20,),
            _passwordField(context),
            const SizedBox(height: 20,),
            BasicAppButton(
                onPressed: () async {
                  var result = await sl<SignupUseCase>().call(
                      params: CreateUserReq(
                          fullName: _fullName.text.toString(),
                          email: _email.text.toString(),
                          password: _password.text.toString()
                      )
                  );
                  result.fold(
                          (l){
                        var snackbar = SnackBar(content: Text(l),behavior: SnackBarBehavior.floating,);
                        ScaffoldMessenger.of(context).showSnackBar(snackbar);
                      },
                          (r){
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (BuildContext context) => const HomePage()),
                                (route) => false
                        );
                      }
                  );
                },
                title: 'Create Account'
            )

          ],
        ),
      ),
    );
  }

  Widget _registerText() {
    return const Text(
      'Register',
      style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 25
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget _fullNameField(BuildContext context) {
    return TextField(
      controller: _fullName,
      decoration: const InputDecoration(
          hintText: 'Full Name'
      ).applyDefaults(
          Theme.of(context).inputDecorationTheme
      ),
    );
  }

  Widget _emailField(BuildContext context) {
    return TextField(
      controller: _email,
      decoration: const InputDecoration(
          hintText: 'Enter Email'
      ).applyDefaults(
          Theme.of(context).inputDecorationTheme
      ),
    );
  }

  Widget _passwordField(BuildContext context) {
    return TextField(
      controller: _password,
      decoration: const InputDecoration(
          hintText: 'Password'
      ).applyDefaults(
          Theme.of(context).inputDecorationTheme
      ),
    );
  }

  Widget _siginText(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          vertical: 30
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Do you have an account? ',
            style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 14
            ),
          ),
          TextButton(
              onPressed: (){
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => SigninPage()
                    )
                );
              },
              child: const Text(
                  'Sign In'
              )
          )
        ],
      ),
    );
  }
}