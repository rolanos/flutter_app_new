part of 'favorite_bloc.dart';

@immutable
class FavoriteState {}

class FavoriteInitial extends FavoriteState {}

class LoadingListState extends FavoriteState {}

class LoadedListState extends FavoriteState {
  final List<ExampleList> exampleList;
  LoadedListState(this.exampleList);
}

class FailureProfileState extends FavoriteState {}
