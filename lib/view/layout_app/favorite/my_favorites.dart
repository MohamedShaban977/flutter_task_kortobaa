import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

import '../../../services/cubit/app_cubit/app_cubit.dart';
import '../../../widget/Custom_card_post.dart';

// ignore: must_be_immutable
class FavoriteView extends StatelessWidget {
  FavoriteView({Key? key}) : super(key: key);

  late AppCubit _cubit;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        _cubit = AppCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text('Favorites'.tr()),
          ),
          body: RefreshIndicator(
            onRefresh: () async {
              _cubit.postsFavoritesHave.clear();
              _cubit.getPostsFavoritesInHave();
            },
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(
                  parent: ClampingScrollPhysics()),
              child: _cubit.postsFavoritesHave.isEmpty
                  ? SizedBox(
                      height: MediaQuery.of(context).size.height * 0.7,
                      child: Center(child: Text('FavoritesIsIEmpty'.tr())))
                  : Column(
                      children: List.generate(
                          _cubit.postsFavoritesHave.length,
                          (index) => Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CardPast(
                                  isFavorite: true,
                                  postModel: _cubit.postsFavoritesHave[index],
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
