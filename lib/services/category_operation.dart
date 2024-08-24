import 'package:musix/data/model/category.dart';

class CategoryOperation {
  CategoryOperation._();
  static List<Category> getCategory() {
    return <Category>[
      Category(
          name: 'Top Song',
          imageUrl:
              'https://is1-ssl.mzstatic.com/image/thumb/Purple126/v4/44/17/3c/44173c67-fc77-2bc3-a54e-c275c89f71bd/AppIcon-0-1x_U007emarketing-0-7-0-85-220.png/256x256bb.jpg'),
      Category(
          name: 'MJ Song',
          imageUrl: 'https://a.wattpad.com/useravatar/MJCHicen.256.687099.jpg'),
      Category(
          name: 'Top Song',
          imageUrl:
              'https://is1-ssl.mzstatic.com/image/thumb/Purple126/v4/44/17/3c/44173c67-fc77-2bc3-a54e-c275c89f71bd/AppIcon-0-1x_U007emarketing-0-7-0-85-220.png/256x256bb.jpg'),
      Category(
          name: 'MJ Song',
          imageUrl: 'https://a.wattpad.com/useravatar/MJCHicen.256.687099.jpg'),
    ];
  }
}
