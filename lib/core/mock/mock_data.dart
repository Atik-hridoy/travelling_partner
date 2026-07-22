import 'package:flutter/material.dart';
import '../theme/colors.dart';
import '../../features/ai_assistant/ai_assistant_controller.dart'; // Needed for TimelineStop & MessageModel types

class MockData {
  // 1. Onboarding Interests List
  static final List<Map<String, dynamic>> onboardingInterests = [
    {'name': 'Adventure', 'icon': Icons.hiking, 'desc': 'Thrill and exploration'},
    {'name': 'Nature', 'icon': Icons.forest, 'desc': 'Scenic landscapes'},
    {'name': 'Food', 'icon': Icons.restaurant, 'desc': 'Local delicacies'},
    {'name': 'Luxury', 'icon': Icons.diamond, 'desc': 'Refined experiences'},
    {'name': 'Solo', 'icon': Icons.person, 'desc': 'Self-discovery'},
    {'name': 'Family', 'icon': Icons.family_restroom, 'desc': 'Bonding moments'},
    {'name': 'Photography', 'icon': Icons.photo_camera, 'desc': 'Visual memories'},
    {'name': 'Wellness', 'icon': Icons.spa, 'desc': 'Rejuvenation & health'},
  ];

  // 2. Home Dashboard Trending Spots
  static final List<Map<String, String>> trendingSpots = [
    {
      'title': 'Oia Santorini',
      'sub': 'Greece • Luxury Stay',
      'rate': '4.9',
      'match': '98%',
      'img': 'https://lh3.googleusercontent.com/aida-public/AB6AXuAn84kIvGSvY33N9jt4TW9EtKS96yGs7jxLmLJEBeDme5lHx7u2ySLHTaQvTzJH-9HX_i6P0ZPweiyMnU5cF7qlV0xEyT2OfnprdiDj75hvKO_guEcs0Ox9_oPCs7yq-G4-d4XHCC-1t58uUR_D243p4XwIny4a0fBMrKf7M4n3Y2tpdY6wQkJCuL-Q90WwDkDUPnvLzVOXTsYXFez8P6p6XXWJGlqUiuIEf2_gQ5vVhUUEtbGRdIEKBHSBeNk41La8JAMgmTy5NQeb'
    },
    {
      'title': 'Memory Lane',
      'sub': 'Tokyo • Night Life',
      'rate': '4.8',
      'match': '94%',
      'img': 'https://lh3.googleusercontent.com/aida-public/AB6AXuAADr3TmFHWe-GTu-S233SBurfxsAoUphogegl8Ck3cwJd09Xs0WPUrHmr3J6UiSmcFZQlfJXgOqfDMtVo8jj7fg8Kif1XC-mzU-lGIGWRtqo-BmxbdUKHmsgE8ch11KE5T_DUoJD5GSug3W2LJWUXphcSW3x7WjhfdXVB0GpWKxG5fXpsGD_GVbBb3eEMhQDz9Za5LvEOapP5lMjTszeA5s5O3GhWDmWAR-PvMAzyAvt7uxMawPqJwp-FZgfhiyuHqWa-cn9xX15zP'
    },
    {
      'title': 'Lofoten Cabin',
      'sub': 'Norway • Nature',
      'rate': '5.0',
      'match': '96%',
      'img': 'https://lh3.googleusercontent.com/aida-public/AB6AXuBoXf-424ZTD2IEbmv2PYdMWr9wEKBBKICJLBJshjm48TvfAi4VL2b7jYDkSSRlgM5foI_kahkkIoWjAcxF_BI90rp3UdUESJun6V579_n6Qs6KGcCgNnJ6_a6gMTtjn40leK13W167gGIeEJUFabLKfkZJUU8ovkatqzdkjjTyHUk0WPbG5feoKdHO7pmVcwAfT8xUdq_GX6qAxNM9qsrEzpZlVknVcXK2Ekh-F62e1dfrtHo-vYLjadWDlKp2crpf67fGq-6R5bVI'
    }
  ];

  // 3. Map Experience Filter Pills
  static final List<Map<String, dynamic>> mapFilterPills = [
    {'label': 'All Gems', 'icon': Icons.diamond},
    {'label': 'Dining', 'icon': Icons.restaurant},
    {'label': 'Landmarks', 'icon': Icons.museum},
    {'label': 'Wellness', 'icon': Icons.spa},
  ];

  // 4. Map Experience Nearby Places
  static final List<Map<String, dynamic>> mapNearbyPlaces = [
    {
      'title': 'The Ferry Building',
      'dist': '0.4 miles away',
      'match': '98% Match',
      'icon': Icons.auto_awesome,
      'tags': ['Food Hall', 'Historical'],
    },
    {
      'title': 'Transamerica Pyramid',
      'dist': '0.8 miles away',
      'match': '94% Match',
      'icon': Icons.auto_awesome,
      'tags': ['Landmark', 'Design'],
    },
    {
      'title': 'Coit Tower',
      'dist': '1.2 miles away',
      'match': '89% Match',
      'icon': Icons.auto_awesome,
      'tags': ['Views', 'Outdoor'],
    },
  ];

