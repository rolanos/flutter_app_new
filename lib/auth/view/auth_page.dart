import 'package:flutter/material.dart';
import 'package:flutter_app_new/navigation/bottom_bar_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/auth_bloc_bloc.dart';

class Auth extends StatefulWidget {
  Auth({Key? key}) : super(key: key);

  final messangerKey = GlobalKey<ScaffoldMessengerState>();

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
      home: ScaffoldMessenger(
        key: widget.messangerKey,
        child: Scaffold(
          appBar: AppBar(
            title: const Text(
              "Регистрация",
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
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
          showError(widget.messangerKey, errorMessage);
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

  void showError(GlobalKey scaffoldKey, String errorMessage) {
    if (scaffoldKey.currentState != null) {
      (scaffoldKey.currentState as ScaffoldMessengerState).showSnackBar(
        SnackBar(
          content: Text(errorMessage),
          duration:
              const Duration(seconds: 3), // Длительность отображения SnackBar
          action: SnackBarAction(
            label: 'Закрыть',
            onPressed: () {
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
            },
          ),
        ),
      );
    }
  }

  void showEmptyFieldsError(GlobalKey scaffoldKey) {
    showError(scaffoldKey, 'Пожалуйста, заполните все поля.');
  }

  void showInvalidFormatError(GlobalKey scaffoldKey) {
    showError(scaffoldKey, 'Неверный формат имени пользователя или email.');
  }

  Widget buildButton() {
    return Padding(
      padding: const EdgeInsets.only(top: 15.0), // Смещение кнопки вниз
      child: ElevatedButton(
        onPressed: () {
          String username = usernameController.text;
          String email = emailController.text;

          if (username.isEmpty || email.isEmpty) {
            showEmptyFieldsError(widget.messangerKey);
          } else if (!usernameValidator.hasMatch(username) ||
              !emailValidator.hasMatch(email)) {
            showInvalidFormatError(widget.messangerKey);
          } else {
            authBloc.add(GetAuthEvent(username, email));
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.pink,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
        ),
        child: const Text("Зарегистрировать",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
      ),
    );
  }
}
