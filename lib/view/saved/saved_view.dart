import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_task_kortobaa/services/cubit/app_cubit/app_cubit.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

import '../home/home_view.dart';

// ignore: must_be_immutable
class SavedView extends StatelessWidget {
  SavedView({Key? key}) : super(key: key);

  late AppCubit _cubit;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        _cubit = AppCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text('Saved'.tr()),
          ),
          body: RefreshIndicator(
            onRefresh: ()async{
              _cubit.postsSavedHave.clear();
              _cubit.getPostsSavedInHave();
            },
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(
                  parent: ClampingScrollPhysics()),
              child: _cubit.postsSavedHave.isEmpty
                  ? SizedBox(
                      height: MediaQuery.of(context).size.height * 0.7,
                      child:  Center(child: Text('SavedIsIEmpty'.tr())))
                  : Column(
                      children: List.generate(
                          _cubit.postsSavedHave.length,
                          (index) => Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CardPast(
                                  isSaved: true,
                                  postModel: _cubit.postsSavedHave[index],
                                  index: index,
                                  cubit: _cubit,
                                ),
                              )),
                    ),
            ),
          ),
        );
      },
    );
  }
}