  // 5. Community Live Stories
  static final List<Map<String, String>> communityStories = [
    {
      'user': '@elena_voyage',
      'title': 'Golden hour in Positano\'s hidden villa',
      'img': 'https://lh3.googleusercontent.com/aida-public/AB6AXuCk49kHcGi7wakefM6dRRCla3eoDvOpyU2ytuVB_D-hUA-Qjx75cUsLb6LEjv3MJyjBJ3OVBNDVES_C4OaLaVc_eOGUDqDmGjhALtevHOuf-bygRULQAp7xPnfohhdhLs5AxYYLKi1vhSBASNLKe3OgT8zd0OqrL1ATsWpOk9CldRgHZDdYlbBP7NYVLOglT7JbshteITkCr1rD67Ws-FVd7k1BrVA4mXe_38-58lXwuIWXp1eBHCVW1DnfXW79I6rCneqtjW2rbh5z',
      'userAvatar': 'https://lh3.googleusercontent.com/aida-public/AB6AXuA151LPY8Ih-x7reZHOnWDqnExiaSvifxqHf929OweOktNxO4HFUnS_qBmcEN3elUYdsDV4gleIjlRZaU9EY69PwoAh1XymGjyrCwXLaQ1D-C3xL-urWvhdA7LJhZ-dSpwsD4V8M3P8IT-RJBZ4C5Wlwx7WRR8aDiFsY912Jnc7AMqwxTUMjHprFA4JIelUVMpEc4iYXNAldc_dXZ4DTuzB83LwTwbFNqnol95IaEBBrYmvVdeBDq5vFtP7Lhy4-JPw2i2KJmT9mfqd',
      'isLive': 'true',
    },
    {
      'user': '@kenji_tokyo',
      'title': 'Late night ramen: The local\'s secret spot',
      'img': 'https://lh3.googleusercontent.com/aida-public/AB6AXuCilFjjDtynQe3GyeoP2fGm7tHJZs-A6i1PcHnsXXYaFoG39Ap8nfxwlZ7ncXxrbc-odrW4F2M6eLZTNOJfPC-QuIY6Xuh3t4tQPVR_0AO36L0SKVTCVq4LbKHNhD45Z0vXWDyw5uWssqX_DFGfAFyE05kmV9y6QztQPctdJzAQVT5OzK6O9BMZFJVJk2uIQKOr3xkN1doSIQhbZgVO1YEAAOw_Voi9qA17kYRuFu_mBuHjW9PXSH0w6i9C-wxcO3-hEwha4XCSiIGO',
      'userAvatar': 'https://lh3.googleusercontent.com/aida-public/AB6AXuBa_fCganULibwRpOXGcU93TtDvNAwkAXtVHW06bZOpsfK85VcZGpuxDN3pFt1hl5yRznYdDTi98YbKIQM_48Q6kd5_RDgnEjxzboHHbn9agak3I4Twrnlp3lpt6tV-eUQOG7T3pQsESRqomGMl01fAHa1wRFx_YaJr9Z-c82ptrc-O8KpkmcstRb35Y8M2Li5_lYCvc6zjz5VHv3rAekdWbXK0up-M3nDpWTgO6CW15vucvpxUWV6BA-ZmuaTMxZXLS15aO9FklUSG',
      'isLive': 'false',
    },
    {
      'user': '@alpine_escape',
      'title': 'Waking up above the clouds in Zermatt',
      'img': 'https://lh3.googleusercontent.com/aida-public/AB6AXuCslDuf9dfpEBHx4uVmBLDO8igB8x3L9IhxWfb-gmtXzr51wDeOFveCbS6kiG_T__r0mohzTzKt8XxpFQeXwQOJhl1CA8awe1LpzB1YcagYi1sajZVWjFSOryEodq4LkSyBeoS27r2PxqJejQznWYyCMxvgNjONmoht3qFG9kBus3QQI62qRJC82ayOne4zSAoInrBAOdiwBqT0Z97xj3bAFkcY0K0kQiprjtscKnFL0k3JB8GQmAHBluUjh3gLckXjQrTZc6MgzLsG',
      'userAvatar': 'https://lh3.googleusercontent.com/aida-public/AB6AXuCLFU1Igc8maK-COFsKeI56ZaxW2gkAHwibNZKWW6GRbJnenBceKg_Cb2MI6z6NFd8pd5rXQeNstOnEWpRj-NNcPgtCqT-NRpk_FYQxEHt6uiGTC1OGfrTz6bg6SQ9JIBPH3AzFtboMwCiS-E0E109-3ucQ7PalCeJpfrKRpaHSyXaGv_xLmom4Tti_WBptPkK_mDlTLD-Zt4l17eK4FRe4WXV3QI2-KG1qks_LMe0rPu8JvCr5wiOyNvqHP_8gnuztKrFYYCg3-dKJ',
      'isLive': 'false',
    },
    {
      'user': '@yassin_guide',
      'title': 'The true scent of the Medina',
      'img': 'https://lh3.googleusercontent.com/aida-public/AB6AXuCV7lLx8kpu9OzoD3kTjCfAs95JLLfU5NrL1FyZ19UgA_UOK12M0rsgGpTfb9Pw3gvBvmvVrvO4L6NSJx70L8wisZpaHc4hvHH_7Wzh8QNfoNPc0-6JzvEys6YsOp5b8CKh8H6MpyXqNSSdcRxop7aD-znqcbWBGx3oyaHnY9wMJY7pONPenPbBsk__Qw0zSoYgE9n4nSQXkrhPsctLM9P0AlMnIp8IkiR4r0Bi6Nr_6X4EBL6EAxuxZ56-Acp_oJ1qx-PSbq3pDj3u',
      'userAvatar': 'https://lh3.googleusercontent.com/aida-public/AB6AXuDyAWx1fQ9KOkW3iqvvoZ5ROiE38a7cxmO1FRm757KKH1sqlVfp2w75Q47KtANhfRt7EXLp9z2U-asJvmAXaUEKYn_JXH_E3JmSkYTyo-ouBYdtO_dWoHSOuGvdjYZD4bhSROZc9BoALJNBDHLd_HdDd6x97dR_5CHoDirs2HF74Witnk75ohGXvz2g0fGcnjpkkK4Y1x2MnqWr_bWh4uDQp_Osq8TBHwTi14XMfid79XODb8Ub5BUH5Li59cTNwbYmMy5yc92iWxwa',
      'isLive': 'false',
    },
    {
      'user': '@nordic_design',
      'title': 'Hygge & Highballs: Copenhagen Nights',
      'img': 'https://lh3.googleusercontent.com/aida-public/AB6AXuDeIHoya6YeU1kBuip04ZHgN29Tv7l-TuDjKoZUttYrq9LXDrcK4Jn0s30eA0XXCjVG2_KWw_iY8BjcQO6fSl8Z9onpYVzFab3MmdHtmd5d5R39MTLxVDI7_X2qVgFfeeVHODDnMqShG-6eSKbw3xnpDXgX6o3Mb3SL-pW7b2oxbkCCYBKc_J4zOE2sjfijkK3CFkN6RMD2tsxq-y_9rb2VQjSQ9_jczk_lQapYCmbaPnM2eRYb0z_6Xn8OTiMBvSIRIrfho2m4c-kx',
      'userAvatar': 'https://lh3.googleusercontent.com/aida-public/AB6AXuDNVoFDs3W9GPsWTi-Sq39haYDnXkLIpkghxjbCsz-RoWDZvejFgKlfyzKpLyB1spQp7HKMEx6XEKD6xJIbeKK4WIi-fGhk488aANJaGcqskcDFfx3N_Xfuau27PNhJrXDMBpPvdOr_s_0ZhYi15kobjOYpA95cpG_IZC6x3CPIpmQTZXCI3-JOoPxLO7a02O1WF68oXLUOy4j1tAxpr2YtFTxk-cRecejZWQUEeUL_4UQ6WDA1QwM-4TYgp42BC2Rg9dOWyR-fjC9d',
      'isLive': 'false',
    }
  ];

