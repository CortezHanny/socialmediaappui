import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:video_player/video_player.dart';// 1. DATA MODEL (Added videoUrl field)
class Post {
  final String username;
  final String userImage;
  final String dramaTitle;
  final String postImage;
  final String? videoUrl; // Optional: Only for video posts
  final String caption;
  final int likes;
  final String audioName;

  Post({
    required this.username,
    required this.userImage,
    required this.dramaTitle,
    required this.postImage,
    this.videoUrl, // Can be null
    required this.caption,
    required this.likes,
    required this.audioName,
  });
}

// 2. MOCK DATA (One video, the rest are images)
final List<Post> kdramaPosts = [
  Post(
    username: "kdrama_lover_2024",
    userImage: "https://i.pravatar.cc/150?u=5",
    dramaTitle: "Boyfriend On-Demand",
    videoUrl: "https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4", // This is a video post
    postImage: "https://th.bing.com/th?id=OIF.y%2fFwxunz0S15JTU8Nv8nbw&rs=1&pid=ImgDetMain",
    caption: "Imagine having a boyfriend on-demand... 🧸✨ #BoyfriendOnDemand",
    likes: 8900,
    audioName: "Sweet Romance - OST Part 1",
  ),
  Post(
    username: "oppa_central",
    userImage: "https://i.pravatar.cc/150?u=2",
    dramaTitle: "Twenty-Five Twenty-One",
    postImage: "https://images.justwatch.com/poster/261793906/s718/twenty-five-twenty-one.%7Bformat%7D",
    caption: "This show broke my heart into pieces. 😭 #2521 #namjoo-hyuk",
    likes: 12800,
    audioName: "Original Sound - DramaLover",
  ),
  Post(
    username: "vincenzo_fan",
    userImage: "https://i.pravatar.cc/150?u=3",
    dramaTitle: "Vincenzo",
    postImage: "https://tse4.mm.bing.net/th/id/OIP.eKpdBiuLe0MKAgkiXgQhqAHaKX?rs=1&pid=ImgDetMain&o=7&rm=3",
    caption: "Corn Salad! The legend is back. 🍷🔥 #vincenzo #songjoongki",
    likes: 9200,
    audioName: "Vincenzo Theme - OST",
  ),
  Post(
    username: "iu_fan_forever",
    userImage: "https://i.pravatar.cc/150?u=9",
    dramaTitle: "When Life Gives You Tangerines",
    postImage: "https://i.mydramalist.com/DkJ45N_3f.jpg",
    caption: "IU and Park Bo-gum in one frame? My heart can't take this! 🍊✨ #WhenLifeGivesYouTangerines #IU #ParkBoGum",
    likes: 25400,
    audioName: "Jeju Island - Folk Version",
  ),
  Post(
    username: "kdrama_queen",
    userImage: "https://i.pravatar.cc/150?u=1",
    dramaTitle: "Business Proposal",
    videoUrl: null, // This is a static image post
    postImage: "https://wallpapers.com/images/hd/business-proposal-kdrama-poster-x0rod0gmpuznd9bz.jpg",
    caption: "The chemistry in this scene was unmatched! 💍 #businessproposal",
    likes: 4500,
    audioName: "Love, Maybe - MeloMance",
  ),
  Post(
    username: "sol_sunjae_fan",
    userImage: "https://i.pravatar.cc/150?u=12",
    dramaTitle: "Lovely Runner",
    videoUrl: null, // This is a static image post
    postImage: "https://static1.srcdn.com/wordpress/wp-content/uploads/2024/05/lovely-runner-2024.jpg",
    caption: "Would you travel back in time to save the person you love? 🕒💛",
    likes: 32100,
    audioName: "Sudden Shower - ECLIPSE",
  ),
];

// --- UPDATED VIDEO/IMAGE TILE ---
class KdramaVideoTile extends StatefulWidget {
  final Post post;
  const KdramaVideoTile({super.key, required this.post});

  @override
  State<KdramaVideoTile> createState() => _KdramaVideoTileState();
}

