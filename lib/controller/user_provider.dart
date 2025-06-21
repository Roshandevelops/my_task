import 'package:flutter/material.dart';
import 'package:my_task/model/user_model.dart';
import 'package:my_task/service/user_service.dart';

class UserProvider extends ChangeNotifier {
  List<UserModel> userList = [];
  Future<void> getData() async {
    if (userList.isNotEmpty) {
      return ;
    }
    userList = await UserService.instance.fetchUserDetails();
    notifyListeners();

  }
}
