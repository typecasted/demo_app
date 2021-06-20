import 'package:demo_app/UI/Components/sign_in_up_screen_components/other_components.dart';
import 'package:demo_app/UI/Components/sign_in_up_screen_components/text_field.dart';
import 'package:demo_app/UI/Screens/signin_screen.dart';
import 'package:demo_app/utils/auth_services.dart';
import 'package:demo_app/utils/constants.dart';
import 'package:demo_app/utils/size_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpScreen extends StatefulWidget {
  SignUpScreen({
    key,
  }) : super(
          key: key,
        );

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();

    userNameController.dispose();
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
            hint: 'Username',
            icon: Icons.account_circle_outlined,
            textInputType: TextInputType.name,
            controller: userNameController,
            isPass: false,
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

              AuthService().signUp(
                email: emailController.text.trimRight(),
                userName: userNameController.text.trimRight(),
                password: passwordController.text.trimRight(),
                context: context
              );

              emailController.clear();
              userNameController.clear();
              passwordController.clear();
            },
            child: SignInUpButton(
              message: 'Sign up',
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
                  onTap: () => AuthService().faceBookLogin(context: context),
                  child: SignInUpWithButton(
                    image: 'images/Facebook_logo.png',
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: SC().h(context) * 0.02,
          ),
          GestureDetector(
            onTap: () {
              Get.off(SignInScreen());
            },
            child: Text(
              'Already Have Account',
              style: textStyle1.copyWith(fontSize: SC().h(context) * 0.02),
            ),
          )
        ],
      ),
    );
  }
}
