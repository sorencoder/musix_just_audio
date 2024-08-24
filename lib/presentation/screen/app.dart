import 'package:flutter/material.dart';
import 'package:musix/data/model/songs_model.dart';
import 'package:musix/presentation/screen/homepage.dart';
import 'package:musix/presentation/screen/library_screen.dart';
import 'package:musix/presentation/screen/recent_release_screen.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  SongModel? song;
  int _currentIndex = 0;

  miniPlayer(SongModel? song) {
    if (song == null) {
      return const SizedBox();
    }
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      color: Colors.blueGrey,
      width: MediaQuery.of(context).size.width,
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.network(
            song.thumbnail_url,
            fit: BoxFit.cover,
          ),
          Text(
            song.title,
            style: const TextStyle(color: Colors.white),
          ),
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.play_arrow,
                color: Colors.white,
              ))
        ],
      ),
    );
  }

  final List<Widget> _screens = [
    const HomeScreen(),
    const RecentReleaseScreen(),
    const LibraryScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          miniPlayer(song),
          BottomNavigationBar(
            currentIndex: _currentIndex,
            onTap: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.history), label: 'Recent Release'),
              // BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.library_music), label: 'Library'),
            ],
          ),
        ],
      ),
    );
  }
}
