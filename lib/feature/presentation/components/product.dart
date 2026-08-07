import 'package:flutter/material.dart';

// 1. Class ເກັບຂໍ້ມູນ
class ProductData {
  static List<Map<String, dynamic>> products = [
    {
      "name": "productA", 
      "price": 20000,
      "proPrice": 15000,
      "image": "https://static.vecteezy.com/system/resources/thumbnails/055/088/397/small_2x/elegant-perfume-bottle-surrounded-by-delicate-pink-flowers-on-a-marble-surface-photo.jpg",
    },
    {
      "name": "productB",
      "price": 20000,
      "proPrice": 15000,
      "image": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQN3j3ViMNQI_u0OSQg9DSMUJam8-blGPdw7HM_2j5hjGgfXgXJ3Hzxud8&s",
    },
    {
      "name": "productC",
      "price": 20000,
      "proPrice": 15000,
      "image": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS6u4-ik-V1Nbgqok0iZqAx5FnVtKVV98Y1bTwH7r0zQA&s=10",
    },
    {
      "name": "productD",
      "price": 20000,
      "proPrice": 15000,
      "image": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSas4m8RDtWQJwUZTQSLxa1zuD56teAOklgyGJflTvOYg&s=10",
    },
    {
      "name": "productE",
      "price": 20000,
      "proPrice": 15000,
      "image": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRM1Oo0b7-aOB4ULDuRiGv2mOA8Az9K6vEtzRbkxqRUwA&s=10",
    },
    {
      "name": "productF",
      "price": 20000,
      "proPrice": 15000,
      "image": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTRrGumFsM5dW8k8m2bzoSMXhDCtFLtVrXSqqTjTNxFRQ&s=10",
    },
  ];
}

// 2. Component Widget ສໍາລັບສະແດງຜົນ Card ສິນຄ້າ
class ProductCard extends StatelessWidget {
  final Map<String, dynamic> item;

  const ProductCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
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
          // ຮູບພາບສິນຄ້າ
          Expanded(
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
              child: Image.network(
                item['image'] ?? '',
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) =>
                    const Center(child: Icon(Icons.broken_image, size: 40)),
              ),
            ),
          ),
          // ລາຍລະອຽດ ຊື່ ແລະ ລາຄາ
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item['name'] ?? '',
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Text(
                      '${item['proPrice']} ₭',
                      style: const TextStyle(
                        color: Colors.redAccent,
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      '${item['price']} ₭',
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 11,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}