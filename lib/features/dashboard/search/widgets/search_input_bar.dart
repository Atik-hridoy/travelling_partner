import 'package:flutter/material.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/typography.dart';

class SearchInputBar extends StatelessWidget {
  const SearchInputBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
      child: Container(
        height: 60,
        decoration: BoxDecoration(
          color: VoyentaColors.surfaceContainerLow,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.02),
              blurRadius: 8,
            ),
          ],
        ),
        padding: const EdgeInsets.only(left: 20.0, right: 6.0),
        child: Row(
          children: [
            const Icon(Icons.search, color: VoyentaColors.outline, size: 22),
            const SizedBox(width: 12),
            const Expanded(
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Where would you like to go?',
                  border: InputBorder.none,
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 15,
                  ),
                ),
                style: TextStyle(
                  color: VoyentaColors.onSurface,
                  fontSize: 15,
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                // Perform Search
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                  color: VoyentaColors.primary,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  'SEARCH',
                  style: VoyentaTypography.labelCaps.copyWith(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
