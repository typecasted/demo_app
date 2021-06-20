import 'package:demo_app/UI/Components/sign_in_up_screen_components/other_components.dart';
import 'package:demo_app/UI/Components/sign_in_up_screen_components/text_field.dart';
import 'package:demo_app/UI/Screens/signup_screen.dart';
import 'package:demo_app/utils/auth_services.dart';
import 'package:demo_app/utils/constants.dart';
import 'package:demo_app/utils/size_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignInScreen extends StatefulWidget {
  SignInScreen({
    key,
  }) : super(
          key: key,
        );

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();

    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Demo App',
            style: headerStyle.copyWith(
              fontSize: SC().h(context) * 0.04,
            ),
          ),
          SizedBox(
            height: SC().h(context) * 0.02,
          ),
          TextFieldLoginScreen(
            hint: 'Email',
            icon: Icons.alternate_email,
            textInputType: TextInputType.emailAddress,
            controller: emailController,
            isPass: false,
          ),
          TextFieldLoginScreen(
            textInputType: TextInputType.text,
            hint: 'Password',
            icon: Icons.password,
            controller: passwordController,
            isPass: true,
          ),
          GestureDetector(
            onTap: () {
              AuthService().signIn(
                context: context,
                email: emailController.text.trimRight(),
                password: passwordController.text.trimRight(),
              );
              emailController.clear();
              passwordController.clear();
            },
            child: SignInUpButton(
              message: 'Sign in',
            ),
          ),
          SizedBox(
            height: SC().h(context) * 0.02,
          ),
          Container(
            width: SC().w(context) * 0.7,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () => AuthService().signInWithGoogle(),
                  child: SignInUpWithButton(
                    image: 'images/google_logo.png',
                  ),
                ),
                SizedBox(
                  width: SC().w(context) * 0.05,
                ),
                GestureDetector(
                  onTap: () {
                    CircularProgressIndicator();
                    AuthService().faceBookLogin(context: context);
                  },
                  child: SignInUpWithButton(
                    image: 'images/Facebook_logo.png',
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: SC().h(context) * 0.02,
          ),
          GestureDetector(
            onTap: () {
              Get.off(SignUpScreen());
            },
            child: Text(
              'Create Account',
              style: textStyle1.copyWith(fontSize: SC().h(context) * 0.02),
            ),
          )
        ],
      ),
    );
  }
}
