import 'dart:ui';
import 'package:appwrite/appwrite.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:quizentialz/core/api/client.appwrite.dart';
import 'package:quizentialz/core/navigation/pages.dart';
import 'package:quizentialz/core/theme/theme.dart';
import 'package:quizentialz/other/loading.dialog.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool showLoginForm = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            left: -180,
            top: 0,
            bottom: 0,
            child: CircleAvatar(
              radius: MediaQuery.of(context).size.width * .15,
              backgroundColor: Themes.nionClr.withAlpha(60),
            ),
          ),
          Positioned(
            right: 120,
            top: 0,
            bottom: 0,
            child: CircleAvatar(
              radius: MediaQuery.of(context).size.width * .15,
              backgroundColor: Themes.nionClr.withAlpha(30),
            ),
          ),
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
            child: SizedBox(),
          ),
          Row(
            children: [
              Expanded(
                child: AnimatedSwitcher(
                  duration: Duration(milliseconds: 550),
                  switchInCurve: Curves.fastOutSlowIn,
                  switchOutCurve: Curves.fastOutSlowIn,
                  child: showLoginForm
                      ? LoginForm()
                      : Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Spacer(),
                            Image.asset(
                              "assets/images/logo.png",
                              width: 250,
                              height: 250,
                              fit: BoxFit.cover,
                            ),
                            Text(
                              "Welcome To Quzzentialz".toUpperCase(),
                              style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontStyle: FontStyle.normal,
                                  ),
                            ),
                            SizedBox(height: 30),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                backgroundColor: Themes.primaryClr,
                              ),
                              onPressed: () {
                                setState(() {
                                  showLoginForm = true;
                                });
                              },
                              child: Text(
                                "Start Your Journey",
                                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                            ),
                            Spacer(),
                            Spacer(),
                          ],
                        ),
                ),
              ),
              Expanded(
                child: Center(
                  child: SvgPicture.asset(
                    "assets/images/auth_ill.svg",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController emailCont = TextEditingController();
  final TextEditingController passCont = TextEditingController();

  final LoadingDialog dialog = LoadingDialog();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            "assets/images/logo.png",
            width: 250,
            height: 250,
            fit: BoxFit.cover,
          ),
          SizedBox(height: 10),
          TextFormField(
            controller: emailCont,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.white),
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
              hintText: "Email",
              hintStyle: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Colors.grey,
                  ),
            ),
          ),
          SizedBox(height: 10),
          TextFormField(
            obscureText: true,
            controller: passCont,
            textInputAction: TextInputAction.done,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.white),
            decoration: InputDecoration(
              hintStyle: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Colors.grey,
                  ),
              hintText: "Password",
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 25),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                backgroundColor: Themes.primaryClr,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              onPressed: () async {
                if (emailCont.text.isNotEmpty || passCont.text.isNotEmpty) {
                  dialog.show(context);
                  await AppwriteClient.auth.create(userId: ID.unique(), email: emailCont.text, password: passCont.text);
                  await AppwriteClient.auth.createEmailPasswordSession(email: emailCont.text, password: passCont.text);
                  if (context.mounted) {
                    dialog.close(context);
                    while (context.canPop()) {
                      context.pop();
                    }
                    context.pushNamed(Pages.MAIN_PAGE);
                  }
                }
              },
              child: Text(
                "Create Account",
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Colors.white,
                    ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
