import 'package:flutter/material.dart';

class ImageNetwork extends StatelessWidget {
  const ImageNetwork({super.key});
  final url =
      'https://firebasestorage.googleapis.com/v0/b/musicapp-76f80.appspot.com/o/users%2F1600w-IqU7hAqANz4.jpg?alt=media&token=0d92de7e-bf0b-44a1-8a6c-ea239096a046';
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Image(image: NetworkImage(url)));
  }
}
