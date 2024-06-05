import 'package:get/get.dart';

import '../constants.dart';
import '../models/users.dart';

class SearchUserController extends GetxController {
  final Rx<List<User>> _searchUser = Rx<List<User>>([]);
  List<User> get searchedUser => _searchUser.value;

  void searchUser(String typed) async {
    _searchUser.bindStream(fireStore
        .collection("users")
        .where("name", isGreaterThanOrEqualTo: typed)
        .snapshots()
        .map(
      (event) {
        List<User> retValue = [];
        for (var element in event.docs) {
          retValue.add(User.fromsnap(element));
        }
        return retValue;
      },
    ));
  }
}
