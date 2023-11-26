import 'package:flutter_app_new/favourite/view/bloc/favorite_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class FavoriteRepository {
  Future<void> getListData(FetchedListEvent event, Emitter<FavoriteState> emit);
}
