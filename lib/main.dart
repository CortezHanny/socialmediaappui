import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// 1. DATA MODEL
class Post {
  final String username;
  final String userImage;
  final String dramaTitle;
  final String postImage;
  final String caption;
  final int likes;
  final String audioName;

  Post({
    required this.username,
    required this.userImage,
    required this.dramaTitle,
    required this.postImage,
    required this.caption,
    required this.likes,
    required this.audioName,
  });
}

// 2. MOCK DATA (Your Kdrama Trends)
final List<Post> kdramaPosts = [
  Post(
    username: "kdrama_queen",
    userImage: "https://i.pravatar.cc/150?u=1",
    dramaTitle: "Business Proposal",
    postImage: "https://wallpapers.com/images/hd/business-proposal-kdrama-poster-x0rod0gmpuznd9bz.jpg",
    caption: "The chemistry in this scene was unmatched! 💍 #businessproposal #kdrama",
    likes: 4500,
    audioName: "Love, Maybe - MeloMance",
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
    username: "sol_sunjae_fan",
    userImage: "https://i.pravatar.cc/150?u=12",
    dramaTitle: "Lovely Runner",
    postImage: "https://static1.srcdn.com/wordpress/wp-content/uploads/2024/05/lovely-runner-2024.jpg",
    caption: "Would you travel back in time to save the person you love? 🕒💛 This drama is pure perfection! #LovelyRunner #ByeonWooSeok #KimHyeYoon",
    likes: 32100,
    audioName: "Sudden Shower - ECLIPSE",
  ),
];

void main() {
  runApp(const MyApp());
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
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      // 1. Extend the body behind the App Bar
      extendBodyBehindAppBar: true,
      // 2. Add the transparent App Bar with "Following | For You"
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Following',
                style: TextStyle(fontSize: 16, color: Colors.white60)),
            SizedBox(width: 15),
            Text('For You',
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: Colors.white)),
          ],
        ),
      ),
      body: PageView.builder(
        scrollDirection: Axis.vertical, // TikTok Style scroll
        itemCount: kdramaPosts.length,
        itemBuilder: (context, index) {
          final post = kdramaPosts[index];
          return Stack(
            children: [
              // Post Image Background
              SizedBox.expand(
                child: Image.network(post.postImage, fit: BoxFit.cover),
              ),
              // Overlay for better text visibility
              Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.black54, Colors.transparent, Colors.black87],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),
              // UI elements (Right side actions)
              Positioned(
                right: 15,
                bottom: 100,
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 25,
                      backgroundColor: Colors.white,
                      child: CircleAvatar(
                          radius: 24,
                          backgroundImage: NetworkImage(post.userImage)
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Icon(Icons.favorite, color: Colors.red, size: 40),
                    Text('${post.likes}', style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                    const SizedBox(height: 20),
                    const Icon(Icons.comment, color: Colors.white, size: 40),
                    const Text('821', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                    const SizedBox(height: 20),
                    const Icon(Icons.share, color: Colors.white, size: 35),
                  ],
                ),
              ),
              // Post Description
              Positioned(
                left: 15,
                bottom: 40,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("@${post.username}",
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.white)),
                    const SizedBox(height: 5),
                    Text(post.dramaTitle,
                        style: const TextStyle(color: Colors.pinkAccent, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 5),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: Text(post.caption,
                          style: const TextStyle(fontSize: 14, color: Colors.white)),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        const Icon(Icons.music_note, size: 15, color: Colors.white),
                        const SizedBox(width: 5),
                        Text(post.audioName,
                            style: const TextStyle(fontSize: 13, color: Colors.white)),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
      // Optional: Add Bottom Navigation Bar for better TikTok look
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Discover'),
          BottomNavigationBarItem(icon: Icon(Icons.add_box, size: 30), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.message), label: 'Inbox'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}

class KdramaVideoTile extends StatelessWidget {
  final Post post;
  const KdramaVideoTile({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // 1. IMAGE BACKGROUND
        SizedBox.expand(
          child: Image.network(
            post.postImage,
            fit: BoxFit.cover,
          ),
        ),

        // 2. GRADIENT OVERLAY
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.black54, Colors.transparent, Colors.transparent, Colors.black87],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),

        // 3. HORIZONTAL TRENDING SCROLLVIEW
        Positioned(
          top: 100,
          left: 0,
          right: 0,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              children: ["#Trending", "#LeeMinHo", "#NewDrama", "#OST", "#Romance"].map((tag) {
                return Container(
                  margin: const EdgeInsets.only(right: 10),
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(tag, style: const TextStyle(fontSize: 12, color: Colors.white)),
                );
              }).toList(),
            ),
          ),
        ),

        // 4. RIGHT SIDE ACTION BUTTONS
        Positioned(
          right: 15,
          bottom: 110,
          child: Column(
            children: [
              _buildProfileIcon(post.userImage),
              const SizedBox(height: 20),
              _buildActionButton(Icons.favorite, post.likes.toString(), Colors.red),
              const SizedBox(height: 20),
              _buildActionButton(Icons.comment, "428", Colors.white),
              const SizedBox(height: 20),
              _buildActionButton(Icons.share, "Share", Colors.white),
              const SizedBox(height: 25),
              _buildMusicDisc(),
            ],
          ),
        ),

        // 5. BOTTOM CONTENT (TEXT & INFO)
        Positioned(
          left: 15,
          bottom: 30,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "@${post.username}",
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(height: 8),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.7,
                child: Text(
                  post.caption,
                  style: const TextStyle(color: Colors.white, fontSize: 14),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: Colors.pinkAccent.withOpacity(0.4),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.movie_filter, color: Colors.pinkAccent, size: 16),
                    const SizedBox(width: 5),
                    Text(
                      post.dramaTitle,
                      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  const Icon(Icons.music_note, color: Colors.white, size: 15),
                  const SizedBox(width: 5),
                  Text(post.audioName, style: const TextStyle(color: Colors.white, fontSize: 13)),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  // Helper Methods defined inside the class
  Widget _buildProfileIcon(String url) {
    return Stack(
      alignment: Alignment.bottomCenter,
      clipBehavior: Clip.none,
      children: [
        CircleAvatar(
          radius: 25,
          backgroundColor: Colors.white,
          child: CircleAvatar(
            radius: 23,
            backgroundImage: NetworkImage(url),
          ),
        ),
        Positioned(
          bottom: -5,
          child: Container(
            decoration: const BoxDecoration(color: Colors.pink, shape: BoxShape.circle),
            child: const Icon(Icons.add, color: Colors.white, size: 15),
          ),
        )
      ],
    );
  }

  Widget _buildActionButton(IconData icon, String label, Color color) {
    return Column(
      children: [
        Icon(icon, color: color, size: 35),
        const SizedBox(height: 5),
        Text(label, style: const TextStyle(color: Colors.white, fontSize: 12)),
      ],
    );
  }

  Widget _buildMusicDisc() {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        gradient: SweepGradient(colors: [Colors.grey.shade800, Colors.black]),
        shape: BoxShape.circle,
      ),
      child: const Icon(Icons.music_note, color: Colors.white, size: 20),
    );
  }
}