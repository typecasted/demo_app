import 'package:demo_app/UI/Screens/home_screen.dart';

import 'package:demo_app/utils/constants.dart';
import 'package:demo_app/utils/size_config.dart';
import 'package:demo_app/utils/user_info.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  signUp({
    required String userName,
    required String email,
    required String password,
    required BuildContext context,
  }) async {

    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);



      // ...Saving user's information in device...
      UsersInfo().userInfo.write('username', userName);
      UsersInfo().userInfo.write('email', email);
      UsersInfo().userInfo.write('loggedIn', true);

      // ...Set navigation to other screen...
      Get.off(HomeScreen());
    } on FirebaseAuthException catch (e) {
      print(e.code);
      authExceptions(e: e, context: context);
    }
  }

  signIn({
    required String email,
    required String password,
    required BuildContext context,
  }) async {


    try {
      UserCredential credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      UsersInfo().userInfo.write('username', credential.user!.displayName);
      UsersInfo().userInfo.write('email', credential.user!.email);
      UsersInfo().userInfo.write('loggedIn', true);

      // ...Set navigation to other screen...
      Get.off(HomeScreen());

    } on FirebaseAuthException catch (e) {
      print(e.code);
      authExceptions(e: e, context: context);
    }
  }

  signInWithGoogle() async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    final GoogleSignInAccount? googleSignInAccount =
        await googleSignIn.signIn();

    User user;

    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      try {
        final UserCredential userCredential =
            await _auth.signInWithCredential(credential);

        user = userCredential.user!;

        print('${user.email} google sign in!!!');


        UsersInfo().userInfo.write('username', user.displayName);
        UsersInfo().userInfo.write('email', user.email);
        UsersInfo().userInfo.write('loggedIn', true);

        // ...Set navigation to other screen...
        Get.off(HomeScreen());
      } on FirebaseAuthException catch (e) {
        if (e.code == 'account-exists-with-different-credential') {
          // handle the error here
        } else if (e.code == 'invalid-credential') {
          // handle the error here
        }
      } catch (e) {
        // handle the error here
      }
    }
  }

  // ...Facebook login integration...

  faceBookLogin({required BuildContext context}) async {
    final LoginResult loginResult = await FacebookAuth.instance.login(
      permissions: ['public_profile', 'email'],
    );

    final userData = await FacebookAuth.instance.getUserData();

    print('!!!!${userData['name']}!!!!');

    switch (loginResult.status) {
      case LoginStatus.success:
        final AccessToken? accessToken = loginResult.accessToken;
        final AuthCredential credential =
            FacebookAuthProvider.credential(accessToken!.token);
        final UserCredential result =
            await _auth.signInWithCredential(credential);

        print(
            '${result.user!.displayName}, ${result.user!.email} is logged in');


        UsersInfo().userInfo.write('username', result.user!.displayName);
        UsersInfo().userInfo.write('email', result.user!.email);
        UsersInfo().userInfo.write('loggedIn', true);

        Get.off(HomeScreen());

        break;
      case LoginStatus.cancelled:
        break;
      case LoginStatus.failed:
        ScaffoldMessenger.of(context).showSnackBar(
          authErrorSnackBar(
            context: context,
            message: 'Login Cancelled',
          ),
        );
        break;
      case LoginStatus.operationInProgress:
        // TODO: Handle this case.
        break;
    }
  }
}

SnackBar authErrorSnackBar(
    {required BuildContext context, required String message}) {
  return SnackBar(
    content: Text(
      message,
      style: textStyle2,
    ),
    duration: Duration(milliseconds: 1500),
    width: SC().w(context) * 0.8,
    padding: EdgeInsets.symmetric(
      horizontal: SC().w(context) * 0.05,
    ),
    elevation: 0,
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.0),
    ),
  );
}

authExceptions(
    {required FirebaseAuthException e, required BuildContext context}) {
  switch (e.code) {
    case 'weak-password':
      print(e.code);
      ScaffoldMessenger.of(context).showSnackBar(
        authErrorSnackBar(
          context: context,
          message: 'Weak Password',
        ),
      );
      break;

    case 'wrong-password':
      ScaffoldMessenger.of(context).showSnackBar(
        authErrorSnackBar(
          context: context,
          message: 'Wrong Password!',
        ),
      );
      break;

    case 'invalid-email':
      ScaffoldMessenger.of(context).showSnackBar(
        authErrorSnackBar(
          context: context,
          message: 'Invalid Email',
        ),
      );
      break;

    case 'email-already-in-use':
      ScaffoldMessenger.of(context).showSnackBar(
        authErrorSnackBar(
          context: context,
          message: 'Email Already In Use',
        ),
      );
      break;

    case 'unknown':
      ScaffoldMessenger.of(context).showSnackBar(
        authErrorSnackBar(
          context: context,
          message: 'Input Field is Empty',
        ),
      );
      break;

    case 'user-not-found':
      ScaffoldMessenger.of(context).showSnackBar(
        authErrorSnackBar(
          context: context,
          message: 'User does not exist',
        ),
      );
      break;
  }
}
