import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:tiktok_clone/constants.dart';
import 'package:tiktok_clone/models/user.dart';

class SearchController extends GetxController {
  final Rx<List<User>> _searchedUsers = Rx<List<User>>([]);
  List<User> get searchedUsers => _searchedUsers.value;

  searchUser(String typedUser) async {
    print("callling Searchg");
    _searchedUsers.bindStream(
      firebaseFirestore
          .collection('users')
          .where('username', isGreaterThanOrEqualTo: typedUser)
          .snapshots()
          .map(
        (QuerySnapshot querySnapshot) {
          List<User> retVal = [];
          for (var element in querySnapshot.docs) {
            retVal.add(
              User.fromSnap(element),
            );
          }
          return retVal;
        },
      ),
    );
  }
}
