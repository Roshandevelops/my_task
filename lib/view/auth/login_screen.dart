import 'dart:developer';
import 'dart:convert';
import 'package:crypto/crypto.dart';

import 'package:flutter/material.dart';
import 'package:my_task/controller/user_provider.dart';
import 'package:my_task/view/home/home_screen.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController passController = TextEditingController();

  @override
  void initState() {
    Provider.of<UserProvider>(context, listen: false).getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login page"),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Consumer<UserProvider>(
            builder: (context, userConsumer, child) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextFormField(
                    controller: mobileController,
                    decoration: const InputDecoration(
                      hintText: "Enter Phone Number",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: passController,
                    decoration: const InputDecoration(
                      hintText: "Enter Password",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (userConsumer.userList.any(
                        (element) => element.mobile == mobileController.text,
                      )) {
                        final user = userConsumer.userList.firstWhere(
                          (element) => element.mobile == mobileController.text,
                        );

                        final convertedPassword =
                            generateMd5(passController.text);

                        log(convertedPassword);
                        if (user.password == convertedPassword) {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const HomeScreen(),
                            ),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Wrong Password")),
                          );
                        }
                        log(user.name.toString());
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("User Doesn't Exists"),
                          ),
                        );
                        //snackbar for user not exists
                      }
                    },
                    child: const Text("Login"),
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  String generateMd5(String input) {
    return md5.convert(utf8.encode(input)).toString();
  }
}
