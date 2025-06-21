import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:my_task/model/user_model.dart';



class UserService {
  UserService.internal();
  static UserService instance = UserService.internal();
  factory UserService() {
    return UserService.instance;
  }

  Future<List<UserModel>> fetchUserDetails() async {
    try {
      final response = await http.get(
        Uri.parse(
            "https://koolmindz.com/admin/api/v2/index.php?token=5692b9ad75db64efd3e5b623e440833d"),
      );

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body) as Map;

        final result = (json["data"] as List).map(
          (e) {
            // log(e["name"]);

            return UserModel.fromJson(e);
          },
        ).toList();

        // log(result.toString());

        return result;
      } else {
        return [];
      }
    } catch (e) {
      return Future.error(e);
    }
  }
}
