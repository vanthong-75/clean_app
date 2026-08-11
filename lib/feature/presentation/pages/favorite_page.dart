import 'package:clean_app/feature/presentation/components/product.dart';
// 📌 1. Import favorite_manager.dart ໃຫ້ຖືກຊື່ໄຟລ໌
import 'package:clean_app/feature/presentation/utils/favorite_manager.dart';
import 'package:flutter/material.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  @override
  Widget build(BuildContext context) {
    // 📌 2. ປ່ຽນຈາກ FavoritePage ເປັນ FavoriteManager.favoriteItems
    final favorites = FavoriteManager.favoriteItems;

    // ຖ້າບໍ່ມີລາຍການ
    if (favorites.isEmpty) {
      return const Center(
        child: Text(
          'ບໍ່ມີລາຍການທີ່ມັກ',
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),
      );
    }

    // ສະແດງລາຍການ
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 0.75,
        ),
        itemCount: favorites.length,
        itemBuilder: (context, index) {
          return ProductCard(item: favorites[index]);
        },
      ),
    );
  }
}