  // 5b. Community Insider Access Hidden Gems
  static final Map<String, dynamic> largeHiddenGem = {
    'title': "Sardinia's Hidden 'Cala Luna' Cave",
    'rating': '4.9',
    'reviewsCount': '124 local reviews',
    'desc': 'Only accessible by boat or a 3-hour hike, this limestone cavern offers a natural skylight and the clearest water in the Mediterranean. Best visited at 10 AM before the tide rises.',
    'img': 'https://lh3.googleusercontent.com/aida-public/AB6AXuDvWhr0Jk5SWLk5dQxAzYtdoO-XNcomAsPGFJN8mJchVrj2Iu8Hhx_NKddvyWnBO0dDUqGoV_VAgjyqkmJT7a-SuPS6et-7hf8WfleX-w8jvxNPaZ88MIlxFd_o2Fp1DWRPIzqnYrbxQ2ziIZtrIG3Rrp3n1ij3OaJ_hk8rA6ZF8p8fyICS4iYkrBj878NgVy2TGCOz49JrF9yLMKum1hMtbKDyXfBn-It0pgQmG7R2tp6X5Obs-A_1vVQkZMJQqeygGaS3onul-xE1',
    'pills': ['Quiet Hours', 'Boat Access', 'Picnic Spot'],
  };

  static final List<Map<String, String>> smallHiddenGems = [
    {
      'location': 'PARIS, FRANCE',
      'title': 'Galerie de l\'Ombre',
      'desc': 'A private museum hidden in the Marais district. Appointment only.',
      'author': 'By @louis_insider',
      'action': 'RESERVE',
      'img': 'https://lh3.googleusercontent.com/aida-public/AB6AXuBSP2pVQQeM3mMX4Wn5r58RERyfMmv9mf3PlxTidBk8YdGN8vuTz1azoxMS8T9gA86gdXlhEgq0UAKm18zD4ACAl6Ey-1YlCo_LdwqDoTmfLg64Sc_TdLoHya1cx3M1tqhQmxqTdxtSTw47N_d9hrHN1X4ys7Pu9nyb4X3so2q4OD_3dj63Fe_OA2XoX77xAJpKN96bTmqkl610CheFZ7Abj5AcTb7ZwE00OmIn8BpvdUS9K5Dy6WcA9AXeIK-TfQ14Y-oecM7xqe2Y',
    },
    {
      'location': 'NEW YORK, USA',
      'title': 'The Brass Vault',
      'desc': 'Unmarked door in Greenwich Village. Best acoustic jazz in NYC.',
      'author': 'By @jazz_junkie',
      'action': 'DIRECTIONS',
      'img': 'https://lh3.googleusercontent.com/aida-public/AB6AXuDw1JTMrfXQyPRK0J0O_VXabx_spC91QwNqeoMs3jZ0EtFBho_u6C6ZcVY34pNtNsiwYrPD0HBmgSND4CHYggOxiGyeJ_zcH0Rxr4Ne1rHaR5In2ABU3zNqKwVcMP7632tXepB5e17yuXRGxDe3g4_C7vv5liZTqqsO-LglyzjNsqr6MyXV90oZObFZVoeSOyjWBxuwbZRciR97AISlYFA7UDXLs238v94lTgDQSgNFr7F3OTIhr5FCSWigEwOU7SqyOKWxkvr057zH',
    },
    {
      'location': 'KYOTO, JAPAN',
      'title': 'Ocha San-Tei',
      'desc': 'A 400-year old tea house that only admits three guests at a time.',
      'author': 'By @zen_traveler',
      'action': 'BOOK TEA',
      'img': 'https://lh3.googleusercontent.com/aida-public/AB6AXuB5jNLRo45cMnmSAWqzgPBYDU5hmVIgfeyf3h_hFSa318sJ4p2WpV04DynEOlLxEC2CYm6HDGfgfVGro3X2AVAuTjwCjqK6xkPXDfCbwPUI7XXZ-vALtx6Wo8aQ-CEK0esjg35BYDysbMYkOxA-ZHj-k38iGr1uk5OGcVDcvLa_qzdvGX6vdTpAhsFwrfRdP-FsTKif7qt8Pq41Bo__k_mt_boxuewQoaHnrmKgEI06BngbjP7UgZtU9GkFuOCjg2dTreYzQDrqnMeA',
    }
  ];

  // 6. AI Assistant Messages presets
  static List<MessageModel> getAiAssistantInitialMessages() => [
    MessageModel(
      text: "Plan my perfect afternoon in Kyoto for someone who loves architecture and quiet cafes.",
      isUser: true,
      time: DateTime.now().subtract(const Duration(minutes: 5)),
    ),
    MessageModel(
      text: "Based on your preference for quiet spaces and structural beauty, I've designed a walking itinerary focused on the Northern Higashiyama area. It's less crowded today.",
      isUser: false,
      title: "A Curated Zen Afternoon",
      time: DateTime.now().subtract(const Duration(minutes: 4)),
      timelineStops: [
        TimelineStop(
          time: "14:00",
          category: "ARCHITECTURE",
          title: "Shisendo Temple",
          desc: "A mountain villa turned temple. Noted for its unique circular 'Moon Window' and tiered landscaping.",
          imgUrl: "https://lh3.googleusercontent.com/aida-public/AB6AXuAgfkjEXqT34trwJpmLJszkEqGMpZKDVoXQ1IYhPcBaUHMgY2LbKJQjMHcVeFusrjgrPEkaEBNCtVNMQqaXfHYcI72WL4ZK_ouVoNvbQojoUJ1-Dd4CD1GcTIhtBrwh8mYYKObvUYRGZ6Hq7UE09fwe4ib2bGFIUPpN1Ie7V3izR0kNPRtUkbIxIvv6jEiqXEI8NmywGE3QC86xCR3iLj5TgEgHLpNgiX-FgBLop8-2QzAhlo0WPyqUdZBiJh_aS6lrFW5rWQevnm6g",
          icon: Icons.architecture,
        ),
        TimelineStop(
          time: "15:30",
          category: "QUIET CAFE",
          title: "Kissa Kojo",
          desc: "\"A masterpiece of modern minimalism. Perfect for sketching.\"",
          imgUrl: "https://lh3.googleusercontent.com/aida-public/AB6AXuA90f2egx_41Pxke5wec-SchlOiupZ-Ixd0Sywam_NpXWHaU9hR32XxmjphUAAttJpUeqjGRFm69UbIuPNApgbfNLAV7v8t2F5_gWLlfuBQi84QT-VmnjXKvUjyFctnL94ROndJS48qY6gtEdmL1Jw6DCE0ayxeZYTFpSz4hPKl0m5of6iMZUQiHfb9gqsaqpy0MHzv0wsGRQd_fLtpMU_FDAjXyxcd4A-aZ2TTqs8iA5FUm8uJdNioSx3yviRscP3OIxal2Hqxi51G",
          rating: "9.8",
          icon: Icons.coffee,
        ),
        TimelineStop(
          time: "17:00",
          category: "SUNSET VIEW",
          title: "Philosopher's Path",
          desc: "Northern end walk under twilight. Serene pathway alongside a stone canal.",
          imgUrl: "https://lh3.googleusercontent.com/aida-public/AB6AXuDYvfpOSIOt3jtbI2ka9Qy9-FlpZZy8ivEqJoiP3NIq80gCD4NHdTEnmEGG3Hs6Fb-BNeq4S0Ehrp59YCZ1ftqU3maxQ9ExlFwpcoQ7RaO33W0d4wxfKcj-7_AdR9BINtJR2F2CngSoSQtzpvJ2RLyOlBtAh5USVuYcAqfKpy7nr2Dkj4Vz500Gq9fQkAM_da2P6sT9q3SR81vwOsawthaM7vWcUmM-GSFZPDZnQ9SHHCcFZCNKh7JSaLb2DoIkNVUGrgH2mkH7uBMJ",
          icon: Icons.park,
        ),
      ],
    ),
  ];

