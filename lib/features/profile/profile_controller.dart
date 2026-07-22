import 'package:get/get.dart';
import '../../core/mock/mock_data.dart';

class ProfileController extends GetxController {
  final user = Rx<Map<String, dynamic>>(MockData.profileUser);
  final stats = Rx<List<Map<String, String>>>(MockData.profileStats);
  final collections = Rx<List<Map<String, String>>>(MockData.profileCollections);
  final achievements = Rx<List<Map<String, dynamic>>>(MockData.profileAchievements);
  final settings = Rx<List<Map<String, dynamic>>>(MockData.profileSettings);

  void updateUserProfile({
    required String name,
    required String bio,
    required String location,
    required String website,
  }) {
    final updated = Map<String, dynamic>.from(user.value);
    updated['name'] = name;
    updated['bio'] = bio;
    updated['tagline'] = bio;
    updated['location'] = location;
    updated['website'] = website;
    user.value = updated;
  }
}
