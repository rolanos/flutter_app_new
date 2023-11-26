import 'dart:convert';

import 'package:flutter_app_new/favourite/data/model/example_list.dart';
import 'package:flutter_app_new/favourite/domain/favourite_repository.dart';
import 'package:flutter_app_new/favourite/view/bloc/favorite_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';

class FavoriteRepositoryImpl extends FavoriteRepository {
  @override
  Future<void> getListData(
      FetchedListEvent event, Emitter<FavoriteState> emit) async {
    emit(LoadingListState());
    try {
      Dio dio = Dio();
      final response = await dio.get(
        "https://jsonplaceholder.typicode.com/posts",
      );
      if (response.statusCode == 200) {
        final List<ExampleList> exampleList = (response.data as List)
            .map((data) => ExampleList.fromJson(data))
            .toList();

        emit(LoadedListState(exampleList));
      }
    } catch (_) {
      emit(FailureProfileState());
    }
  }
}