  static final List<String> aiSuggestions = [
    'Check crowd alerts',
    'Verify safety rating',
    'Optimize my timeline',
    'Find hidden cafes'
  ];

  // 7. Trip Planner Itinerary mock data
  static final Map<int, List<Map<String, dynamic>>> tripItineraryDays = {
    1: [
      {
        'time': '08:30 AM',
        'category': 'BREAKFAST',
        'title': 'Nishiki Market Culinary Tour',
        'desc': 'Start your journey at "Kyoto\'s Kitchen". Sample fresh tamagoyaki and seasonal pickles while watching the market wake up.',
        'icon': Icons.restaurant,
        'imgUrl': 'https://lh3.googleusercontent.com/aida-public/AB6AXuDenZ83HEMJeqXmChXvIwmqBngIJpolDsUnOGcm2EWCMzNidhD8sMSm1Mq_v1nWiT78LLcqZeFccB3lorsEvkTks-2wWeufPMWqOVlelyvLHYeQaDKfO-utme5OoLlwzxyKMQXnjhoFeiSSwPp9eygxLAXmRXbKu1SIf8edudWTSDYCxbQ4gnHtqUyi1f2rYpOpN_1qQZSP6896puLSmDMEEv18ZPpFXSFMBKrpmle7aBmqqR135VuDImdE8zkSnBQKpvnzNoC5rRz8',
        'tagLabel': 'FOODIE FAV',
        'tagColor': VoyentaColors.tertiaryContainer,
        'tagTextColor': VoyentaColors.onTertiaryContainer,
        'metrics': '1.5 Hours • ¥2,500 budget',
        'isFirst': true,
      },
      {
        'time': '11:00 AM',
        'category': 'SIGHTSEEING',
        'title': 'Fushimi Inari Shrine',
        'desc': 'Hike through the iconic thousand vermilion torii gates. We\'ve scheduled this early to avoid the heaviest peak crowds at the lower levels.',
        'icon': Icons.temple_buddhist,
        'metrics': '2.5 Hours • Free entry',
        'iconBadge': Icons.camera_alt,
        'isFirst': false,
        'galleryImages': [
          'https://lh3.googleusercontent.com/aida-public/AB6AXuBFcGeYTG9i_nxU8iS6YuW188YfOYRLpcpcwk9qYU8D-rWopVAhGeMRiY7FAsvcOu_m2-2wg_M-6yfXLcYRAEM5j-doLPb6GobU_XE80DQB6SLT943k1GCNZnIAnP3vGxKE1CdR_ogQcTMuTEID4d5lPaYbSn2I2Ycj0z5DUcqVWRTx1WfpiUWI-wOcBNT30QSfSv67IXDEnHiQx79Srkb9cI7dZC0ob456amFGKlDCDktVbVlwOnYAN1FZJOAQ6wM9ZwtOyhk2X5pi',
          'https://lh3.googleusercontent.com/aida-public/AB6AXuAcx44Bo5Q4tLk8cuyrX3yqFYuZhZF1-TeaisKRx4ziDijhcz_sWHAJoCsyJrFP_K8jjT_H2JtNx1gZNVOWPLHtzI4fd0Hy2IQ0Yps3kPL3Q70Ko3vgcAodPyk94N0Po8J31HEJ-ix_5wOLPGsqBbsbaJYhH6LNhTFGjUbqh_ECTIPjD8DtuZbZ_ii5BwSiIcvAatpgpn2FPYw_pKATiLjneHOIx711H4As_uyTlrlbRPAUCszA3FsEpzGGhZVlnTttFojoLvc8YO9r',
        ],
      },
      {
        'time': '07:00 PM',
        'category': 'DINNER & STROLL',
        'title': 'Dinner at Gion & Geisha District',
        'desc': 'Enjoy an kaiseki meal at a hidden gem overlooking the Kamogawa River, followed by a guided evening walk through the lantern-lit alleys of Gion.',
        'icon': Icons.nightlife,
        'imgUrl': 'https://lh3.googleusercontent.com/aida-public/AB6AXuB5YRgviJQ3_PcGQ-79IFzKoELyBtuxTNXBk579s0ej6Rs_bplSXL_1-_M3qOsydXTuvNzm2jBOmqxbjIqxqY8FdOAOK_2wmbAfJgW5NoGCGWwiUSx4RXJp5WNnxKf_JNTzrENsbcnvI6V6lC4oWOUBlnFoaWBPatJcDC-fX88YH-r1layJOO1MQyScNyjZPc6kcdvxWVsO9qSm8R_nX8LwCFYNEmkYGAmSBozqZl0ghun4nIGCBLL5L28CSv7OKA1uFEt9uTUBBMVy',
        'isFirst': false,
        'tipText': 'Table booked for 7:00 PM under \'Voyanta Guest\'. Remember to bring socks for the traditional floor seating.',
      }
    ],
  };

