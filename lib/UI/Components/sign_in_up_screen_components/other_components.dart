import 'package:demo_app/utils/constants.dart';
import 'package:demo_app/utils/size_config.dart';
import 'package:flutter/cupertino.dart';

class SignInUpButton extends StatelessWidget {
  const SignInUpButton({
    required this.message,
  }) : super();

  final String message;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: SC().h(context) * 0.025,
      ),
      child: Container(
          height: SC().h(context) * 0.075,
          width: SC().w(context) * 0.65,
          decoration: BoxDecoration(
            color: Color(0xFF20375A),
            borderRadius: BorderRadius.circular(50),
          ),
          alignment: Alignment.center,
          child: Text(
            message,
            style: textStyle2.copyWith(fontSize: SC().h(context) * 0.025),
          )),
    );
  }
}

class SignInUpWithButton extends StatelessWidget {
  const SignInUpWithButton({
    required this.image,
  }) : super();

  final String image;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: SC().h(context) * 0.065,
      width: SC().w(context) * 0.2,
      decoration: BoxDecoration(
        // color: Color(0xFF375893),
        // borderRadius: BorderRadius.circular(50),
      ),
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(
          vertical: SC().h(context) * 0.01, horizontal: SC().w(context) * 0.05),
      child: Container(
        height: SC().h(context) * 0.04,
        width: SC().h(context) * 0.04,
        child: Image.asset(image, fit: BoxFit.cover,),
      ),
    );
  }
}
