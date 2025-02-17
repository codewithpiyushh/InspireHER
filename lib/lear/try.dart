import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/gestures.dart';
import '../l10n/app_localizations.dart';

class LearnScreen extends StatefulWidget {
  const LearnScreen({super.key});

  @override
  State<LearnScreen> createState() => _LearnScreenState();
}

Future<void> saveSelectedBusiness(String business) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('selected_business', business);
}

Future<String?> getSelectedBusiness() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString('selected_business');
}

class _LearnScreenState extends State<LearnScreen> {
  final videoURL = "https://www.youtube.com/watch?v=69dCjNmj5H0";
  late YoutubePlayerController _controller;
  String? videoId;

  late List<Blog> blogs;

  @override
  void initState() {
    super.initState();
    videoId = YoutubePlayer.convertUrlToId(videoURL);
    if (videoId != null) {
      _controller = YoutubePlayerController(
        initialVideoId: videoId!,
        flags: const YoutubePlayerFlags(
          autoPlay: false,
          mute: false,
          showLiveFullscreenButton: false,
        ),
      );
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    blogs = [
      Blog(
        title: AppLocalizations.of(context)!.title1,
        author: AppLocalizations.of(context)!.author1,
        imagePath: 'assets/image7.jpg',
      ),
      Blog(
        title: AppLocalizations.of(context)!.title2,
        author: AppLocalizations.of(context)!.author2,
        imagePath: 'assets/image2.jpg',
      ),
      Blog(
        title: AppLocalizations.of(context)!.title3,
        author: AppLocalizations.of(context)!.author3,
        imagePath: 'assets/image3.jpeg',
      ),
      Blog(
        title: AppLocalizations.of(context)!.title4,
        author: AppLocalizations.of(context)!.author4,
        imagePath: 'assets/image4.jpg',
      ),
      Blog(
        title: AppLocalizations.of(context)!.title5,
        author: AppLocalizations.of(context)!.author5,
        imagePath: 'assets/image5.webp',
      ),
    ];
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.learnTitle,
                      style: const TextStyle(
                          fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 20),
                    GestureDetector(
                      onTap: () {
                        _showMessageBottomSheet(context);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 12),
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.mic, color: Colors.grey[600]),
                            const SizedBox(width: 12),
                            Text(
                              AppLocalizations.of(context)!.writeMessage,
                              style: TextStyle(color: Colors.grey[600]),
                            ),
                            const Spacer(),
                            Icon(Icons.send, color: Colors.grey[600]),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.financialCourses,
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: Text(AppLocalizations.of(context)!.seeAll),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          _buildChip(AppLocalizations.of(context)!.all, true),
                          _buildChip(AppLocalizations.of(context)!.financialLiteracy, false),
                          _buildChip(AppLocalizations.of(context)!.microInvestment, false),
                          _buildChip(AppLocalizations.of(context)!.creditUse, false),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              if (videoId != null)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: YoutubePlayer(
                          controller: _controller,
                          showVideoProgressIndicator: true,
                          progressIndicatorColor: Colors.amber,
                          progressColors: const ProgressBarColors(
                            playedColor: Colors.amber,
                            handleColor: Colors.amberAccent,
                          ),
                          onReady: () {
                            print('Player is ready.');
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              const SizedBox(height: 20),
              BlogSection(blogs: blogs),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildChip(String label, bool isSelected) {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      child: Chip(
        label: Text(
          label,
          style: TextStyle(
            color:
                isSelected ? const Color.fromARGB(255, 0, 0, 0) : Colors.black,
          ),
        ),
        backgroundColor: isSelected
            ? const Color.fromARGB(255, 71, 160, 238)
            : Colors.grey[200],
      ),
    );
  }

  void _showMessageBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const ChatScreen(),
    );
  }
}

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  List<Map<String, String>> messages = [];

  String getApiUrl(String message) {
    if (message.contains("schemes") ||
        message.contains("government") ||
        message.contains("fund") ||
        message.contains("loan")) {
      return "http://192.168.1.33:5001/chat";
    }
    return "http://192.168.1.33:5000/chat";
  }