  // 8. Santorini Place Details mock data
  static final Map<String, dynamic> santoriniDetails = {
    'title': 'Oia, Santorini',
    'location': 'Cyclades, Greece',
    'match': '98%',
    'heroImage': 'https://lh3.googleusercontent.com/aida-public/AB6AXuBziQj_10ro70fsfNL3D8ixxlWsJ3Jc70cbLRvV6jATfXXF6w9SCEjP6n48qT9OEmL2e4Sy4TH3--LT7Kd2a0SL8WAlK16miUXSxDKbr8vdRbJUqIZvMg5yT7l0RmoZ3oDeC4rd650WDHoyWtqcrufM8M15GTnJKBTLJlvjPL4XW70RFzVhkHJPvDNvCrcNuSmF9492zeX11R5jmVxvCtrJbmAyQgvhSyyEleeiAxRHOhMkilKoi4e5qhBzMlLC3qWD7klFt34P9BGQ',
    'conciergeTitle': 'The Invisible Concierge',
    'conciergeDesc': 'Based on your preference for quiet luxury and sunset views, Oia is your definitive match. I\'ve secured exclusive access to private terraces where you can enjoy the caldera views away from the main crowds.',
    'highlights': [
      {'label': 'Iconic Sunsets', 'icon': Icons.wb_twilight},
      {'label': 'Private Caldera', 'icon': Icons.deck},
      {'label': 'Fine Dining', 'icon': Icons.restaurant},
    ],
    'knowBeforeGo': [
      {'label': 'Best Time', 'icon': Icons.calendar_month, 'value': 'June-Sept', 'color': VoyentaColors.primary},
      {'label': 'Safety', 'icon': Icons.verified_user, 'value': '9.8/10', 'color': Colors.green},
      {'label': 'Crowds', 'icon': Icons.groups, 'value': 'High', 'color': Colors.amber},
    ],
    'trending': [
      {
        'title': 'Sunset Boat Tour',
        'sub': 'Private 5-hour excursion with dinner',
        'img': 'https://lh3.googleusercontent.com/aida-public/AB6AXuB6WbCnoiF8Wd5OU3MLn94EZdHWh9dOdaeERSWTVxWJbVKanI6DzprecVNTc-c9rMGZrSDw_NlzRzgKSqKkVkQPtXhLQ_i0yEqkXgjpEaORiyGE5agInnFh85WxCJtnD62Dph16fT6iXO-aDgyqO8IAx_wvUQAD_MyuXiy_uYz92QEwKNt-AGQ5oMBuK5xWry5NxgYdmZccvLX5uy5lEyHy5IeaM57IW2lRzAinWJHxmWIAobAFZKT03Ge1RqQmD-X4DHk1LYcHzvBP',
        'badge': 'MOST POPULAR',
        'isLarge': true,
      },
      {
        'title': 'Ammoudi Bay Dinner',
        'img': 'https://lh3.googleusercontent.com/aida-public/AB6AXuDsJmSaFy9HxZYeijh2sQQ9oJXHsLtXw34-C_pNH4jhn_3S_mjb_u0LMAdR7kuuXYAZHslY7_z8ueoc18AUZjy2FGMrk_oejOnUuUceRvD5cFTYPWHcZ3Sf6KCLTq-Id0o5px9nZwTeqcsUmeIswFs69K85d1MigjBdMSA-pJ6Qg1tzkh91dWNuBpNizO7LCWIHQzk2OpZORo173oVA2ANr_v9xv_IVO1OmFX-bGvwrJthuFEU4dfJvRycYWzT3sCXUd1BMxpvsow06',
        'isLarge': false,
      },
      {
        'title': 'Artisan Shopping',
        'img': 'https://lh3.googleusercontent.com/aida-public/AB6AXuAjajC8oOf9WpfDz3zu-2Ps20gG_NlJsGEworN9lLpv7lqQ7I6g_dTwzJyElnrA_m3_UuHafEt-PHnQWgSKJ3aesf_05z7daOOMjgKEyK6T8brjAi-IZ7Q9uz9UPEWlP1oXZa92vWjsNz2_9cs55X_w7lliMLk3J58P-LT6Ns2FEiqMw6FuMRgYirv3x1PA5KatMGgCc9nQXdSAcXpaL7TUjLvlzHB91z2NZkDuymOXs1fpLs8cSR7VvXkyctzeQfmyKQ-5u7pcBW0K',
        'isLarge': false,
      }
    ],
    'tips': [
      {
        'userInitials': 'JD',
        'username': 'Julian D. • Expert Traveler',
        'desc': '"Book dinner at Sunset Ammoudi at least 3 weeks in advance. Ask for a table on the edge for the best views."',
      },
      {
        'userInitials': 'MS',
        'username': 'Maria S. • Local Guide',
        'desc': '"The path from Fira to Oia is stunning but hot. Start by 7:00 AM to beat the sun and the crowds."',
      }
    ]
  };

  // 9. Global Search mock data
  static final List<Map<String, dynamic>> searchCategories = [
    {'label': 'Country', 'icon': Icons.public},
    {'label': 'City', 'icon': Icons.apartment},
    {'label': 'Restaurant', 'icon': Icons.restaurant},
    {'label': 'Hotel', 'icon': Icons.hotel},
    {'label': 'Beach', 'icon': Icons.beach_access},
    {'label': 'Museum', 'icon': Icons.museum},
  ];

