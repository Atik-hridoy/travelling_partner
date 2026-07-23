import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/theme/colors.dart';
import '../../../core/theme/typography.dart';
import '../map_controller.dart';

/// Floating glassmorphic search bar — sits at the top of the Map screen.
/// Tap to expand → type to see autocomplete suggestions → select to move map.
class MapSearchBar extends StatefulWidget {
  const MapSearchBar({super.key});

  @override
  State<MapSearchBar> createState() => _MapSearchBarState();
}

class _MapSearchBarState extends State<MapSearchBar>
    with SingleTickerProviderStateMixin {
  late final TextEditingController _textCtrl;
  late final FocusNode _focusNode;
  late final AnimationController _animCtrl;

  @override
  void initState() {
    super.initState();
    _textCtrl = TextEditingController();
    _focusNode = FocusNode();
    _animCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 280),
    );
  }

  @override
  void dispose() {
    _textCtrl.dispose();
    _focusNode.dispose();
    _animCtrl.dispose();
    super.dispose();
  }

  void _openSearch(MapController ctrl) {
    ctrl.activateSearch();
    _animCtrl.forward();
    Future.delayed(const Duration(milliseconds: 50), () => _focusNode.requestFocus());
  }

  void _closeSearch(MapController ctrl) {
    _focusNode.unfocus();
    _textCtrl.clear();
    ctrl.deactivateSearch();
    _animCtrl.reverse();
  }

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.find<MapController>();
    final topPadding = MediaQuery.of(context).padding.top;

    return Positioned(
      top: topPadding + 12,
      left: 16,
      right: 16,
      child: Column(
        children: [
          // ── Search Bar ────────────────────────────────────────────────────
          GestureDetector(
            onTap: () {
              if (!ctrl.isSearchActive.value) _openSearch(ctrl);
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(18),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 24, sigmaY: 24),
                child: Container(
                  height: 52,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.88),
                    borderRadius: BorderRadius.circular(18),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.10),
                        blurRadius: 20,
                        offset: const Offset(0, 6),
                      ),
                    ],
                    border: Border.all(
                      color: VoyentaColors.outlineVariant.withValues(alpha: 0.2),
                    ),
                  ),
                  child: Row(
                    children: [
                      const SizedBox(width: 14),
                      // Search icon
                      Obx(() => ctrl.isSearchLoading.value
                          ? SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                    VoyentaColors.primary),
                              ),
                            )
                          : const Icon(Icons.search_rounded,
                              color: VoyentaColors.primary, size: 22)),
                      const SizedBox(width: 10),

                      // Text field
                      Expanded(
                        child: Obx(() => ctrl.isSearchActive.value
                            ? TextField(
                                controller: _textCtrl,
                                focusNode: _focusNode,
                                onChanged: ctrl.onSearchChanged,
                                style: VoyentaTypography.bodyMd.copyWith(
                                  color: VoyentaColors.onSurface,
                                  fontSize: 15,
                                ),
                                decoration: InputDecoration(
                                  hintText: 'Search places, cities...',
                                  hintStyle: VoyentaTypography.bodyMd.copyWith(
                                    color: VoyentaColors.onSurfaceVariant
                                        .withValues(alpha: 0.6),
                                    fontSize: 15,
                                  ),
                                  border: InputBorder.none,
                                  isDense: true,
                                ),
                                textInputAction: TextInputAction.search,
                              )
                            : Obx(() => Text(
                                  ctrl.searchQuery.value.isEmpty
                                      ? 'Search places, cities...'
                                      : ctrl.searchQuery.value,
                                  style: VoyentaTypography.bodyMd.copyWith(
                                    color: ctrl.searchQuery.value.isEmpty
                                        ? VoyentaColors.onSurfaceVariant
                                            .withValues(alpha: 0.6)
                                        : VoyentaColors.onSurface,
                                    fontSize: 15,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ))),
                      ),

                      // Clear / Close button
                      Obx(() => ctrl.isSearchActive.value
                          ? GestureDetector(
                              onTap: () => _closeSearch(ctrl),
                              child: Container(
                                padding: const EdgeInsets.all(8),
                                child: const Icon(Icons.close_rounded,
                                    color: VoyentaColors.onSurfaceVariant, size: 20),
                              ),
                            )
                          : ctrl.searchQuery.value.isNotEmpty
                              ? GestureDetector(
                                  onTap: () {
                                    _textCtrl.clear();
                                    ctrl.deactivateSearch();
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(8),
                                    child: const Icon(Icons.close_rounded,
                                        color: VoyentaColors.onSurfaceVariant,
                                        size: 18),
                                  ),
                                )
                              : const SizedBox(width: 14)),
                    ],
                  ),
                ),
              ),
            ),
          ),

          const SizedBox(height: 8),

          // ── Autocomplete Suggestions Dropdown ─────────────────────────────
          Obx(() {
            if (ctrl.suggestions.isEmpty) return const SizedBox.shrink();
            return ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.95),
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.10),
                        blurRadius: 20,
                        offset: const Offset(0, 8),
                      ),
                    ],
                    border: Border.all(
                      color: VoyentaColors.outlineVariant.withValues(alpha: 0.15),
                    ),
                  ),
                  child: ListView.separated(
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: ctrl.suggestions.length > 5
                        ? 5
                        : ctrl.suggestions.length,
                    separatorBuilder: (_, __) => Divider(
                      height: 1,
                      color: VoyentaColors.outlineVariant.withValues(alpha: 0.15),
                      indent: 48,
                    ),
                    itemBuilder: (context, index) {
                      final suggestion = ctrl.suggestions[index];
                      final desc = suggestion['description'] ?? '';
                      final lat = suggestion['lat'] ?? '0';
                      final lon = suggestion['lon'] ?? '0';

                      // Split display name into main + secondary
                      final parts = desc.split(',');
                      final main = parts[0].trim();
                      final secondary =
                          parts.length > 1 ? parts.sublist(1).join(',').trim() : '';

                      return InkWell(
                        onTap: () {
                          _textCtrl.text = main;
                          ctrl.selectSuggestion(desc, lat, lon);
                        },
                        borderRadius: BorderRadius.circular(12),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 14, vertical: 11),
                          child: Row(
                            children: [
                              Container(
                                width: 32,
                                height: 32,
                                decoration: BoxDecoration(
                                  color: VoyentaColors.primary
                                      .withValues(alpha: 0.08),
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.place_rounded,
                                  color: VoyentaColors.primary,
                                  size: 16,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      main,
                                      style: VoyentaTypography.bodyMd.copyWith(
                                        color: VoyentaColors.onSurface,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    if (secondary.isNotEmpty) ...[
                                      const SizedBox(height: 2),
                                      Text(
                                        secondary,
                                        style: VoyentaTypography.bodyMd.copyWith(
                                          color: VoyentaColors.onSurfaceVariant,
                                          fontSize: 12,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ],
                                ),
                              ),
                              const Icon(
                                Icons.north_west_rounded,
                                size: 14,
                                color: VoyentaColors.onSurfaceVariant,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}
