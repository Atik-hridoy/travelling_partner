import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/theme/colors.dart';
import '../../core/theme/typography.dart';
import 'profile_controller.dart';
import 'widgets/profile_header.dart';
import 'widgets/stats_row.dart';
import 'widgets/section_header.dart';
import 'widgets/collections_bento.dart';
import 'widgets/achievements_section.dart';
import 'widgets/settings_list.dart';
import 'widgets/log_out_button.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.isRegistered<ProfileController>()
        ? Get.find<ProfileController>()
        : Get.put(ProfileController());

    return Scaffold(
      backgroundColor: VoyentaColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 16.0, bottom: 120.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Profile Header
              Obx(() => ProfileHeader(user: controller.user.value)),
              const SizedBox(height: 28),

              // Stats Section
              Obx(() => StatsRow(stats: controller.stats.value)),
              const SizedBox(height: 36),

              // Saved Collections (Bento Grid)
              const SectionHeader(title: 'Saved Collections', action: 'View All'),
              const SizedBox(height: 16),
              Obx(() => CollectionsBento(collections: controller.collections.value)),
              const SizedBox(height: 36),

              // Achievements Section
              Text(
                'Achievements',
                style: VoyentaTypography.headlineMd.copyWith(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: VoyentaColors.onSurface,
                ),
              ),
              const SizedBox(height: 16),
              Obx(() => AchievementsSection(achievements: controller.achievements.value)),
              const SizedBox(height: 36),

              // Account Settings
              Text(
                'Account Settings',
                style: VoyentaTypography.headlineMd.copyWith(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: VoyentaColors.onSurface,
                ),
              ),
              const SizedBox(height: 16),
              Obx(() => SettingsList(settings: controller.settings.value)),
              const SizedBox(height: 16),

              // Log Out Button
              const LogOutButton(),
            ],
          ),
        ),
      ),
    );
  }
}
