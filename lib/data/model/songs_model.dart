class SongsModel {
  String? uid;
  String? title;
  String? artist;
  String? url;
  String? albhumart;
  String? production;

  SongsModel(
      {this.uid,
      this.title,
      this.artist,
      this.url,
      this.albhumart,
      this.production});
  SongsModel.fromMap(Map<String, dynamic> map) {
    uid = map['uid'];
    title = map['title'];
    artist = map['artist'];
    url = map['url'];
    albhumart = map['albhumart'];
    production = map['production'];
  }

  Map<String, dynamic> toMap() {
    return {
      "uid": uid,
      "title": title,
      "artist": artist,
      "url": url,
      "albhumart": albhumart,
      "production": production
    };
  }
}
