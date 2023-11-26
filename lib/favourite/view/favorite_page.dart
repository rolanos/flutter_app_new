import 'package:flutter/material.dart';
import 'package:flutter_app_new/favourite/data/model/example_list.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/favorite_bloc.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({Key? key}) : super(key: key);

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  late FavoriteBloc favoriteBloc;
  List<ExampleList> exampleList = [];

  @override
  void initState() {
    favoriteBloc = FavoriteBloc();
    favoriteBloc.add(FetchedListEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Избранное",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500)),
        backgroundColor: Colors.pink,
      ),
      body: BlocBuilder(
        bloc: favoriteBloc,
        builder: (context, state) {
          if (state is LoadingListState) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.blue,
              ),
            );
          }
          if (state is LoadedListState) {
            exampleList = state.exampleList;
            return buildBody();
          }
          if (state is FailureProfileState) {
            return const Center(
              child: Text("Ошибка"),
            );
          }
          return Container();
        },
      ),
    );
  }

  Widget buildBody() {
    List<Widget> children = [];
    for (var item in exampleList) {
      children.add(
        Stack(
          children: [
            Card(
              elevation: 3, // Добавляем тень
              margin: const EdgeInsets.all(10),
              shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(10), // Добавляем закругления
              ),
              color: Colors.white,
              child: ListTile(
                leading: const Icon(
                  Icons.favorite, // Иконка сердечка
                  color: Colors.blue, // Цвет иконки
                ),
                title: Text(
                  item.title.toString(),
                  textAlign: TextAlign.start,
                ),
              ),
            ),
          ],
        ),
      );
    }
    return Center(
      child: SingleChildScrollView(
        child: Column(children: children),
      ),
    );
  }
}
