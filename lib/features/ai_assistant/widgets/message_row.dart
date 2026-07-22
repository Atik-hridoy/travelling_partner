import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../core/theme/colors.dart';
import '../../../core/theme/typography.dart';
import '../ai_assistant_controller.dart';

class MessageRow extends StatelessWidget {
  final MessageModel message;

  const MessageRow({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    final isUser = message.isUser;
    final align = isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start;

    return Padding(
      padding: const EdgeInsets.only(bottom: 24.0),
      child: Column(
        crossAxisAlignment: align,
        children: [
          // Header identity for AI response
          if (!isUser) ...[
            Row(
              children: [
                Container(
                  width: 24,
                  height: 24,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: VoyentaColors.voyagerGradient,
                  ),
                  child: const Icon(Icons.auto_awesome, color: Colors.white, size: 12),
                ),
                const SizedBox(width: 8),
                Text(
                  'THE INVISIBLE CONCIERGE',
                  style: VoyentaTypography.labelCaps.copyWith(
                    color: VoyentaColors.onSurfaceVariant.withOpacity(0.7),
                    fontSize: 9,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
          ],

          Row(
            mainAxisAlignment: isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    gradient: isUser ? VoyentaColors.voyagerGradient : null,
                    color: isUser ? null : Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: const Radius.circular(20),
                      topRight: const Radius.circular(20),
                      bottomLeft: Radius.circular(isUser ? 20 : 4),
                      bottomRight: Radius.circular(isUser ? 4 : 20),
                    ),
                    border: isUser
                        ? null
                        : Border.all(color: VoyentaColors.outlineVariant.withOpacity(0.3)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.02),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Render Title if available (for AI responses)
                      if (message.title != null) ...[
                        Text(
                          message.title!,
                          style: VoyentaTypography.headlineMd.copyWith(
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                            color: VoyentaColors.primary,
                          ),
                        ),
                        const SizedBox(height: 8),
                      ],
                      Text(
                        message.text,
                        style: VoyentaTypography.bodyMd.copyWith(
                          fontSize: 13,
                          height: 1.45,
                          color: isUser ? Colors.white : VoyentaColors.onSurface,
                        ),
                      ),
                      // Render Timeline Stops if available
                      if (message.timelineStops != null) ...[
                        const SizedBox(height: 16),
                        _buildTimelineSpine(message.timelineStops!),
                      ],
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            DateFormat('hh:mm a').format(message.time),
            style: VoyentaTypography.monoTechnical.copyWith(
              fontSize: 9,
              color: VoyentaColors.onSurfaceVariant.withOpacity(0.5),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimelineSpine(List<TimelineStop> stops) {
    return Column(
      children: stops.map((stop) {
        return IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Icon & Spine
              Column(
                children: [
                  Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      border: Border.all(color: VoyentaColors.outlineVariant.withOpacity(0.5)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.04),
                          blurRadius: 4,
                        ),
                      ],
                    ),
                    child: Icon(stop.icon, color: VoyentaColors.primary, size: 16),
                  ),
                  Expanded(
                    child: Container(
                      width: 1.5,
                      color: VoyentaColors.outlineVariant.withOpacity(0.4),
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 12),
              // Content Card
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${stop.time} • ${stop.category}',
                                style: VoyentaTypography.labelCaps.copyWith(
                                  color: VoyentaColors.primary,
                                  fontSize: 8,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                stop.title,
                                style: VoyentaTypography.bodyMd.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: VoyentaColors.onSurface,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                          if (stop.rating != null)
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                              decoration: BoxDecoration(
                                color: VoyentaColors.tertiaryContainer.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                children: [
                                  const Icon(Icons.star, color: VoyentaColors.tertiary, size: 10),
                                  const SizedBox(width: 2),
                                  Text(
                                    stop.rating!,
                                    style: VoyentaTypography.labelCaps.copyWith(
                                      color: VoyentaColors.tertiary,
                                      fontSize: 8,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      // Horizontal Card layout matching Stitch
                      Container(
                        decoration: BoxDecoration(
                          color: VoyentaColors.surfaceContainerLow,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: stop.rating != null
                                ? VoyentaColors.tertiaryContainer.withOpacity(0.3)
                                : VoyentaColors.outlineVariant.withOpacity(0.2),
                          ),
                        ),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(16),
                                bottomLeft: Radius.circular(16),
                              ),
                              child: Image.network(
                                stop.imgUrl,
                                width: 72,
                                height: 72,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(right: 12.0),
                                child: Text(
                                  stop.desc,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: VoyentaTypography.bodyMd.copyWith(
                                    fontSize: 11,
                                    color: VoyentaColors.onSurfaceVariant,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}
