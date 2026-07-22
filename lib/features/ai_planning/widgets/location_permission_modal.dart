import 'dart:ui';
import 'package:flutter/material.dart';
import '../../../core/theme/colors.dart';
import '../../../core/theme/typography.dart';

class LocationPermissionModal extends StatelessWidget {
  final VoidCallback onAllow;
  final VoidCallback onDecline;

  const LocationPermissionModal({
    super.key,
    required this.onAllow,
    required this.onDecline,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.fromLTRB(24, 16, 24, 32),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.8),
            border: Border(top: BorderSide(color: Colors.white.withValues(alpha: 0.5))),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Handle
              Container(
                width: 48,
                height: 6,
                margin: const EdgeInsets.only(bottom: 24),
                decoration: BoxDecoration(
                  color: VoyentaColors.outlineVariant.withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
              
              // Icon Header
              Container(
                width: 80,
                height: 80,
                margin: const EdgeInsets.only(bottom: 24),
                decoration: BoxDecoration(
                  color: VoyentaColors.primaryFixed,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: VoyentaColors.primary.withValues(alpha: 0.1),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.my_location,
                  size: 40,
                  color: VoyentaColors.primary,
                ),
              ),
              
              // Content
              Text(
                'Allow Location Access?',
                style: VoyentaTypography.headlineMd.copyWith(
                  fontWeight: FontWeight.bold,
                  color: VoyentaColors.onSurface,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'Voyanta uses your location to estimate travel costs, transportation options and better recommendations.',
                textAlign: TextAlign.center,
                style: VoyentaTypography.bodyMd.copyWith(
                  color: VoyentaColors.onSurfaceVariant,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 24),
              
              // Map Mockup Clip
              Container(
                width: double.infinity,
                height: 120,
                margin: const EdgeInsets.only(bottom: 24),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: VoyentaColors.outlineVariant.withValues(alpha: 0.2)),
                  image: const DecorationImage(
                    image: NetworkImage('https://lh3.googleusercontent.com/aida-public/AB6AXuATiGVP0xLB5GhhlmTC87OEVUmGgQxc0bbbCnhX-l7jujZ04eI4QQ-BM31YOxIOD5hcbJrAX-S413mMrv13A8DS_bHt6JJe60yq6l29WHHiGBcWagf7SW5tOmSI9wctCB0Cl19-uReFQPWYz_-qfr64xGLQmN39a4yoYQIGiNUVplgNfwxX0v8aS2075ZAPtLoCK-hP4oQq1LZ0HBuze65TMR1ePdbpckOSQq6H3_YnxJYZsFUj0uSEmoND9q_8HugdPV8p3cq_auzm'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [
                            VoyentaColors.surface.withValues(alpha: 0.8),
                            Colors.transparent,
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 12.0),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: VoyentaColors.primary,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: VoyentaColors.primary.withValues(alpha: 0.3),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(Icons.near_me, color: Colors.white, size: 14),
                              const SizedBox(width: 4),
                              Text(
                                'PRECISE GPS',
                                style: VoyentaTypography.labelSm.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1.2,
                                  fontSize: 10,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              
              // Actions
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: onAllow,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: VoyentaColors.primary,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
                    elevation: 8,
                    shadowColor: VoyentaColors.primary.withValues(alpha: 0.4),
                  ),
                  child: Text('Allow', style: VoyentaTypography.titleMd.copyWith(color: Colors.white, fontWeight: FontWeight.bold)),
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                height: 56,
                child: OutlinedButton(
                  onPressed: onDecline,
                  style: OutlinedButton.styleFrom(
                    foregroundColor: VoyentaColors.primary,
                    side: BorderSide(color: VoyentaColors.primary.withValues(alpha: 0.2)),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
                  ),
                  child: Text('Not Now', style: VoyentaTypography.titleMd.copyWith(fontWeight: FontWeight.w600)),
                ),
              ),
              
              const SizedBox(height: 24),
              Text(
                'PRIVACY SECURED BY NOVA',
                style: VoyentaTypography.labelSm.copyWith(
                  color: VoyentaColors.outline,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.5,
                  fontSize: 10,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
