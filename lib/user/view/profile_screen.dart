import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:papar_plane/common/component/appbar.dart';
import 'package:papar_plane/common/component/idea_widget.dart';
import 'package:papar_plane/common/layout/default_layout.dart';
import 'package:papar_plane/common/model/state_model.dart';
import 'package:papar_plane/common/variable/colors.dart';
import 'package:papar_plane/common/variable/textstyle.dart';
import 'package:papar_plane/post/model/idea_model.dart';
import 'package:papar_plane/user/component/user_image.dart';
import 'package:papar_plane/user/provider/user_idea_provider.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  static String get routeName => "profile";
  final String username;
  const ProfileScreen({
    required this.username,
    super.key,
  });

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  @override
  void initState() {
    ref.read(userIdeaProvider.notifier).getData(widget.username);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(userIdeaProvider);
    return DefaultLayout(
      appBar: CustomAppBar.noActionAppBar(context, title: "프로필"),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
            decoration: BoxDecoration(
              color: PaperPlaneColor.greyColorF6,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Row(
              children: [
                const UserImage(size: 60),
                const SizedBox(width: 5),
                Text(
                  "r",
                  style: PaperPlaneTS.bold(fontSize: 20),
                ),
              ],
            ),
          ),
          expandView(state),
        ],
      ),
    );
  }

  Widget expandView(BaseState state) {
    if (state is LoadingState) {
      return Center(
        child: CircularProgressIndicator(
          color: PaperPlaneColor.mainColor,
        ),
      );
    }

    if (state is ErrorState) {
      return Center(child: Text(state.msg));
    }
    final dataList = (state as IdeaModelList).data;
    return Expanded(
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: dataList.length,
        itemBuilder: (context, index) {
          final data = dataList[index];
          return IdeaWidget(
            id: data.id,
            title: data.title,
            tags: data.tags,
            point: data.price,
            category: data.category,
            date: data.createdAt,
          );
        },
      ),
    );
  }
}
