import 'package:demo_app/Controller/data_controller.dart';
import 'package:demo_app/UI/Components/home_screen_components/data_tile.dart';
import 'package:demo_app/UI/Screens/signin_screen.dart';
import 'package:demo_app/utils/constants.dart';
import 'package:demo_app/utils/size_config.dart';
import 'package:demo_app/utils/user_info.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  final _dataController = Get.put(DataController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                  vertical: SC().h(context) * 0.02,
                  horizontal: SC().w(context) * 0.05),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Data List',
                    style:
                        headerStyle.copyWith(fontSize: SC().h(context) * 0.05),
                  ),
                  GestureDetector(
                    onTap: () async {
                      UsersInfo().userInfo.write('loggedIn', false);
                      FacebookAuth.instance.logOut();
                      bool isSignedInGoogle = await GoogleSignIn().isSignedIn();
                      if (isSignedInGoogle) {
                        GoogleSignIn().signOut();
                      }
                      Get.off(SignInScreen());
                    },
                    child: Icon(
                      Icons.logout_rounded,
                      size: SC().h(context) * 0.05,
                      color: Color(0xFF20375A),
                    ),
                  )
                ],
              ),
            ),
            Divider(
              color: Color(0xFF20375A),
            ),
            Obx(() {
              if (_dataController.isLoading.value) {
                return Expanded(
                    child: Center(child: CircularProgressIndicator()));
              } else {
                return DataTile(dataController: _dataController);
              }
            }),
          ],
        ),
      ),
    );
  }
}

