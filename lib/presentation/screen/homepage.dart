import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musix/data/model/category.dart';
import 'package:musix/data/model/songs_model.dart';
import 'package:musix/logic/cubit/made_for_you/made_for_you_cubit.dart';
import 'package:musix/logic/cubit/playlist_cubit/playlist_cubit.dart';
import 'package:musix/logic/cubit/playlist_cubit/playlist_states.dart';
import 'package:musix/logic/provider/audio_provider.dart';
import 'package:musix/services/category_operation.dart';
import 'package:musix/logic/cubit/made_for_you/made_for_you_states.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  Widget createAppBar(String message) {
    return AppBar(
      title: Text(message),
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Padding(
            padding: EdgeInsets.only(right: 8),
            child: Icon(
              Icons.search,
              color: Colors.black,
              size: 30,
            ),
          ),
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.settings,
            color: Colors.black,
            size: 30,
          ),
        )
      ],
      backgroundColor: Colors.transparent,
      elevation: 0,
    );
  }

//grid view
  Widget createCategory(Category category) {
    return Container(
      color: Colors.blueGrey.shade400,
      child: Row(
        children: [
          // Image with fixed width and height
          Image.network(
            category.imageUrl!,
            width: 80, // Set a fixed width for the image
            height: 80, // Set a fixed height for the image
            fit: BoxFit.cover, // Adjust based on design needs
            errorBuilder: (context, error, stackTrace) {
              // Error handling if the image fails to load
              print(stackTrace);
              return const Center(child: Icon(Icons.error, color: Colors.red));
            },
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Material(
              type: MaterialType.transparency,
              child: Text(
                category.name!,
                overflow: TextOverflow.ellipsis, // Handle text overflow
                style: const TextStyle(
                  fontSize: 16, // Set text style as needed
                  color: Colors.white, // Set text color if needed
                ),
              ),
            ),
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
      height: 160,
      child: Padding(
        padding: const EdgeInsets.only(left: 8, right: 8),
        child: GridView.count(
          crossAxisSpacing: 4,
          mainAxisSpacing: 4,
          crossAxisCount: 2,
          childAspectRatio: 6 / 2,
          children: createListOfCategory(),
        ),
      ),
    );
  }

//made for you section
  Widget madeForYouMusic(SongModel song, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: InkWell(
        onTap: () {
          Provider.of<AudioProvider>(context, listen: false).setSource(song);
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 80,
              width: 80,
              child: Image.network(
                song.thumbnail_url,
                fit: BoxFit.cover,
              ),
            ),
            Material(
              type: MaterialType.transparency,
              child: SizedBox(
                width: 80,
                child: Text(
                  song.title,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ),
            Material(
              type: MaterialType.transparency,
              child: SizedBox(
                width: 80,
                child: Text(
                  song.artist,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget madeForYouList(String label) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Material(
          type: MaterialType.transparency,
          child: Text(
            label,
            style: const TextStyle(
                fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
        SizedBox(
          height: 130,
          child: BlocBuilder<MadeForYouCubit, MadeForYouStates>(
              builder: (context, state) {
            return ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: state.madeForYou.length,
              itemBuilder: (BuildContext context, int index) {
                final data = state.madeForYou[index];
                return madeForYouMusic(data, context);
              },
            );
          }),
        ),
      ],
    );
  }

  //playlist section
  Widget playListWidget(SongModel song) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 80,
            width: 80,
            child: Image.network(
              song.thumbnail_url,
              fit: BoxFit.cover,
            ),
          ),
          Material(
            type: MaterialType.transparency,
            child: SizedBox(
              width: 80,
              child: Text(
                song.title,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ),
          Material(
            type: MaterialType.transparency,
            child: SizedBox(
              width: 80,
              child: Text(
                song.artist,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(color: Colors.white),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget playList(String label) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Material(
          type: MaterialType.transparency,
          child: Text(
            label,
            style: const TextStyle(
                fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
        SizedBox(
          height: 150,
          child: BlocBuilder<PlaylistCubit, PlaylistStates>(
              builder: (context, state) {
            return ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: state.playlist.length,
              itemBuilder: (BuildContext context, int index) {
                final data = state.playlist[index];
                return playListWidget(data);
              },
            );
          }),
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
            createAppBar('Good Morning'),
            const SizedBox(
              height: 10,
            ),
            createGrid(),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: madeForYouList('Made For You'),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, top: 5),
              child: playList('Playlist For You'),
            )
          ],
        ),
      ),
    ));
  }
}