  static final List<Map<String, dynamic>> recentSearches = [
    {
      'title': 'Kyoto, Japan',
      'subtitle': '3 DAYS AGO',
      'img': 'https://lh3.googleusercontent.com/aida-public/AB6AXuAah0B4dJDIZHsuseHR1vDl5TtJ0Rj3YFLrRFY-vi77qyh6kYTan-p_uUKwcacM0YkObmWJFMTY-5clTxV0jXmWGqmRvGVedpEP9GmqSdNdbIWfE1vdhJBcuI5Fsua-8_VEVIbjAamE_2u2Kk8eD9PuNs39D6CFWVILF4qvvG8m_qLRu70fF-jJVVk-nlcZmfCzUa97MUWvxZlbYIWMwCQJq3aWzVjs8YMQ3ZnzPpnjq5qBWNXAqxR492Ox_tJVzAdIFWYqnj49mBqq',
    },
    {
      'title': 'Santorini, Greece',
      'subtitle': '1 WEEK AGO',
      'img': 'https://lh3.googleusercontent.com/aida-public/AB6AXu-w_OHMWuJAMvEXbzxFgcU4U1sDtmx4Voosg0wYUY44WcRHUrsUkX1LSZaxID5FUzwxLr4hoNb5h6otQeOcCTnD36wUDj3RduvmQ5CXforKEh9VOUe0SGNmUhNyDTAPu8cu98MTiC91GN_Tm-I1EYmqhylXVB-KfQwheRYZs50yZcW0h92Bd-D3AKxO8Q9mDt83UNOwuFycVVWFMuA5XJItzfW1Vj5_jyE_33ayiJKrBeWkkNIP-LhH_0ZqSRTkzl8xSBBfK4U5plR',
    },
    {
      'title': 'Le Jules Verne',
      'subtitle': 'RESTURANT • PARIS',
      'img': 'https://lh3.googleusercontent.com/aida-public/AB6AXuAAe6T3LAqt3ZelilFkoudn2vlF9NMAQDO6CquGwSqAYgzpjVdlBqGWJ2ztQ3Kgre5w9cfg08egHPrGNSF2E-v_iOa5UygE2B7GEPgIQ-CLNrHSXsGkpJQ9W3v6UM-KC8vVXyDwtkPyn0ft8Pv21IdqRhfMSWHimRLftvIEKDoMBsQiaV524PQQTdC0rU7t8z8PC2s_AW6vrXs9QBuM9wPVWHS5v-8gKps8rHFm2Jnc1YuLJ618Et3UIGt1Kts_nh3U87-0DrvAU9rD',
    },
  ];

  static final List<Map<String, dynamic>> searchTrendingDestinations = [
    {
      'title': 'Amalfi Coast',
      'country': 'ITALY',
      'badge': 'TOP RATED',
      'desc': '240+ boutique stays found',
      'img': 'https://lh3.googleusercontent.com/aida-public/AB6AXuC1bZh0zAyH9c25QTjZ76DqMkYBfvYeMtIdgHi_Q5HfsHlyEKjqYvbrLXvTN1m4dwmlgfyQEKR20BGcE-KvhNbcyn3hvRJ4jDlLzeTgC56_WAvfA4_A7KycdlrzzdzTkXTdYDRxNDDG4yLInOomFUHUYOJtEPmj_KXubEHIMCXKOzkWXQkmtoN7pGLhMzjIMNkgALXZq0Zzm5a8-XJsZyp-10_KwsQqNUCUG6XM5MmMh_7ys1E0U5Nl7Ffd_eeb3AfHrSHHlkpMSkVg',
      'isLarge': true,
    },
    {
      'title': 'Malé Atoll',
      'country': 'MALDIVES',
      'rating': '4.9 (1.2k)',
      'img': 'https://lh3.googleusercontent.com/aida-public/AB6AXuCNJLQ19FTGFT2_qh8moKwzqaA7ndx9bE1TXeMFqNOb1ZkO_EGd0KJ2tDXYVeA62wGjHRgwJT4ILqkndDHAB0eY0TNV7MxscP4KV3x7qWICpwk-VALNu3njHv-nXnDc5DFnNiIHRXEJ7RmK4a7CGN-JCdU1UfcOJJfRD4vumaRjzZjXXghwP0_Rf1vE_tcgtDXxGpaLBim5G0b_v8WARBUbeYvuoh2Ia1WIU7ExvcGgBnGfVn_nVjOKRh1qP-0b_KPHJOkwFDctnDhx',
      'isLarge': false,
    },
    {
      'title': 'New York City',
      'country': 'USA',
      'trendBadge': 'Hottest this month',
      'img': 'https://lh3.googleusercontent.com/aida-public/AB6AXuBdw386KcVBg02KOUPP4lp51L8r8-mnhJtbu4Dgs8uKqkRrNm0RO_XA8OWUsp-MraJ7Cb9vsYHKu7VrcvbQ-b-3Q8D37C5WTNOK9R_tqGWiodNTx4uTq-LruOySR_YBxbD1Kj2QcNvFUnmLVd_smQ1vl_-fsNdIKMxQQk4u42ODWZ2ykJdaDADjI8McP50A5WE1obVhNT50eeVFrUxWODXyW96a_tzePjzE-OYm6NElcCD6KG0M20y_9kCLZlW-RGNENGt-Qr-NJJxt',
      'isLarge': false,
    },
  ];

  static final List<Map<String, dynamic>> searchCollections = [
    {
      'title': 'Wellness Retreats',
      'desc': "Find peace in the world's most secluded spas and healing centers.",
      'icon': Icons.spa,
      'guidesCount': 12,
      'color': VoyentaColors.surfaceContainerHigh,
      'textColor': VoyentaColors.primary,
    },
    {
      'title': 'Mountain Escapes',
      'desc': 'For those who seek high altitudes and breathtaking alpine vistas.',
      'icon': Icons.hiking,
      'guidesCount': 45,
      'color': VoyentaColors.secondaryContainer,
      'textColor': VoyentaColors.onSecondaryContainer,
    },
    {
      'title': 'Michelin Journeys',
      'desc': "A culinary traveler's roadmap to the world's finest dining rooms.",
      'icon': Icons.dinner_dining,
      'guidesCount': 28,
      'color': VoyentaColors.tertiaryContainer,
      'textColor': VoyentaColors.onTertiaryContainer,
    },
  ];

