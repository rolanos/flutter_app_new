import 'package:flutter/material.dart';
import 'package:flutter_app_new/navigation/bottom_bar_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/auth_bloc_bloc.dart';

class Auth extends StatefulWidget {
  const Auth({Key? key}) : super(key: key);

  @override
  State<Auth> createState() => _AuthState();
}

class _AuthState extends State<Auth> {
  final usernameController = TextEditingController();
  final emailController = TextEditingController();

  final usernameValidator = RegExp(r'^[a-zA-Zа-яА-Я]*$');
  final emailValidator = RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$');

  late AuthBlocBloc authBloc;

  @override
  void initState() {
    authBloc = AuthBlocBloc();
    super.initState();
  }

  @override
  void dispose() {
    usernameController.dispose();
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Регистрация",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
          ),
          backgroundColor: Colors.blue,
        ),
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.white,
                Colors.blue,
              ],
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                buildAuthBlocListener(),
                buildTextFormField(),
                buildButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildAuthBlocListener() {
    return BlocConsumer(
      bloc: authBloc,
      listener: (context, state) {
        if (state is LoadedAuthState) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BottomBarPage(
                userProfileName: state.username,
                userProfileEmail: state.email,
              ),
            ),
          );
        }
        if (state is FailureLoginState) {
          const errorMessage = "Ошибка подключения к БД";
          showError(context, errorMessage);
        }
      },
      builder: (context, state) {
        if (state is LoadingAuthState) {
          return Align(
            alignment: FractionalOffset.bottomCenter,
            child: Container(
              color: Colors.black.withOpacity(0.2),
              child: const Center(
                child: CircularProgressIndicator(
                  color: Colors.red,
                ),
              ),
            ),
          );
        }
        return Container();
      },
    );
  }

  Widget buildTextFormField() {
    return Column(
      children: [
        TextFormField(
          controller: usernameController,
          keyboardType: TextInputType.text,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            icon: Icon(Icons.login_rounded),
            hintText: "Введите логин",
          ),
        ),
        const SizedBox(height: 6),
        TextFormField(
          controller: emailController,
          keyboardType: TextInputType.emailAddress,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            icon: Icon(Icons.email),
            hintText: "Введите email",
          ),
        ),
      ],
    );
  }

  Widget buildButton() {
    return Padding(
      padding: const EdgeInsets.only(top: 15.0), // Смещение кнопки вниз
      child: ElevatedButton(
        onPressed: () {
          String username = usernameController.text;
          String email = emailController.text;

          if (usernameValidator.hasMatch(username) &&
              emailValidator.hasMatch(email)) {
            authBloc.add(GetAuthEvent(username, email));
          } else {
            const errorMessage = "Неверный формат имени пользователя или email";
            showError(context, errorMessage);
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.pink,
          shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(5.0), // Уменьшение радиуса скругления
          ),
        ),
        child: const Text("Зарегистрировать",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
      ),
    );
  }

  void showError(BuildContext context, String errorMessage) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Ошибка"),
          content: Text(errorMessage),
          actions: <Widget>[
            OutlinedButton(
              child: const Text("Закрыть"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
