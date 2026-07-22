import 'package:flutter/material.dart';
import '../../../core/theme/colors.dart';
import '../../../core/theme/typography.dart';

class TripAiTab extends StatelessWidget {
  const TripAiTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.9,
      decoration: const BoxDecoration(
        color: VoyentaColors.background,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        children: [
          // Drag handle
          Container(
            margin: const EdgeInsets.only(top: 12, bottom: 8),
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: VoyentaColors.outlineVariant,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          // Title
          Text('Nova AI', style: VoyentaTypography.headlineMd.copyWith(color: VoyentaColors.primary)),
          const SizedBox(height: 16),
          // Content
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildChatHistory(),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
          // Sticky Input at the bottom
          Padding(
            padding: EdgeInsets.only(
              left: 20, 
              right: 20, 
              bottom: MediaQuery.of(context).viewInsets.bottom + 20, // Handle keyboard
            ),
            child: _buildInteractionArea(),
          ),
        ],
      ),
    );
  }

  Widget _buildChatHistory() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildAiMessage(
          message: 'I\'ve optimized your schedule for the rain. Should I book a taxi to Shisendo Temple?',
          time: 'JUST NOW',
          highlight: 'Shisendo Temple',
        ),
        const SizedBox(height: 24),
        _buildUserMessage(
          message: 'Yes, that sounds perfect. Check for the shortest route.',
          time: 'SENT',
        ),
        const SizedBox(height: 24),
        _buildAiTyping(),
      ],
    );
  }

  Widget _buildAiMessage({required String message, required String time, String? highlight}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildAiAvatar(),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                decoration: BoxDecoration(
                  color: VoyentaColors.surfaceBright.withOpacity(0.9),
                  border: Border.all(color: VoyentaColors.primary.withOpacity(0.1)),
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(24),
                    bottomLeft: Radius.circular(24),
                    bottomRight: Radius.circular(24),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.02),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: _buildRichText(message, highlight),
              ),
              const SizedBox(height: 4),
              Padding(
                padding: const EdgeInsets.only(left: 4),
                child: Text(
                  time,
                  style: VoyentaTypography.labelCaps.copyWith(
                    color: VoyentaColors.outline,
                    fontSize: 10,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 48), // Padding on the right
      ],
    );
  }

  Widget _buildRichText(String message, String? highlight) {
    if (highlight == null || !message.contains(highlight)) {
      return Text(
        message,
        style: VoyentaTypography.bodyMd.copyWith(color: VoyentaColors.onSurfaceVariant),
      );
    }

    final parts = message.split(highlight);
    return RichText(
      text: TextSpan(
        style: VoyentaTypography.bodyMd.copyWith(color: VoyentaColors.onSurfaceVariant),
        children: [
          TextSpan(text: parts[0]),
          TextSpan(
            text: highlight,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: VoyentaColors.primary,
            ),
          ),
          if (parts.length > 1) TextSpan(text: parts[1]),
        ],
      ),
    );
  }

  Widget _buildUserMessage({required String message, required String time}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        const SizedBox(width: 48), // Padding on the left
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [VoyentaColors.primaryContainer, VoyentaColors.primary],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(24),
                    bottomLeft: Radius.circular(24),
                    bottomRight: Radius.circular(24),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 8,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Text(
                  message,
                  style: VoyentaTypography.bodyMd.copyWith(color: Colors.white),
                ),
              ),
              const SizedBox(height: 4),
              Padding(
                padding: const EdgeInsets.only(right: 4),
                child: Text(
                  time,
                  style: VoyentaTypography.labelCaps.copyWith(
                    color: VoyentaColors.outline,
                    fontSize: 10,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 16),
        _buildUserAvatar(),
      ],
    );
  }

  Widget _buildAiTyping() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildAiAvatar(),
        const SizedBox(width: 16),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          decoration: BoxDecoration(
            color: VoyentaColors.surfaceBright.withOpacity(0.9),
            border: Border.all(color: VoyentaColors.primary.withOpacity(0.1)),
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(24),
              bottomLeft: Radius.circular(24),
              bottomRight: Radius.circular(24),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildTypingDot(0),
              const SizedBox(width: 4),
              _buildTypingDot(1),
              const SizedBox(width: 4),
              _buildTypingDot(2),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTypingDot(int index) {
    // In a real app, this would use an AnimationController
    return Container(
      width: 6,
      height: 6,
      decoration: const BoxDecoration(
        color: VoyentaColors.primary,
        shape: BoxShape.circle,
      ),
    );
  }

  Widget _buildAiAvatar() {
    return Container(
      width: 40,
      height: 40,
      decoration: const BoxDecoration(
        color: VoyentaColors.primary,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: const Icon(
        Icons.smart_toy,
        color: Colors.white,
        size: 20,
      ),
    );
  }

  Widget _buildUserAvatar() {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: VoyentaColors.surfaceContainerHighest,
        shape: BoxShape.circle,
        border: Border.all(color: VoyentaColors.outlineVariant.withOpacity(0.2)),
        image: const DecorationImage(
          image: NetworkImage(
            'https://lh3.googleusercontent.com/aida-public/AB6AXuCCSH9dw2B4_kl-THqyaZP0yCRStj0pL-R-1Q-jzbDvkvpzRjKG5RPSDHsxI5mYUZomLOGAXunnXh0R0sghc3UdDSoXq2lb1JEj9Mm5ywq3muwmGeUnc8Y2H5v4u-hGv0qblTUJMwJiGcX1L-b6qTTwcjbHqL_a169Xkh5mrWynOZJG9pp_DSs262gCJOpnonyccobCv21Z6SiGGGP2KePSQZ16olXTem0EQzBP78i05gYZE4ZxBfY7FdXwSGp3n7EQHSFP74xhFMhE',
          ),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildInteractionArea() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildSuggestedPrompts(),
        const SizedBox(height: 16),
        _buildInputBar(),
      ],
    );
  }

  Widget _buildSuggestedPrompts() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          _buildPromptChip(Icons.calendar_today, 'Plan today'),
          const SizedBox(width: 12),
          _buildPromptChip(Icons.explore, 'Find hidden gems'),
          const SizedBox(width: 12),
          _buildPromptChip(Icons.translate, 'Translate menu'),
          const SizedBox(width: 12),
          _buildPromptChip(Icons.restaurant, 'Table for two'),
        ],
      ),
    );
  }

  Widget _buildPromptChip(IconData icon, String label) {
    return InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(24),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: VoyentaColors.surfaceContainerLow,
          border: Border.all(color: VoyentaColors.outlineVariant.withOpacity(0.3)),
          borderRadius: BorderRadius.circular(24),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 18, color: VoyentaColors.onSurfaceVariant),
            const SizedBox(width: 8),
            Text(
              label,
              style: VoyentaTypography.labelCaps.copyWith(
                color: VoyentaColors.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInputBar() {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: VoyentaColors.surfaceBright.withOpacity(0.8),
        borderRadius: BorderRadius.circular(32),
        border: Border.all(color: VoyentaColors.outlineVariant.withOpacity(0.4)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.image, color: VoyentaColors.onSurfaceVariant),
            onPressed: () {},
          ),
          const SizedBox(width: 4),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Ask Nova anything...',
                hintStyle: VoyentaTypography.bodyMd.copyWith(color: VoyentaColors.outline),
                border: InputBorder.none,
                isDense: true,
                contentPadding: EdgeInsets.zero,
              ),
              style: VoyentaTypography.bodyMd.copyWith(color: VoyentaColors.onSurface),
            ),
          ),
          const SizedBox(width: 4),
          IconButton(
            icon: const Icon(Icons.mic, color: VoyentaColors.onSurfaceVariant),
            onPressed: () {},
          ),
          Container(
            decoration: const BoxDecoration(
              color: VoyentaColors.primary,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 8,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: IconButton(
              icon: const Icon(Icons.arrow_upward, color: Colors.white),
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }
}
