import 'package:flutter/material.dart';
import 'package:musix/data/model/songs_model.dart';
import 'package:musix/services/category_operation.dart';
import 'package:musix/services/song_operation.dart';
import 'package:musix/data/model/category.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  Widget creatAppBar(String message) {
    return AppBar(
      title: Text(message),
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Padding(
            padding: EdgeInsets.only(right: 8),
            child: Icon(
              Icons.settings,
              color: Colors.black,
              size: 30,
            ),
          ),
        )
      ],
      backgroundColor: Colors.transparent,
      elevation: 0,
    );
  }

  Widget createCategory(Category category) {
    return Container(
      color: Colors.blueGrey.shade400,
      child: Row(
        children: [
          Image.network(
            category.imageUrl!,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Text(category.name!),
          ),
        ],
      ),
    );
  }

  List<Widget> createListOfCategory() {
    List<Category> categoryList = CategoryOperation.getCategory();
    List<Widget> categories = categoryList
        .map((Category category) => createCategory(category))
        .toList();
    return categories;
  }

  Widget createGrid() {
    return SizedBox(
      height: 200,
      child: Padding(
        padding: const EdgeInsets.only(left: 8, right: 8),
        child: GridView.count(
          crossAxisSpacing: 4,
          mainAxisSpacing: 4,
          crossAxisCount: 2,
          childAspectRatio: 5 / 2,
          children: createListOfCategory(),
        ),
      ),
    );
  }

  Widget createMusic(SongModel song) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 100,
            width: 100,
            child: Image.network(
              song.thumbnail_url,
              fit: BoxFit.cover,
            ),
          ),
          Text(
            song.title,
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold),
          ),
          Text(
            song.artist,
            style: const TextStyle(color: Colors.white),
          )
        ],
      ),
    );
  }

  Widget createMusicList(String label) {
    List<SongModel> songList = MusicOperation.getMusic();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
              fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        SizedBox(
          height: 150,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: songList.length,
            itemBuilder: (BuildContext context, int index) {
              return createMusic(songList[index]);
            },
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [Colors.blueGrey.shade300, Colors.black],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight)),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            creatAppBar('Good Morning'),
            const SizedBox(
              height: 10,
            ),
            createGrid(),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: createMusicList('Made For You'),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, top: 5),
              child: createMusicList('Playlist For You'),
            )
          ],
        ),
      ),
    ));
  }
}
