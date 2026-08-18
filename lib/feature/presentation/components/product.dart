import 'package:clean_app/feature/presentation/pages/product_detail.dart';

import 'package:clean_app/feature/presentation/utils/favorite_manager.dart';

import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

// 1. Class ເກັບຂໍ້ມູນ

class ProductData {
  static List<Map<String, dynamic>> products = [
    // {

    //   "name": "productA",

    //   "price": 20000,

    //   "proPrice": 15000,

    //   "image": "https://static.vecteezy.com/system/resources/thumbnails/055/088/397/small_2x/elegant-perfume-bottle-surrounded-by-delicate-pink-flowers-on-a-marble-surface-photo.jpg",

    // },

    // {

    //   "name": "productB",

    //   "price": 20000,

    //   "proPrice": 15000,

    //   "image": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQN3j3ViMNQI_u0OSQg9DSMUJam8-blGPdw7HM_2j5hjGgfXgXJ3Hzxud8&s",

    // },

    // {

    //   "name": "productC",

    //   "price": 20000,

    //   "proPrice": 15000,

    //   "image": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS6u4-ik-V1Nbgqok0iZqAx5FnVtKVV98Y1bTwH7r0zQA&s=10",

    // },

    // {

    //   "name": "productD",

    //   "price": 20000,

    //   "proPrice": 15000,

    //   "image": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSas4m8RDtWQJwUZTQSLxa1zuD56teAOklgyGJflTvOYg&s=10",

    // },

    // {

    //   "name": "productE",

    //   "price": 20000,

    //   "proPrice": 15000,

    //   "image": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRM1Oo0b7-aOB4ULDuRiGv2mOA8Az9K6vEtzRbkxqRUwA&s=10",

    // },

    // {

    //   "name": "productF",

    //   "price": 20000,

    //   "proPrice": 15000,

    //   "image": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTRrGumFsM5dW8k8m2bzoSMXhDCtFLtVrXSqqTjTNxFRQ&s=10",

    // },
  ];
}

// 2. Component Widget ສໍາລັບສະແດງຜົນ Card ສິນຄ້າ

// 2. Component Widget ສໍາລັບສະແດງຜົນ Card ສິນຄ້າ
class ProductCard extends StatefulWidget {
  final Map<String, dynamic> item;

  const ProductCard({super.key, required this.item});

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  bool isFavorite = false;
  final NumberFormat formatter = NumberFormat('#,##0');

  @override
  Widget build(BuildContext context) {
    // =========================================================
    // 💡 1. ດຶງຄ່າຈາກ widget.item ມາປະກາດຕົວແປໄວ້ບ່ອນນີ້ກ່ອນ
    // =========================================================
    final num price = widget.item['price'] ?? 0;
    final num proPrice = widget.item['proPrice'] ?? 0;

    // ຖ້າ Backend ສົ່ງ finalPrice ມາໃຫ້ແລ້ວ ໃຫ້ໃຊ້ finalPrice ເລີຍ, 
    // ຖ້າບໍ່ມີ ຈຶ່ງຄິດໄລ່ເອງ: ຖ້າ proPrice > 0 ໃຫ້ໃຊ້ proPrice, ຖ້າບໍ່ມີໃຫ້ໃຊ້ price
    final num finalPrice = widget.item['finalPrice'] ??
        ((proPrice > 0) ? proPrice : price);

    // ກວດສອບວ່າ ມີສ່ວນຫຼຸດແທ້ໆບໍ
    final bool hasDiscount = widget.item['hasDiscount'] ??
        (proPrice > 0 && proPrice < price);

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetail(
              name: widget.item['name'] ?? '',
              images: widget.item['image'] ?? '',
              price: widget.item[finalPrice], // ສົ່ງ finalPrice ໄປໃຫ້ໜ້າ Detail
            ),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.15),
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // -------------------------------------------------
            // ຮູບພາບສິນຄ້າ
            // -------------------------------------------------
            Expanded(
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(12),
                ),
                child: Image.network(
                  widget.item['image'] ?? '',
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) =>
                      const Center(child: Icon(Icons.broken_image, size: 40)),
                ),
              ),
            ),

            // -------------------------------------------------
            // ລາຍລະອຽດ: ຊື່, ລາຄາ ແລະ ປຸ່ມ Favorite
            // -------------------------------------------------
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ຊື່ສິນຄ້າ
                  Text(
                    widget.item['name'] ?? 'ບໍ່ມີຊື່ສິນຄ້າ',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 6),

                  // ລາຄາ ແລະ ສ່ວນຫຼຸດ
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          // ສະແດງ ລາຄາສຸດທ້າຍ (finalPrice)
                          Text(
                            '${formatter.format(finalPrice)} ₭',
                            style: TextStyle(
                              color: hasDiscount
                                  ? Colors.redAccent
                                  : Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                            ),
                          ),
                          if (hasDiscount) ...[
                            const SizedBox(width: 6),
                            // ສະແດງ ລາຄາເກົ່າແບບຂີດຂ້າ
                            Text(
                              '${formatter.format(price)} ₭',
                              style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 11,
                                decoration: TextDecoration.lineThrough,
                              ),
                            ),
                          ],
                        ],
                      ),

                      // ປຸ່ມ Favorite
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            isFavorite = !isFavorite;
                            FavoriteManager.toggleFavorite(widget.item);
                          });
                        },
                        child: Icon(
                          isFavorite
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: isFavorite ? Colors.pinkAccent : Colors.grey,
                          size: 20,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
