import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_task_kortobaa/core/utils/colors.dart';
import 'package:flutter_task_kortobaa/widget/custom_buttons.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

import '../services/cubit/connection/connection.dart';

class MaterialBuilderWidget extends StatelessWidget {
  const MaterialBuilderWidget(this.child, {Key? key}) : super(key: key);
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final cubit = ConnectionCubit.get(context);
    return BlocBuilder(
      bloc: cubit,
      builder: (context, state) => (state is ConnectionLost)
          ? Scaffold(
              body: SizedBox(
                // color: Theme.of(context).focusColor,
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.signal_wifi_off_rounded,
                      color: Theme.of(context).focusColor,
                      size: MediaQuery.of(context).size.height*0.2,
                    ),
                    const SizedBox(height: 20),

                    Text(
                      'NoInternetConnection'.tr(),
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    const SizedBox(height: 20),

                    CustomButtonArgonAnimation(
                      width: MediaQuery.of(context).size.width * 0.5,
                      height: 70.0,
                      color: MyColors.colorPrimary,
                      text: 'TryAgain'.tr(),
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
    );
  }
}
