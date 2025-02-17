import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'mentorfile.dart';
import '../l10n/app_localizations.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late VideoPlayerController _controller;
  bool showMessages = false;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset('assets/video/Success.mp4')
      ..initialize().then((_) {
        setState(() {});
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // Full-Screen Video Widget
  Widget _buildFullScreenVideo(String videoPath) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(AppLocalizations.of(context)!.fullScreenVideo),
        actions: [
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () {
              Navigator.pop(context);
            },
          )
        ],
      ),
      body: Center(
        child: VideoPlayerWidget(videoPath: videoPath),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragEnd: (details) {
        if (details.primaryVelocity! < 0) {
          setState(() {
            showMessages = true;
          });
        }
      },
      child: Stack(
        children: [
          Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              title: Text(
                AppLocalizations.of(context)!.connect,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    // Your action to become a mentor
                  },
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 20),
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    AppLocalizations.of(context)!.becomeAMentor,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.message, color: Colors.black),
                  onPressed: () {
                    setState(() {
                      showMessages = true;
                    });
                  },
                ),
              ],
            ),
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Top Mentors Section
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.topMentor,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: Text(AppLocalizations.of(context)!.seeAll),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 100,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 4,
                      itemBuilder: (context, index) {
                        List<String> imagePaths = [
                          'assets/image6.jpg',
                          'assets/image9.jpg',
                          'assets/image20.jpg',
                          'assets/img6.jpg',
                        ];

                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              CircleAvatar(
                                radius: 30,
                                backgroundImage: AssetImage(imagePaths[index]),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                [
                                  AppLocalizations.of(context)!.nameNeeta,
                                  AppLocalizations.of(context)!.namenikita,
                                  AppLocalizations.of(context)!.namemanya,
                                  AppLocalizations.of(context)!.nameshagun
                                ][index],
                                style: const TextStyle(fontSize: 12),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),

                  // Feed Posts Section
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: 2,
                    itemBuilder: (context, index) {
                      List<String> userImagePaths = [
                        'assets/image22.jpg',
                        'assets/image11.jpg',
                      ];

                      return Card(
                        margin: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ListTile(
                              leading: CircleAvatar(
                                backgroundImage: AssetImage(userImagePaths[index]),
                              ),
                              title: Text(
                                index == 0 ? AppLocalizations.of(context)!.poojaPandey : AppLocalizations.of(context)!.sheelaDevi,
                                style: const TextStyle(fontWeight: FontWeight.bold),
                              ),
                              subtitle: Text(
                                index == 0
                                    ? AppLocalizations.of(context)!.dairyFarmExpert
                                    : AppLocalizations.of(context)!.financeExpert,
                              ),
                              trailing: ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFFFFE5D8),
                                ),
                                child: Text(
                                  AppLocalizations.of(context)!.following,
                                  style: const TextStyle(color: Colors.black),
                                ),
                              ),
                              onTap: () {
                                if (index == 0) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => ProfilePage()),
                                  );
                                }
                              },
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.asset(
                                index == 0 ? 'assets/img7.webp' : 'assets/image11.jpg',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),

                  // Videos Section
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      AppLocalizations.of(context)!.videosForYou,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                    ),
                    itemCount: 3,
                    itemBuilder: (context, index) {
                      String videoPath = 'assets/video/Success.mp4';

                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => _buildFullScreenVideo(videoPath),
                            ),
                          );
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: VideoPlayerWidget(videoPath: videoPath),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                setState(() {
                  _controller.value.isPlaying
                      ? _controller.pause()
                      : _controller.play();
                });
              },
              child: Icon(
                _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
              ),
            ),
          ),
          // Messages Panel
          if (showMessages)
            Positioned(
              top: 0,
              bottom: 0,
              left: 0,
              right: 0,
              child: GestureDetector(
                onHorizontalDragEnd: (details) {
                  if (details.primaryVelocity! > 0) {
                    setState(() {
                      showMessages = false;
                    });
                  }
                },
                child: Container(
                  color: Colors.white,
                  child: Column(
                    children: [
                      AppBar(
                        backgroundColor: Colors.white,
                        elevation: 0,
                        leading: IconButton(
                          icon: const Icon(Icons.arrow_back, color: Colors.black),
                          onPressed: () {
                            setState(() {
                              showMessages = false;
                            });
                          },
                        ),
                        title: Text(
                          AppLocalizations.of(context)!.messages,
                          style: const TextStyle(color: Colors.black),
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: 5,
                          itemBuilder: (context, index) {
                            List<String> userNames = [
                              AppLocalizations.of(context)!.nameNeeta,
                              AppLocalizations.of(context)!.namenikita,
                              AppLocalizations.of(context)!.namemanya,
                              AppLocalizations.of(context)!.nameshagun,
                              AppLocalizations.of(context)!.poojaPandey
                            ];

                            List<String> imagePaths = [
                              'assets/image6.jpg',
                              'assets/image9.jpg',
                              'assets/image20.jpg',
                              'assets/img6.jpg',
                              'assets/img5.jpg',
                            ];

                            List<String> userMessages = [
                              AppLocalizations.of(context)!.message1,
                              AppLocalizations.of(context)!.message2,
                              AppLocalizations.of(context)!.message3,
                              AppLocalizations.of(context)!.message4,
                              AppLocalizations.of(context)!.message5,
                            ];

                            return ListTile(
                              leading: CircleAvatar(
                                backgroundImage: AssetImage(imagePaths[index]),
                              ),
                              title: Text(userNames[index]),
                              subtitle: Text(userMessages[index]),
                            );
                          },
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
}

// Video Player Widget (used in both normal and full-screen mode)
class VideoPlayerWidget extends StatefulWidget {
  final String videoPath;

  const VideoPlayerWidget({required this.videoPath});

  @override
  _VideoPlayerWidgetState createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset(widget.videoPath)
      ..initialize().then((_) {
        setState(() {});
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_controller.value.isInitialized) {
      return const Center(child: CircularProgressIndicator());
    }
    return AspectRatio(
      aspectRatio: _controller.value.aspectRatio,
      child: VideoPlayer(_controller),
    );
  }
}