class _KdramaVideoTileState extends State<KdramaVideoTile> {VideoPlayerController? _controller;
  bool _isInitialized = false;
  bool _isLiked = false;

  @override
  void initState() {
    super.initState();
    // Only initialize video if videoUrl is provided
    if (widget.post.videoUrl != null) {
      _controller = VideoPlayerController.networkUrl(Uri.parse(widget.post.videoUrl!))
        ..initialize().then((_) {
          if (mounted) {
            setState(() {
              _isInitialized = true;
              _controller!.setLooping(true);
              _controller!.play();
            });
          }
        });
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (_controller != null && _controller!.value.isInitialized) {
          setState(() {
            _controller!.value.isPlaying ? _controller!.pause() : _controller!.play();
          });
        }
      },
      child: Stack(
        children: [
          // BACKGROUND: Show Video if available and ready, otherwise show Image
          SizedBox.expand(
            child: (widget.post.videoUrl != null && _isInitialized)
                ? FittedBox(
              fit: BoxFit.cover,
              child: SizedBox(
                width: _controller!.value.size.width,
                height: _controller!.value.size.height,
                child: VideoPlayer(_controller!),
              ),
            )
                : Image.network(widget.post.postImage, fit: BoxFit.cover),
          ),

          // Play/Pause Overlay Icon (Only for videos)
          if (widget.post.videoUrl != null && _isInitialized && !_controller!.value.isPlaying)
            const Center(child: Icon(Icons.play_arrow, size: 80, color: Colors.white54)),

          // UI Overlays
          _buildGradientOverlay(),
          _buildPostDetails(context),
          _buildSideActions(),
        ],
      ),
    );
  }

  Widget _buildGradientOverlay() {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.black54, Colors.transparent, Colors.transparent, Colors.black87],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
    );
  }

  Widget _buildPostDetails(BuildContext context) {
    return Positioned(
      left: 15,
      bottom: 30,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("@${widget.post.username}", style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(height: 8),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.7,
            child: Text(widget.post.caption, style: const TextStyle(color: Colors.white, fontSize: 14)),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              const Icon(Icons.music_note, size: 15, color: Colors.white),
              const SizedBox(width: 5),
              Text(widget.post.audioName, style: const TextStyle(color: Colors.white, fontSize: 12)),
            ],
          )
        ],
      ),
    );
  }

Widget _buildSideActions() {
  return Positioned(
    right: 15,
    bottom: 30,
    child: Column(
      children: [// Like Button
        _buildActionButton(
          icon: _isLiked ? Icons.favorite : Icons.favorite,
          color: _isLiked ? Colors.red : Colors.white,
          label: widget.post.likes.toString(),
          onTap: () {
            setState(() {
              _isLiked = !_isLiked;
            });
          },
        ),
        // Comment Button
        _buildActionButton(
          icon: Icons.comment,
          label: "124",
          onTap: () => _showComments(context),
        ),
        _buildActionButton(
          icon: Icons.share,
          label: "Share",
          onTap: () {},
        ),
      ],
    ),
  );
}

// Modified helper to handle clicks and colors
Widget _buildActionButton({
  required IconData icon,
  required String label,
  required VoidCallback onTap,
  Color color = Colors.white,
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 10),
    child: GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Icon(icon, size: 35, color: color),
          const SizedBox(height: 5),
          Text(label, style: const TextStyle(color: Colors.white, fontSize: 12)),
        ],
      ),
    ),
  );
}

