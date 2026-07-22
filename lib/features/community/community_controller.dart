import 'package:get/get.dart';

class CommunityController extends GetxController {
  // Simple reactives
  var likedPosts = <int>[].obs;

  void toggleLike(int postId) {
    if (likedPosts.contains(postId)) {
      likedPosts.remove(postId);
    } else {
      likedPosts.add(postId);
    }
  }
}
