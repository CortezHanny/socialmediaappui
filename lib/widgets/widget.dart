import 'package:flutter/material.dart';

Widget buildProfileIcon(String url) {
  return Stack(
    alignment: Alignment.bottomCenter,
    clipBehavior: Clip.none,
    children: [
      Container(
        padding: const EdgeInsets.all(1),
        decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
        child: CircleAvatar(radius: 22, backgroundImage: NetworkImage(url)),
      ),
      Positioned(
        bottom: -10,
        child: Container(
          decoration: const BoxDecoration(color: Colors.pink, shape: BoxShape.circle),
          child: const Icon(Icons.add, color: Colors.white, size: 18),
        ),
      )
    ],
  );
}

Widget _buildActionButton(IconData icon, String label, Color color) {
  return Column(
    children: [
      Icon(icon, color: color, size: 38),
      const SizedBox(height: 5),
      Text(label, style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w600)),
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
