import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:papar_plane/common/component/idea_widget.dart';
import 'package:papar_plane/common/component/textformfield.dart';
import 'package:papar_plane/common/model/state_model.dart';
import 'package:papar_plane/common/variable/category.dart';
import 'package:papar_plane/common/variable/colors.dart';
import 'package:papar_plane/common/variable/image_path.dart';
import 'package:papar_plane/common/variable/textstyle.dart';
import 'package:papar_plane/idea/model/idea_model.dart';
import 'package:papar_plane/idea/provider/idea_provider.dart';
import 'package:papar_plane/user/view/signup_screen.dart';

final searchQueryProvider = StateProvider<String>((ref) => '');

class HomeScreen extends ConsumerStatefulWidget {
  HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    ref.read(ideaProvider.notifier).getAllData();
    super.initState();
  }

  String tabValue = "전체";

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(ideaCategoryProvider(getCategoryString(tabValue)));
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
    final String searchQuery = ref.watch(searchQueryProvider);
    List<IdeaModel> filteredList = dataList.where((idea) {
      return idea.title.contains(searchQuery);
    }).toList();
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          searchBar(),
          const SizedBox(height: 10),
          customTabBar(),
          const Divider(),
          Expanded(
            child: RefreshIndicator(
              onRefresh: () async {
                await ref.read(ideaProvider.notifier).getAllData();
              },
              child: ListView.builder(
                padding: const EdgeInsets.only(top: 10),
                shrinkWrap: true,
                itemCount: filteredList.length,
                itemBuilder: (context, index) {
                  final data = filteredList[index];
                  return IdeaWidget(
                    id: data.ideaId,
                    title: data.title,
                    tags: data.tags,
                    point: data.price,
                    category: data.category,
                    date: data.createdAt,
                    isOnTapDetialScreen: true,
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Search bar
  Padding searchBar(){
    return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Image.asset(
                  PaperPlaneImgPath.logo,
                  width: 60,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: CustomTextFormField(
                    isDense: true,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    borderColor: PaperPlaneColor.mainColor,
                    fillColor: Colors.white,
                    controller: _controller,
                    hintText: "",
                    onChanged: (val){
                      ref.read(searchQueryProvider.notifier).state = val;
                    },
                  ),
                ),
                const SizedBox(width: 5),
                Icon(
                  Icons.search,
                  color: PaperPlaneColor.mainColor,
                  size: 30,
                )
              ],
            ),
    );
  }

  // TabBar
  Widget customTabBar() {
    return SizedBox(
      height: 20,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          final tab = category[index];
          if (index == 0) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  tabValue = tab;
                });
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 20),
                child: tabText(tab),
              ),
            );
          }
          if (index == category.length - 1) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  tabValue = tab;
                });
              },
              child: Padding(
                padding: const EdgeInsets.only(right: 20),
                child: tabText(tab),
              ),
            );
          }
          return GestureDetector(
            onTap: () {
              setState(() {
                tabValue = tab;
              });
            },
            child: tabText(tab),
          );
        },
        separatorBuilder: (context, index) {
          return const SizedBox(width: 20);
        },
        itemCount: category.length,
      ),
    );
  }

  // Tab에 들어가는 텍스트
  // Value값에 따라서 Style이 달라집니다.
  Text tabText(String text) {
    if (text != tabValue) {
      return Text(
        text,
        style: PaperPlaneTS.medium(
          fontSize: 16,
          color: PaperPlaneColor.greyColor66,
        ),
      );
    }
    return Text(
      text,
      style: PaperPlaneTS.medium(fontSize: 16),
    );
  }
}
