import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _isChatOpen = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragEnd: (details) {
        if (details.primaryVelocity! < 0) {
          // Swipe left to open chat
          setState(() {
            _isChatOpen = true;
          });
        } else if (details.primaryVelocity! > 0) {
          // Swipe right to close chat
          setState(() {
            _isChatOpen = false;
          });
        }
      },
      child: Stack(
        children: [
          Scaffold(
            key: _scaffoldKey,
            body: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // const Text(
                          //   'Connect',
                          //   style: TextStyle(
                          //     fontSize: 24,
                          //     fontWeight: FontWeight.bold,
                          //   ),
                          // ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 150), // Adds space from the left
                            child: Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 20,
                                    vertical: 8,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.blue,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Text(
                                    AppLocalizations.of(context)!.becomeAMentor,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _isChatOpen = true;
                                    });
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: Colors.indigo[900],
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: const Icon(
                                      Icons.chat,
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),

                    // Top Mentors
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            AppLocalizations.of(context)!.topMentor,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Row(
                            children: [
                              Text(
                                AppLocalizations.of(context)!.seeAll,
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(width: 4),
                              Icon(
                                Icons.chevron_right,
                                color: Colors.blue,
                                size: 18,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    // Mentor Avatars
                    SizedBox(
                      height: 100,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        children: [
                          _buildMentorAvatar(
                              AppLocalizations.of(context)!.nameNeeta,
                              'assets/img5.jpg'),
                          _buildMentorAvatar(
                              AppLocalizations.of(context)!.nameNikita,
                              'assets/image6.jpg'),
                          _buildMentorAvatar(
                              AppLocalizations.of(context)!.nameManya,
                              'assets/image22.jpg'),
                          _buildMentorAvatar(
                              AppLocalizations.of(context)!.nameShagun,
                              'assets/image5.webp'),
                        ],
                      ),
                    ),

                    const SizedBox(height: 8),

// Feed Posts
                    _buildPostCard(
                      name: AppLocalizations.of(context)!.poojaPandey,
                      role: AppLocalizations.of(context)!.dairyFarmExpert,
                      time: AppLocalizations.of(context)!.twoDaysAgo,
                      profileImage: 'assets/img10.jpg',
                      isFollowing: true,
                      title: AppLocalizations.of(context)!.cattleFeedingGuide,
                      content:
                          AppLocalizations.of(context)!.cattleFeedingContent,
                      images: ['assets/img6.jpg'],
                      bulletPoints: [
                        AppLocalizations.of(context)!.grass,
                        AppLocalizations.of(context)!.grassDescription,
                        AppLocalizations.of(context)!.hay,
                      ],
                    ),

                    const SizedBox(height: 16),

                    _buildPostCard(
                      name: AppLocalizations.of(context)!.sheelaDevi,
                      role: AppLocalizations.of(context)!.financeExpert,
                      time: AppLocalizations.of(context)!.oneDayAgo,
                      profileImage: 'assets/image5.webp',
                      isFollowing: true,
                      title: AppLocalizations.of(context)!.npddTitle,
                      content: AppLocalizations.of(context)!.npddContent,
                      images: ['assets/img8.webp'],
                      bulletPoints: [
                        AppLocalizations.of(context)!.npddPoint1,
                        AppLocalizations.of(context)!.npddPoint2,
                        AppLocalizations.of(context)!.npddPoint3,
                      ],
                    ),

                    // Videos For You
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Videos For You',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 12),
                          SizedBox(
                            height: 180,
                            child: ListView(
                              scrollDirection: Axis.horizontal,
                              children: [
                                _buildVideoThumbnail(
                                    'assets/video/Success.mp4'),
                                _buildVideoThumbnail(
                                    'assets/video/Success.mp4'),
                                _buildVideoThumbnail(
                                    'assets/video/Success.mp4'),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Sliding Chat Panel
          AnimatedPositioned(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            right: _isChatOpen ? 0 : -MediaQuery.of(context).size.width * 0.90,
            top: 0,
            bottom: 0,
            width: MediaQuery.of(context).size.width * 0.85,
            child: GestureDetector(
              onHorizontalDragEnd: (details) {
                if (details.primaryVelocity! > 0) {
                  setState(() {
                    _isChatOpen = false;
                  });
                }
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 10,
                      offset: const Offset(-5, 0),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    // Chat Header
                    Container(
                      padding: const EdgeInsets.fromLTRB(16, 50, 16, 16),
                      color: Colors.indigo[900],
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Messages',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.close, color: Colors.white),
                            onPressed: () {
                              setState(() {
                                _isChatOpen = false;
                              });
                            },
                          ),
                        ],
                      ),
                    ),

                    // Chat List
                    Expanded(
                      child: ListView(
                        padding: EdgeInsets.zero,
                        children: [
                          _buildChatItem(
                            'Pooja Pandey',
                            'How can I improve my cattle feed?',
                            'assets/img5.jpg',
                            '2m ago',
                          ),
                          _buildChatItem(
                            'Sheela Devi',
                            'I can help you with the NPDD scheme application',
                            'assets/image6.jpg',
                            '1h ago',
                          ),
                          _buildChatItem(
                            'Neeta',
                            'Let\'s discuss your farm management plan',
                            'assets/image22.jpg',
                            '3h ago',
                          ),
                          _buildChatItem(
                            'Nikita',
                            'The new government subsidy is now available',
                            'assets/image5.webp',
                            '1d ago',
                          ),
                          _buildChatItem(
                            'Manya',
                            'Check out the new cattle breeding techniques',
                            'assets/image9.jpg',
                            '2d ago',
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMentorAvatar(String name, String imagePath) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.black, width: 2),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: Image.asset(
                imagePath,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            name,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPostCard({
    required String name,
    required String role,
    required String time,
    required String profileImage,
    required bool isFollowing,
    required String content,
    String? title,
    List<String> images = const [],
    List<String> bulletPoints = const [],
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Author info
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundImage: AssetImage(profileImage),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        '$role • $time',
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFE8D6),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Text(
                    'Following',
                    style: TextStyle(
                      color: Colors.black87,
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Post images
          if (images.isNotEmpty)
            SizedBox(
              height: 200,
              child: Row(
                children: images
                    .map(
                      (image) => Expanded(
                        child: Image.asset(
                          image,
                          fit: BoxFit.cover,
                          height: 200,
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),

          // Post content
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (title != null)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Text(
                      title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                Text(
                  content,
                  style: const TextStyle(fontSize: 14),
                ),
                if (bulletPoints.isNotEmpty) const SizedBox(height: 12),
                if (bulletPoints.isNotEmpty)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: bulletPoints
                        .map(
                          (point) => Padding(
                            padding: const EdgeInsets.only(bottom: 4),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('• ',
                                    style: TextStyle(fontSize: 14)),
                                Expanded(
                                  child: Text(
                                    point,
                                    style: const TextStyle(fontSize: 14),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                        .toList(),
                  ),
                const SizedBox(height: 8),
                const Text(
                  'READ MORE.....',
                  style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVideoThumbnail(String imagePath) {
    return Container(
      width: 120,
      margin: const EdgeInsets.only(right: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        image: DecorationImage(
          image: AssetImage(imagePath),
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        children: [
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withOpacity(0.5),
                  ],
                ),
              ),
            ),
          ),
          Center(
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.7),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.play_arrow,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChatItem(
      String name, String message, String image, String time) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: AssetImage(image),
      ),
      title: Text(
        name,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Text(
        message,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      trailing: Text(
        time,
        style: TextStyle(
          color: Colors.grey[600],
          fontSize: 12,
        ),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    );
  }
}
