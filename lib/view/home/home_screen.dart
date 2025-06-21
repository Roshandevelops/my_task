import 'package:flutter/material.dart';
import 'package:my_task/controller/user_provider.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Consumer<UserProvider>(builder: (context, userConsumer, child) {
          return ListView.builder(
            itemCount: userConsumer.userList.length,
            itemBuilder: (context, index) {
              final user = userConsumer.userList[index];

              return ListTile(
                leading: Text("${index + 1}"),
                title: Text(user.name ?? "NIL"),
              );
            },
          );
        }),
      ),
    );
  }
}
