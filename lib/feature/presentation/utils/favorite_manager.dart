class FavoriteManager {
  // List ເກັບສິນຄ້າທີ່ກົດໃຈໄວ້ຊົ່ວຄາວ
  static List<Map<String, dynamic>> favoriteItems = [];

  // ຟັງຊັນເພີ່ມ ຫຼື ລົບ ສິນຄ້າ
  static void toggleFavorite(Map<String, dynamic> item) {
    if (isFavorite(item)) {
      favoriteItems.removeWhere((element) => element['name'] == item['name']);
    } else {
      favoriteItems.add(item);
    }
  }

  // ຟັງຊັນເຊັກວ່າສິນຄ້ານີ້ຖືກກົດໃຈໄວ້ແລ້ວບໍ
  static bool isFavorite(Map<String, dynamic> item) {
    return favoriteItems.any((element) => element['name'] == item['name']);
  }
}