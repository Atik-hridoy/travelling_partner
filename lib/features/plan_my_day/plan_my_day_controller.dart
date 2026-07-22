import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PlanMyDayItem {
  final String id;
  final String timeTag;
  final String distance;
  final String title;
  final String description;
  final String novaInsight;
  final IconData icon;
  final String imageUrl;

  PlanMyDayItem({
    required this.id,
    required this.timeTag,
    required this.distance,
    required this.title,
    required this.description,
    required this.novaInsight,
    required this.icon,
    required this.imageUrl,
  });
}

class PlanMyDayController extends GetxController {
  var activeNodeIndex = 0.obs;

  final itineraryItems = <PlanMyDayItem>[
    PlanMyDayItem(
      id: '1',
      timeTag: '08:30 AM — MORNING',
      distance: '3.2 miles away',
      title: 'Coffee at The Mill',
      description: 'Experience brutalist-inspired architecture while enjoying the city\'s finest artisanal toast and small-batch coffee.',
      novaInsight: 'Best light for photography of the raw concrete textures is before 9 AM.',
      icon: Icons.local_cafe_rounded,
      imageUrl: 'https://images.unsplash.com/photo-1501339847302-ac426a4a7cbb?w=800',
    ),
    PlanMyDayItem(
      id: '2',
      timeTag: '10:30 AM — LATE MORNING',
      distance: '1.5 miles away',
      title: 'SFMOMA Architecture Tour',
      description: 'A curated walk through the Snøhetta-designed expansion, focusing on its rippling facade and sculptural stairways.',
      novaInsight: 'Nova Insight: Head straight to the 7th floor terrace for an unobstructed view of the skyline geometry.',
      icon: Icons.architecture_rounded,
      imageUrl: 'https://images.unsplash.com/photo-1513694203232-719a280e022f?w=800',
    ),
    PlanMyDayItem(
      id: '3',
      timeTag: '01:00 PM — LUNCH',
      distance: '0.8 miles away',
      title: 'Waterfront Sourdough',
      description: 'Enjoy a quiet moment by the Embarcadero with world-famous sourdough at a lesser-known, design-forward bistro.',
      novaInsight: 'The corner table by the window is usually free around 1:15 PM.',
      icon: Icons.restaurant_rounded,
      imageUrl: 'https://images.unsplash.com/photo-1555396273-367ea4eb4db5?w=800',
    ),
    PlanMyDayItem(
      id: '4',
      timeTag: '03:30 PM — AFTERNOON',
      distance: '4.1 miles away',
      title: '15th Avenue Steps',
      description: 'A serene escape into one of the city\'s best-kept secrets—a mosaic-tiled staircase nestled in a lush vertical garden.',
      novaInsight: 'Best light for photography at 4 PM when the shadows accentuate the mosaic tiles.',
      icon: Icons.filter_vintage_rounded,
      imageUrl: 'https://images.unsplash.com/photo-1506146332389-18140dc7b2fb?w=800',
    ),
    PlanMyDayItem(
      id: '5',
      timeTag: '06:45 PM — EVENING',
      distance: '2.9 miles away',
      title: 'Presidio Sunset',
      description: 'End your day at a secluded viewpoint overlooking the Golden Gate Bridge, far from the typical tourist crowds.',
      novaInsight: 'I\'ve selected this spot specifically for its minimalist framing of the bridge.',
      icon: Icons.wb_twilight_rounded,
      imageUrl: 'https://images.unsplash.com/photo-1449034446853-66c86144b0ad?w=800',
    ),
  ].obs;

  void setActiveNode(int index) {
    activeNodeIndex.value = index;
  }
}