// --- COMMENT CHAT MODAL ---
void _showComments(BuildContext context) {
  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.grey[900],
    isScrollControlled: true, // Allows keyboard to push content up
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) {
      return Container(
        height: MediaQuery.of(context).size.height * 0.7,
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Text("Comments", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const Divider(color: Colors.white24),
            Expanded(
              child: ListView.builder(
                itemCount: 5,
                itemBuilder: (context, index) => ListTile(
                  leading: const CircleAvatar(backgroundColor: Colors.blueGrey),
                  title: Text("User $index", style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                  subtitle: const Text("This drama is so good! Can't wait for next episode.",
                      style: TextStyle(color: Colors.white70)),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Add a comment...",
                  hintStyle: const TextStyle(color: Colors.white54),
                  suffixIcon: const Icon(Icons.send, color: Colors.blue),
                  filled: true,
                  fillColor: Colors.white10,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(30), borderSide: BorderSide.none),
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
}
} // <--- THIS BRACE CLOSES THE _KdramaVideoTileState CLASS

// --- APP ENTRY POINT ---
void main() {
  runApp(const MyApp());
}

// --- COMMENT CHAT MODAL ---
void _showComments(BuildContext context) {
  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.grey[900],
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) {
      return Container(
        height: MediaQuery
            .of(context)
            .size
            .height * 0.6,
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Text("Comments",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const Divider(color: Colors.white24),
            Expanded(
              child: ListView.builder(
                itemCount: 5,
                itemBuilder: (context, index) =>
                    ListTile(
                      leading: const CircleAvatar(
                          backgroundColor: Colors.blueGrey),
                      title: Text("User $index", style: const TextStyle(
                          fontSize: 14, fontWeight: FontWeight.bold)),
                      subtitle: const Text(
                          "This drama is so good! Can't wait for next episode.",
                          style: TextStyle(color: Colors.white70)),
                    ),
              ),
            ),
            // Fake Input Field
            Container(
              padding: EdgeInsets.only(bottom: MediaQuery
                  .of(context)
                  .viewInsets
                  .bottom),
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Add a comment...",
                  hintStyle: const TextStyle(color: Colors.white54),
                  suffixIcon: const Icon(Icons.send, color: Colors.blue),
                  filled: true,
                  fillColor: Colors.white10,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide.none),
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        textTheme: GoogleFonts.plusJakartaSansTextTheme(ThemeData.dark().textTheme),
      ),
      home: const MainNavigation(),
    );
  }
}

// --- MAIN NAVIGATION ---
class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(),
    const Center(child: Text("Discover")),
    const Center(child: Text("Upload")),
    const Center(child: Text("Inbox")),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        currentIndex: _selectedIndex,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.explore_outlined), label: 'Discover'),
          BottomNavigationBarItem(icon: Icon(Icons.add_box, size: 40), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.chat_bubble_outline), label: 'Inbox'),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'Profile'),
        ],
      ),
    );
  }
}

// --- HOME SCREEN ---
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Following', style: TextStyle(fontSize: 16, color: Colors.white60)),
            SizedBox(width: 15),
            Text('For You', style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: Colors.white)),
          ],
        ),
      ),
      body: PageView.builder(
        scrollDirection: Axis.vertical,
        itemCount: kdramaPosts.length,
        itemBuilder: (context, index) {
          return KdramaVideoTile(post: kdramaPosts[index]);
        },
      ),
    );
  }
}

// --- PROFILE SCREEN ---
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("My Profile"),
        backgroundColor: Colors.black,
        centerTitle: true,
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          const CircleAvatar(
            radius: 50,
            backgroundImage: NetworkImage("https://i.pravatar.cc/150?u=9"),
          ),
          const SizedBox(height: 15),
          const Text("@kdrama_fan", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 25),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _StatTile(label: "Following", value: "128"),
              _StatTile(label: "Followers", value: "5.2k"),
              _StatTile(label: "Likes", value: "12k"),
            ],
          ),
          const SizedBox(height: 20),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(2),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 0.8,
                crossAxisSpacing: 2,
                mainAxisSpacing: 2,
              ),
              itemCount: 12,
              itemBuilder: (context, index) => Container(
                color: Colors.grey[900],
                child: const Icon(Icons.play_arrow_outlined, color: Colors.white24),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class _StatTile extends StatelessWidget {
  final String label;
  final String value;
  const _StatTile({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        Text(label, style: const TextStyle(color: Colors.grey, fontSize: 13)),
      ],
    );
  }
}
