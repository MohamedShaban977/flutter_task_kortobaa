import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_task_kortobaa/core/utils/colors.dart';
import 'package:flutter_task_kortobaa/widget/custom_buttons.dart';

import '../core/utils/style.dart';
import '../services/cubit/connection/connection.dart';

class MaterialBuilderWidget extends StatelessWidget {
  const MaterialBuilderWidget(this.child, {Key? key}) : super(key: key);
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final cubit = ConnectionCubit.get(context);
    return BlocBuilder(
      bloc: cubit,
      builder: (context, state) => SafeArea(
        top: Platform.isAndroid,
        child: (state is ConnectionLost)
            ? Scaffold(


                body: Container(
                  // color: Theme.of(context).focusColor,
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.signal_wifi_off_rounded,
                        color: Theme.of(context).focusColor,
                        size: 150,
                      ),
                      const SizedBox(height: 20),

                      Text(
                        'لا يوجد إتصال بالانترنت!',
                        style: Theme.of(context).textTheme.headline4,
                      ),
                      const SizedBox(height: 20),
                      // Builder(
                      //   builder: (context) => SizedBox(
                      //     width: 200,
                      //     height: 50,
                      //     child: ElevatedButton(
                      //         onPressed: () async {
                      //           cubit.listenConnectionState();
                      //
                      //           final ref =
                      //               await Connectivity().checkConnectivity();
                      //
                      //           ScaffoldMessenger.of(context).showSnackBar(
                      //               SnackBar(content: Text(ref.toString())));
                      //         },
                      //         child: const Text(
                      //           'اعادة المحاولة',
                      //           style: TextStyle(
                      //             fontSize: 20,
                      //             wordSpacing: 5,
                      //           ),
                      //         )),
                      //   ),
                      // ),
                      CustomButtonArgonAnimation(
                        width: MediaQuery.of(context).size.width * 0.5,
                        height: 70.0,
                        color: MyColors.colorPrimary,
                        text: 'اعادة المحاولة',
                        onTap: (start, stop, state) async {
                          cubit.listenConnectionState();

                          final ref = await Connectivity().checkConnectivity();

                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(ref.toString())));
                        },
                      )
                    ],
                  ),
                ),
              )
            : child,
      ),
    );
  }
}