  // 10. Kyoto Destination Details mock data
  static final Map<String, dynamic> kyotoDetails = {
    'title': 'Kyoto',
    'breadcrumbs': ['ASIA', 'JAPAN'],
    'subtitle': 'The heartbeat of traditional Japan, where centuries-old temples meet Zen gardens.',
    'heroImage': 'https://lh3.googleusercontent.com/aida-public/AB6AXuAeGHNvDg7AOM0F_8mqzEAjBOr5CRmvLWbQIqVJ1VQ2qKR64ZQm-9apzX_r7QXx6nAOwtGxl8WVexw0wo0bzS4mVyi0h6-Ihlvbms8pMploUhnlBBL2CEtS3y9jxMDtcrZ_Y5J1FtvDvolGOy5TBCJ44M-Eexai4qdK4Pf8Eq6ycnhzYrCjgkYc97MhN1TERUBWjhF91aKU5DRAqZ0lcTx1EKXct2QG2KUpyqxYBe56aggOPRFprjE9y-dEzZS76xC89ZxF7POZGqOg',
    'conciergeTitle': 'AI Concierge Summary',
    'conciergeSub': 'GENERATED JUST FOR YOU',
    'conciergeDesc': 'Kyoto is a timeless city that offers an unparalleled immersion into Japan\'s imperial past. Unlike the neon-lit frenzy of Tokyo, Kyoto moves at the pace of a tea ceremony. Your journey here will be defined by the juxtaposition of the Gion district\'s geisha culture and the Arashiyama Bamboo Grove.\n\nFor a refined traveler, the city rewards early risers and those willing to explore the smaller, lesser-known shrines nestled in the eastern hills.',
    'customs': [
      'Bow slightly when greeting',
      'Remove shoes indoors',
    ],
    'practical': [
      'Currency: Japanese Yen (¥)',
      'Language: Japanese',
    ],
    'commute': [
      'Extensive bus network',
      'JR Pass accepted',
    ],
    'safetyScore': '4.8/5',
    'budgetValue': 'High',
    'bestTimes': [
      {'label': 'Spring', 'value': 'Mar – May'},
      {'label': 'Autumn', 'value': 'Oct – Nov'},
    ],
    'bestTimeDesc': 'Peak seasons offer cherry blossoms and vibrant maple leaves, respectively.',
    'emergencyContacts': [
      {'label': 'POLICE', 'value': '110'},
      {'label': 'AMBULANCE / FIRE', 'value': '119'},
    ],
    'experiences': [
      {
        'title': 'Urasenke Tea Ritual',
        'desc': 'A private 90-minute session with a tea master in a 400-year-old garden.',
        'img': 'https://lh3.googleusercontent.com/aida-public/AB6AXuD61aYk3lpPRE2a-7tj08Ugjo4oGnXZUS4mAQ_QfO5eZ1rtCF0kxE4-FUrgSqxKJ4clfXp15ihC1C6L9Vm0NqkFGl9EhdQL6_LrWJXk1oghqebRCEBwQGHjy31_hgOGiJPLtLdIlTZsFNszlx4OyYOiG2HXfC0jdOBHAQ36b_6BzMK-WecuOQwrTzkoTQw2X49QgjXe0YEfGzkdpZ-OdUS3qQgf-f4De8X5hpQ6cRYlc3wOJjJDaJ7yjliraE-k0DJsR5ZI8tUL6Qtm',
      },
      {
        'title': 'Gion Twilight Walk',
        'desc': 'Discover the hidden alleyways and history of the geiko world at sunset.',
        'img': 'https://lh3.googleusercontent.com/aida-public/AB6AXuAZTByCwm5-wPFPX01ilmi0LuwkYhq8SEKos59m2jQ1FBi3ovgBdHR113a-QcFpmESDfHOkxhFbRtguPSXTkdW-2TuA2r4TbHY_QTO7rgfIBkd8IphlSTFK4Jr3HfD89WnXO9yPO7tylt3q5xGcVUAE34w_smb4n-5gdCxQAwkIMAslc59BvGQbW-70ahzLgChJCMNBttOHC0FlMKUBfeybCuXKs1JhptdhDIDNmC1CDrwxeXiBtVO8FUaYZy6kATNnp75LcYWrCObO',
      },
      {
        'title': 'Fushimi Inari Pilgrimage',
        'desc': 'Guided hike through the thousands of torii gates to the mountain summit.',
        'img': 'https://lh3.googleusercontent.com/aida-public/AB6AXuAISsKUtUSvGY824ucHbBvQu41N9_IBr3pkioPmmZkM9BFiP0gV7mb3ESzeGrZ0eKQlyu83U-B_YX-QOSwYIr9u085kyuUpw7FlvhhkyfsCozbSf9X3Q55haMlN5PqDj0ZUu-h-g8AiTzuwMherbSDwXfrkMtnHwb_SN_SU2AbD3WX3TivsIQfIj11qzOZQuO6TVuXVJb6mJlSKPjmSE5m8g56a6iLV22jOX08iHGO2V5BQMjqtFO3m-XrY-DBkOl4y_G4359QC7HCp',
      }
    ]
  };

  // 11. Shisendo Destination Details mock data
  static final Map<String, dynamic> shisendoDetails = {
    'title': 'Shisendo Temple',
    'desc': 'A hidden mountain villa turned Zen temple, once the retreat of a 17th-century scholar-poet. Famous for its "shishi-odoshi" fountain and tranquil sand gardens.',
    'rating': '4.9',
    'reviewsCount': '1.2k Reviews',
    'match': '99%',
    'tags': ['Zen Garden', 'Historic Site', 'Quiet Zone'],
    'galleryImages': [
      'https://lh3.googleusercontent.com/aida-public/AB6AXuD_3eqH7D5Uz3cXMlLK2Oz5DsvNEy5X_Jt68NwYliAzjR85gXgnxnLuRO5fZ2-QmvxRgGC1kJQz95gvFmNzRMProtOUyfw625eBgyEd357gGES0e40CtTWuBm4j7nbL1Rwu2ICKfG962tYWNka7jy-MMJS3qo2xIUAIR6rfsDb25E7ODLmtndnEU1D3z9i1f6OhykdiuUTUl1rMhrxjm2Nqo5S_TCD0ViYMg8rxhxD9qQHcVq1LJixTvSk3wmsTw620Ho0Tlj163dSI',
      'https://lh3.googleusercontent.com/aida-public/AB6AXuBY9eL8ntNBN6GYFfMGEUgFAF-0hWPpmWgILYku0cnArG0tVfiJkgshaWGjb_FYmcbREA9KPEAa0_FcALvCFt4OWJyWIKRluhiOeyd5MXPOg3h7TTcGIqlEPAF-FIC6DuepZufZsrsIQSz-ASbw3ByUnXBuVp3FQJu5DZy7bahCRaxDByoQKWuaD_4UZzHntFMtM--ahVcOvFrdpEXYxEEKFfVMYhonNK9YwHIfdbFJqy-CHt-Z4UgaW1ovXydTc66rZrnbZNbYO7QC',
      'https://lh3.googleusercontent.com/aida-public/AB6AXuBOZYQfb--dfQmddAhO5d3Ky5tl1q0arqtjaZd3XHRgIK7309qRzCknhnQdfWd9GYguuHyWlRKhgLI88UlhBAd7aSQ5YcdQ7QqWpijaO5FVW3AVQfJBUR65UdwWw34TfdsnhIi_xAuAmV7oIIgB5i_uLTDGrUANPQK2dHB3yEwYCNHPlKMz-3vTKAgZeumJcn8OSPbT6aAWkd7gMpp93JYUqox_jTH38SMZ2_grofwU5U0Wq0yj-S6N56DKto-5-QZmwJPc74YHSt1a',
    ],
    'communityTips': [
      {
        'title': 'The Best Sunset Viewing',
        'desc': 'Arrive 45 minutes before closing. Most tour groups leave, and the light hits the sand garden at a perfect low angle for photography.',
        'icon': Icons.visibility,
      },
      {
        'title': 'Matcha Service Secret',
        'desc': 'The temple offers a private matcha service in the lower garden hut if you ask politely at the entrance—often missed by casual visitors.',
        'icon': Icons.local_cafe,
      }
    ],
    'crowdPrediction': {
      'level': 'Quiet',
      'wait': 'Current wait: 0 mins',
      'chartValues': [0.3, 0.45, 0.8, 0.2, 0.4, 0.6, 0.5],
      'chartLabels': ['08:00', '12:00', '17:00'],
    },
    'directions': [
      {
        'step': 1,
        'title': 'Kyoto City Bus #5',
        'desc': 'From Kyoto Station, take Bus #5 to \'Ichijoji-Sagarimatsu-cho\' stop (40 mins).',
      },
      {
        'step': 2,
        'title': 'Uphill Walk',
        'desc': 'A scenic 7-minute walk through the Ichijoji neighborhood. Follow the signs uphill.',
      }
    ],
    'mapImage': 'https://lh3.googleusercontent.com/aida-public/AB6AXuAL6gkOlNfrl4iWrwBxOJ2c8ZgOp4vyDi1TJcpiFWd0YIWKV4HtFkgegUksmz8l1LCZcyKdYNfLzuUy_6-SHVpUAJPDk93C6o1JOs-NosF9JD67U4PHW3r1FRx9h16uU3e7eFYi92AsuehVIdLrUSD3lYy-g-ixAqH4ferR8qho9Vofxna_qB1QuysOtPbT9xNu8JrAkosFon1xCPpP5GL06dG9eBDUeTTCu1AJpyu0iug4mvmDzuUrWpZRRAhZHbh8do-ncf7ms6MT',
    'traffic': 'Traffic: Light',
  };

