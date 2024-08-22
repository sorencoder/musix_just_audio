import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:musix/logic/provider/audio_provider.dart';

import 'package:musix/presentation/screen/songpage.dart';
import 'package:provider/provider.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Musix'),
        centerTitle: true,
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('songs').snapshots(),
          initialData: 0,
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              if (snapshot.hasData) {
                return GridView.builder(
                  scrollDirection: Axis.vertical,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, childAspectRatio: 1.8),
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (BuildContext context, int index) {
                    Map<String, dynamic> songs = snapshot.data!.docs[index]
                        .data() as Map<String, dynamic>;
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Songpage(
                                        title: songs['title'],
                                        artist: songs['artist'],
                                        url: songs['url'],
                                      )));
                          Provider.of<AudioProvider>(context, listen: false)
                              .setUrl(songs['url']);
                        },
                        title: Text(songs['title']),
                        subtitle: Text(songs['artist']),
                      ),
                    );
                  },
                );
              } else {
                return const Center(
                  child: Text('No data!'),
                );
              }
            }
          }),
    );
  }
}
