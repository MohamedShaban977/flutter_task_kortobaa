import 'package:argon_buttons_flutter/argon_buttons_flutter.dart';
import 'package:flutter/material.dart';

import '../core/utils/colors.dart';

class CustomButtonArgonAnimation extends StatelessWidget {
  const CustomButtonArgonAnimation(
      {Key? key,
      this.height = 50.0,
      required this.width,
      required this.text,
      required this.onTap,
      this.color,
      this.textColors})
      : super(key: key);

  final double height, width;
  final String text;
  final Function(Function, Function, ButtonState)? onTap;
  final Color? color, textColors;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: ArgonButton(
        height: height,
        roundLoadingShape: true,
        width: width,
        onTap: onTap,
        loader: Padding(
          padding: const EdgeInsets.all(2),
          child: Container(
            decoration: BoxDecoration(
                color: color, borderRadius: BorderRadius.circular(height)),
            child: const CircularProgressIndicator(
              color: Colors.white,
            ),
            // Lottie.asset(
            //     'assets/images/loader.json',
            //     fit: BoxFit.cover,
            //   ),
          ),
        ),
        borderRadius: 8.0,
        color: color,
        child: Text(text,
            style: Theme.of(context)
                .textTheme
                .button!
                .apply(color: textColors ?? MyColors.colorWhite)),
      ),
    );
  }
}

class CustomOutlinedButton extends StatelessWidget {
  final double? height, width;
  final String text;
  final Function()? onPressed;
  final IconData? iconData;
  final Color? colorText, colorIcon;

  const CustomOutlinedButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.height = 50,
    this.width,
    this.colorText,
    this.colorIcon,
    this.iconData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: SizedBox(
        height: height, //height,
        width: width,
        child: OutlinedButton.icon(
          style: OutlinedButton.styleFrom(
            side: const BorderSide(color: MyColors.colorOrangeSecond),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            textStyle:
                Theme.of(context).textTheme.button!.apply(color: colorText),
          ),
          onPressed: onPressed,
          icon: Icon(
            iconData,
            color: colorIcon ?? colorText,
          ),
          label: Text(text,
              style:
                  Theme.of(context).textTheme.button!.apply(color: colorText)),
        ),
      ),
    );
  }
}

class CustomTextButton extends StatelessWidget {
  const CustomTextButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.color,
  }) : super(key: key);

  final Function()? onPressed;
  final String text;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: ButtonStyle(
        padding: MaterialStateProperty.all(const EdgeInsets.all(15.0)),
      ),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: Theme.of(context)
            .textTheme
            .bodyText1!
            .apply(color: color ?? MyColors.colorPrimary),
      ),
    );
  }
}