  // ---- Profile Screen Data ----
  static final Map<String, dynamic> profileUser = {
    'name': 'Julian D.',
    'tagline': 'Curating the Unseen',
    'location': 'Based in Zurich',
    'website': 'voyanta.travel/julian_d',
    'avatar': 'https://lh3.googleusercontent.com/aida-public/AB6AXuBaw-h-pEOH-P1b8rq_4uOieT-m_ow71mcCEMlwSIadpxnfq-KPkMabnmMk7gDyCz3r4ZtvePxSZCOHjUELRmrODqLSv0AdmR-g1H5pVzkTnagaTcIGoEsORITz3tYDuBRxr1tbw1J_1bmcpvyLiYMVwtcDGOm60ZAhWPksiUTWBsAeeaE2IAtrFNxLTiU49BVxxznr4iHvujsn5V_aVeHg8s3MVuVW9fr68hPpinZ8Zf1zXXdlJQT5o84yrWy3-cYFnjy8-nLsq4Xp',
    'memberBadge': 'GOLD MEMBER',
  };

  static final List<Map<String, String>> profileStats = [
    {'value': '42', 'label': 'Cities Visited'},
    {'value': '128k', 'label': 'Miles Traveled'},
    {'value': '15', 'label': 'Hidden Gems Found'},
  ];

  static final List<Map<String, String>> profileCollections = [
    {
      'title': 'Kyoto Zen',
      'count': '12 DESTINATIONS',
      'img': 'https://lh3.googleusercontent.com/aida-public/AB6AXuCMeDa8y_4Z4PeupNfnVZTv_yLgGI2fbN6qY-7Ct0TjS8erHYSVb9lW7q7Z1mO4jFbdiJ66D4cK6Zdv4kgI1Dt9rIIU7CZ47NhcpqyUFvJ-_AEl07MCkYdc6t9oeTtRgupz5EHMO_EVtFb-FFaPhmniygm614HekSVG_oemSWXeQd48ZvMTB82cC3tMYaP6ArT9UpjjizF1SZPfO8i7vuQ64MLjtL1q6M8S2hwFYQOH2s_QZ1Q_D8zC5AAlQPO68IukUE9uuPo8chDJ',
    },
    {
      'title': 'Santorini Sunsets',
      'count': '8 DESTINATIONS',
      'img': 'https://lh3.googleusercontent.com/aida-public/AB6AXuALldUV0Ef-SOz0npFkpk03Uz31vAKekWs0_bd7PEK3gvtsb4StKGjWusn2wQQCjETHtfyuidYwLv5BIY4FeUzUnForqj3_gSpLIVuQOychX6gVqapqJssFXogRb-UtLmG7qC0ZjlIRJYmoloFqyO-81cn9LHs4871C7ZzgbDomc-P0hUY9Ah7SPzFWHmtvdZLQ4D2cYgS0AwepSftpiRjAiKNZgCfAtMO-vE7MQoT9l9KvaRRNaX6_RumtN98hpaGpctaACQpcLjRd',
    },
    {
      'title': 'Parisian Cafes',
      'count': '6 DESTINATIONS',
      'img': 'https://lh3.googleusercontent.com/aida-public/AB6AXuD6fdya5_OY1KjLEh9r4EFJ9Cg2jXMhGH7BPdEQyrjfgazDRijW8HHnP1pUcmjYmLYhVlt-mhrO7q0Pq2iGf4rnp3nfZJi4uZkIHcJM7MbjQV064uNmcYd4WG2IJKhEkd-x4UOHAqGncgiXl3LJNgbf2BVe97PcSg4jnDFtL_HS_R2SCWmjXnfeVH3EZdzaOikfjaWLQEhyVSv7UucBObcQL40GZm71a0mwYJ6jEb3QuLxhLHl_4hoo0E06AjTIGU9BB7fOZYdPUeI8',
    },
  ];

  static final List<Map<String, dynamic>> profileAchievements = [
    {'label': 'Early Explorer', 'icon': Icons.explore, 'color': 'primary', 'unlocked': true},
    {'label': 'Local Legend', 'icon': Icons.workspace_premium, 'color': 'gold', 'unlocked': true},
    {'label': 'Sustainability Advocate', 'icon': Icons.eco, 'color': 'secondary', 'unlocked': true},
  ];

  static final List<Map<String, dynamic>> profileSettings = [
    {'title': 'Membership Benefits', 'icon': Icons.loyalty, 'color': 'tertiary'},
    {'title': 'Privacy & Security', 'icon': Icons.lock_outline, 'color': 'primary'},
    {'title': 'Help & Support', 'icon': Icons.support_agent, 'color': 'secondary'},
  ];
}
