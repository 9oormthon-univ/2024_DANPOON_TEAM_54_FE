import 'dart:io';
import 'package:http_parser/http_parser.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:papar_plane/common/model/state_model.dart';
import 'package:papar_plane/idea/model/idea_model.dart';
import 'package:papar_plane/idea/model/write_model.dart';
import 'package:papar_plane/idea/repository/idea_repository.dart';

final ideaCategoryProvider = Provider.family<BaseState, String>((ref, category){
  final state = ref.watch(ideaProvider);

  if(!(state is IdeaModelList)){
    return state;
  }
  if(category == "전체"){
    return state;
  }
  final newData = (state as IdeaModelList).copyWith(data: (state as IdeaModelList).data.where((e) => e.category == category).toList());
  return newData;
});

final ideaProvider = StateNotifierProvider<IdeaNotifier, BaseState>((ref) {
  final repo = ref.watch(ideaRepositoryProvider);

  return IdeaNotifier(repo: repo);
});

class IdeaNotifier extends StateNotifier<BaseState> {
  final IdeaRepository repo;
  
  IdeaNotifier({
    required this.repo,
  }):super(LoadingState());

  // 모든 데이터 가져오기
  Future<void> getAllData() async {
    //state = LoadingState();
    final resp = await repo.getAllData();
    state = resp;
  }

  // 삭제
  Future<void> delete(int id, int userId) async {
    await repo.delete(id: id, userId: userId);
  }

  // 모든 데이터 가져오기
  Future<int?> write({
    required WriteModel model,
    required int userId,
    File? file,
  }) async {
    MultipartFile? fileData;
    if(file != null){
      fileData = await MultipartFile.fromFile(
        file.path, 
        filename: file.path.split('/').last,
      );
    }
    // FormData 생성: JSON 데이터와 파일 포함
    final formData = FormData.fromMap({
      ...model.toJson(),
      "file": fileData,
    });
    final resp = await repo.write(formData: formData, userId: userId);
    if(resp == null){
      return null;
    }
    return resp.ideaId;
  }

  // 파일 데이터 가져오기
  Future<String?> getFile(int id, int userId) async {
    final resp = await repo.getFile(id: id, userId: userId);
    return resp;
  }
}
