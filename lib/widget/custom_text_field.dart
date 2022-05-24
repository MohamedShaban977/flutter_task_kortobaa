import 'package:flutter/material.dart';

import '../core/utils/colors.dart';

class CustomTextField extends StatelessWidget {
  final Function(String?)? onSaved, onChanged;
  final String? Function(String?)? validator;
  final Function()? onTap;

  final String? hint, label, initialValue;
  final bool obscureText, readOnly;
  final double? width;
  final int? maxLength, maxLines;

  final Widget? icon;

  final TextEditingController? controller;
  final TextInputAction textInputAction;
  final TextInputType keyboardType;

  const CustomTextField({
    Key? key,
    required this.onSaved,
    required this.validator,
    required this.label,
    this.hint,
    this.onChanged,
    this.controller,
    this.onTap,
    this.width,
    this.icon,
    this.maxLength,
    this.maxLines = 1,
    this.readOnly = false,
    this.obscureText = false,
    this.keyboardType = TextInputType.multiline,
    this.textInputAction = TextInputAction.next,
    this.initialValue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final heightSize = MediaQuery.of(context).size.height;

    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              label!,
              style: Theme.of(context)
                  .textTheme
                  .subtitle1!
                  .apply(color: Theme.of(context).focusColor),
            ),
          ),
          SizedBox(height: heightSize * 0.01),
          TextFormField(
            controller: controller,
            onTap: onTap,
            onChanged: onChanged,
            enabled: true,
            textInputAction: textInputAction,
            onSaved: onSaved,
            validator: validator,
            maxLength: maxLength,
            minLines: maxLines,
            keyboardType: keyboardType,
            maxLines: maxLines,
            obscureText: obscureText,
            cursorColor: MyColors.colorPrimary,
            readOnly: readOnly,
            style: Theme.of(context)
                .textTheme
                .subtitle1!
                .copyWith(color: MyColors.colorPrimary),
            initialValue: initialValue,
            cursorHeight: 25.0,
            decoration: InputDecoration(
              fillColor: MyColors.colorBackgroundTextField,
              //Theme.of(context).canvasColor,
              filled: true,
              hintText: hint,
              suffixIcon: icon,

              hintStyle: Theme.of(context).textTheme.caption,

              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.transparent),
                borderRadius: BorderRadius.circular(10),
              ),

              ///
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.transparent),
                borderRadius: BorderRadius.circular(10),
              ),

              ///
              disabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.transparent),
                borderRadius: BorderRadius.circular(10),
              ),

              ///

              ///error border
              border: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.transparent),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
