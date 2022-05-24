import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_task_kortobaa/widget/toast_and_snackbar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../core/helper/local/hive_helper.dart';
import '../core/utils/colors.dart';
import '../services/cubit/app_cubit/app_cubit.dart';
import '../services/model/post_model.dart';

class CardPast extends StatelessWidget {
  final PostModel postModel;
  final AppCubit cubit;
  final int index;
  final bool isSaved;

  final bool isFavorite;

  CardPast(
      {Key? key,
      required this.postModel,
      required this.cubit,
      required this.index,
      this.isSaved = false,
      this.isFavorite = false})
      : super(key: key);

  late Size deviceSize;

  @override
  Widget build(BuildContext context) {
    deviceSize = MediaQuery.of(context).size;
    return buildCardPast(context, postModel);
  }

  Card buildCardPast(context, PostModel postModel) => Card(
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10.0),
            //Top Row
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildImagePostOwner(postModel),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: InkWell(
                          onTap: () async => ToastAndSnackBar.toastSuccess(
                              message: 'Shared is not completed'),
                          radius: 20.0,
                          borderRadius: BorderRadius.circular(20.0),
                          child: Icon(
                            Icons.share,
                            size: 20,
                            color: MyColors.colorDrawre.withOpacity(0.6),
                          ),
                        ),
                      ),
                      const SizedBox(width: 20.0),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: InkWell(
                          onTap: () async => isSaved
                              ? await cubit.deletePostInSavedHive(index)
                              : await cubit.savedOrDeletePostInHave(index),
                          radius: 20.0,
                          borderRadius: BorderRadius.circular(20.0),
                          child: HiveHelper.savedPostsDB
                                  .containsKey(postModel.idPost)
                              ? const Icon(
                                  Icons.bookmark,
                                  size: 20,
                                  color: MyColors.colorDrawre,
                                )
                              : const Icon(
                                  Icons.bookmark_border,
                                  size: 20,
                                  color: MyColors.colorDrawre,
                                ),
                        ),
                      ),
                      const SizedBox(width: 15.0),
                      buildLikesAndCount(context),
                    ],
                  ),
                ],
              ),
            ),

            if (postModel.imagePost!.isNotEmpty)

              /// Image Post
              buildImagePost(),

            /// Text Post
            buildTextPost(context),

            const SizedBox(height: 8.0),
          ],
        ),
      );

  Column buildLikesAndCount(
    context,
  ) =>
      Column(
        children: [
          InkWell(
            onTap: () async {
              await cubit.updateLikePost(postPosition: postModel);
              if (isFavorite) {
                cubit.deletePostInFavoritesHive(postModel);
              } else {
                cubit.favoritesOrDeletePostInHave(postModel);
              }
            },
            radius: 20.0,
            borderRadius: BorderRadius.circular(20.0),
            child: Padding(
                padding: const EdgeInsets.all(5.0),
                child:
                    postModel.likes!.likesUserId!.contains(cubit.userModel.uId)
                        ? const Icon(
                            FontAwesomeIcons.solidThumbsUp,
                            size: 19,
                            color: MyColors.colorDrawre,
                          )
                        : Icon(
                            FontAwesomeIcons.thumbsUp,
                            size: 19,
                            color: MyColors.colorDrawre.withOpacity(0.5),
                          )),
          ),
          Container(
              decoration: BoxDecoration(
                  color: MyColors.colorDrawre.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(5.0)),
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
              child: Text(
                '${postModel.likes!.likesUserId!.length}',
                style: Theme.of(context).textTheme.caption!.copyWith(
                      color: MyColors.colorPrimary.withOpacity(0.8),
                    ),
              ))
        ],
      );

  Card buildImagePost() => Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: CachedNetworkImage(
          imageUrl: postModel.imagePost!,
          height: deviceSize.height * 0.22,
          width: deviceSize.width,
          fit: BoxFit.cover,
        ),
      );

  Padding buildTextPost(context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
        child: Text(postModel.text ?? '',
            textAlign: TextAlign.start,
            style: Theme.of(context)
                .textTheme
                .subtitle1!
                .copyWith(height: 1.5, color: MyColors.colorDrawre)),
      );

  Padding buildImagePostOwner(index) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: CircleAvatar(
          radius: 25,
          backgroundImage: CachedNetworkImageProvider(postModel.imageUser!),
          backgroundColor: MyColors.colorDrawre.withOpacity(0.15),
          child: postModel.imageUser == null
              ? Icon(
                  FontAwesomeIcons.solidUser,
                  size: 20,
                  color: MyColors.colorDrawre.withOpacity(0.4),
                )
              : const SizedBox(),
        ),
      );
}