  void _sendMessage(String message) async {
    if (message.trim().isEmpty) return;

    setState(() {
      messages.add({'sender': 'user', 'text': message});
    });

    _controller.clear();
    FocusScope.of(context).unfocus();

    try {
      var response = await http
          .post(
            Uri.parse(getApiUrl(message)),
            headers: {"Content-Type": "application/json"},
            body: jsonEncode({"query": message}),
          )
          .timeout(const Duration(seconds: 15));

      if (response.statusCode == 200) {
        var responseData = jsonDecode(response.body);
        String botReply =
            responseData['response']?.toString().trim() ?? "No response";

        botReply = botReply.replaceAll(RegExp(r"\[.*?\]"), "");
        botReply = botReply.replaceAll("\\n", "\n");
        botReply = botReply.replaceAllMapped(
            RegExp(r"\*\*(.*?)\*\*"), (match) => match.group(1)!);

        setState(() {
          messages.add({'sender': 'bot', 'text': botReply});
        });
      } else {
        setState(() {
          messages.add({
            'sender': 'bot',
            'text': "Oops! Something went wrong. Please try again."
          });
        });
      }
    } catch (e) {
      setState(() {
        messages.add({
          'sender': 'bot',
          'text': "Connection error. Please check your internet."
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chatbot'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final msg = messages[index];
                bool isUser = msg['sender'] == 'user';
                return Align(
                  alignment:
                      isUser ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: isUser
                          ? const Color.fromARGB(255, 112, 154, 217)
                          : const Color.fromARGB(255, 93, 92, 92),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: _buildMessageContent(msg['text'] ?? ''),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _optionButton("Learn", "How to start dairy business"),
                _optionButton("Schemes",
                    "What government schemes are available for dairy business?"),
                _optionButton("Finance",
                    "Guide me on financial planning on dairy business."),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: 'Type your message...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                FloatingActionButton(
                  onPressed: () => _sendMessage(_controller.text),
                  backgroundColor: Colors.blueAccent,
                  child: const Icon(Icons.send),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _optionButton(String title, String message) {
    return ElevatedButton(
      onPressed: () => _sendMessage(message),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blueAccent,
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      child: Text(title,
          style: const TextStyle(color: Color.fromARGB(255, 0, 0, 0))),
    );
  }
}

Widget _buildMessageContent(String text) {
  final urlRegExp = RegExp(r"(https?://\S+)");

  List<InlineSpan> spans = [];

  text.splitMapJoin(
    urlRegExp,
    onMatch: (match) {
      final url = match.group(0)!;
      spans.add(
        TextSpan(
          text: url,
          style: const TextStyle(
            color: Colors.blue,
            decoration: TextDecoration.underline,
          ),
          recognizer: TapGestureRecognizer()
            ..onTap = () async {
              if (await canLaunchUrl(Uri.parse(url))) {
                await launchUrl(Uri.parse(url));
              } else {
                throw 'Could not launch $url';
              }
            },
        ),
      );
      return url;
    },
    onNonMatch: (nonMatch) {
      spans.add(TextSpan(text: nonMatch));
      return nonMatch;
    },
  );

  return RichText(
    text: TextSpan(
      children: spans,
      style: const TextStyle(fontSize: 16),
    ),
  );
}

class Blog {
  final String title;
  final String author;
  final String imagePath;

  Blog({required this.title, required this.author, required this.imagePath});
}

class BlogSection extends StatelessWidget {
  final List<Blog> blogs;

  const BlogSection({super.key, required this.blogs});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Related Blogs',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    // TODO: Implement "Read All" navigation
                  },
                  child: const Text(
                    'Read All',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w800,
                      color: Color.fromARGB(255, 87, 156, 241),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Column(
              children: blogs.map((blog) {
                return _buildBlogItem(blog.title, blog.author, blog.imagePath);
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBlogItem(String title, String author, String imagePath) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 3,
      child: ListTile(
        contentPadding: const EdgeInsets.all(12),
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child:
              Image.asset(imagePath, width: 60, height: 60, fit: BoxFit.cover),
        ),
        title: Text(
          title,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
        ),
        subtitle: Text(
          'By $author',
          style: const TextStyle(fontSize: 12, color: Colors.grey),
        ),
        onTap: () {
          // Implement navigation to blog details screen
        },
      ),
    );
  }
}