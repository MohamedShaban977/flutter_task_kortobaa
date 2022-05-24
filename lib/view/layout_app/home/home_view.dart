import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_task_kortobaa/core/utils/style.dart';
import 'package:flutter_task_kortobaa/services/cubit/app_cubit/app_cubit.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

import '../../../core/utils/colors.dart';
import '../../../widget/Custom_card_post.dart';
import '../../../widget/custom_dialog_create_post.dart';

// ignore: must_be_immutable
class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late Size deviseSize;
  final ScrollController scrollController = ScrollController();

  late AppCubit _cubit;

  @override
  void initState() {
    super.initState();
    setupScrollController();
  }

  void setupScrollController() {
    scrollController.addListener(() {
      double maxScroll = scrollController.position.maxScrollExtent;
      double currentScroll = scrollController.position.pixels;
      double delta = MediaQuery.of(context).size.height * 0.25;
      if (maxScroll - currentScroll <= delta) {
        _cubit.getMorePosts();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    deviseSize = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: BlocBuilder<AppCubit, AppState>(
        builder: (context, state) {
          _cubit = AppCubit.get(context);
          return Scaffold(
              resizeToAvoidBottomInset: false,
              floatingActionButton: buildFloatingActionButton(context),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.startFloat,
              body: RefreshIndicator(
                onRefresh: () async => AppCubit.get(context).onRefreshGetPost(),
                child: SingleChildScrollView(
                  controller: scrollController,
                  child: Container(
                      child: _cubit.loadingPost
                          ? loading(context)
                          : Container(
                              child: _cubit.posts.length == 0
                                  ? Center(
                                      child: Text('NotFoundData'.tr()),
                                    )
                                  : buildListViewPosts(context),
                            )),
                ),
              ));
        },
      ),
    );
  }

  Column buildListViewPosts(BuildContext context) {
    return Column(
      children: List.generate(
          _cubit.posts.length + (_cubit.morePostsAvailable ? 1 : 0), (index) {
        if (index < _cubit.posts.length) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: CardPast(
              postModel: _cubit.posts[index],
              index: index,
              cubit: AppCubit.get(context),
            ),
          );
        }
        return const SizedBox(
          height: 100,
          child: Center(
            child: CircularProgressIndicator(
              color: Colors.red,
              strokeWidth: 5.0,
            ),
          ),
        );
      }),
    );
  }

  FloatingActionButton buildFloatingActionButton(context) {
    return FloatingActionButton(
      onPressed: () {
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (_) => CustomDialogCreateNewPost());
      },
      backgroundColor: MyColors.colorOrangeSecond,
      child: const Icon(Icons.add, color: Colors.white),
    );
  }
}
