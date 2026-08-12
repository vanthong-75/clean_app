import 'dart:async';
import 'dart:convert';
import 'package:clean_app/feature/presentation/components/product.dart';
import 'package:clean_app/feature/presentation/layouts/profile.dart';
import 'package:clean_app/feature/presentation/pages/cart.dart';
import 'package:clean_app/feature/presentation/pages/favorite_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as api;

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;
  bool _isLoading = true; // ເພີ່ມ state ສໍາລັບເຊັກ loading

  final List<String> bannerImges = [
    'https://img.magnific.com/free-photo/make-up-brushes-copy-space-top-view_23-2148408348.jpg?semt=ais_hybrid&w=740&q=80',
    'https://static.vecteezy.com/system/resources/thumbnails/040/826/154/small/ai-generated-modern-glass-perfume-bottle-with-peony-flowers-on-empty-pale-pink-background-theme-a-wide-banner-with-copy-space-area-photo.jpeg',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRP_B9F2X_Uwye5wtRPlUuJLdoxPKLm0ljZSQ8BEggJUpZwgpEDp6eQVVM&s',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQN3j3ViMNQI_u0OSQg9DSMUJam8-blGPdw7HM_2j5hjGgfXgXJ3Hzxud8&s',
    'https://static.vecteezy.com/system/resources/thumbnails/053/781/384/small/bottle-of-pink-perfume-cosmetic-free-photo.jpg',
  ];

  final PageController _pageController = PageController();
  int _currentPage = 0;
  Timer? _timer;

  // 📌 ແກ້ໄຂ: ດຶງຂໍ້ມູນ API
  Future<void> showData() async {
    try {
      final res = await api.get(Uri.parse('http://192.168.72.1:3001/products'), headers: {
        "Authorization": "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiI2YTc0MTVhMTA2ZDdmNWQ4ZDNjYzQ2OGIiLCJlbWFpbCI6ImJyaWNoQGV4YW1wbGUuY29tIiwicm9sZSI6ImFkbWluIiwiaWF0IjoxNzg2NTA3Mjg2LCJleHAiOjE3ODY1OTM2ODZ9.OEAWlAqagvLGC06EcJCn_z-Dkx3ebFeT6RMKaTP9lOc" 
      });
      if (res.statusCode == 200) {
        // ຖອກ await ອອກຈາກ json.decode()
        final List resdata = json.decode(res.body); 
        setState(() {
          ProductData.products = List<Map<String, dynamic>>.from(resdata);
          _isLoading = false; // ໂຫຼດຂໍ້ມູນເສັດແລ້ວ
        });
        print("Data loaded successfully: ${ProductData.products.length} items");
      } else {
        setState(() {
          _isLoading = false;
        });
        print("Failed to load data, Status code: ${res.statusCode}");
      }
    } catch (error) {
      setState(() {
        _isLoading = false;
      });
      print("Error fetching data: $error");
    }
  }

  @override
  void initState() {
    super.initState();
    showData();

    // ຕັ້ງເວລາໃຫ້ສະຫຼັບຮູບອັດໂນມັດທຸກໆ 3 ວິນາທີ
    _timer = Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      if (_currentPage < bannerImges.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }

      if (_pageController.hasClients) {
        _pageController.animateToPage(
          _currentPage,
          duration: const Duration(milliseconds: 350),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel(); // ຄືນ Memory ເມື່ອປ່ຽນໜ້າ
    _pageController.dispose();
    super.dispose();
  }

  // 📌 UI ສໍາລັບໜ້າ Product Main Page
  Widget productPage() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Column(
        children: [
          // Search Bar
          Row(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: const Color.fromARGB(255, 220, 215, 215),
                  ),
                  child: const TextField(
                    decoration: InputDecoration(
                      hintText: 'Search ideas...',
                      hintStyle: TextStyle(
                        color: Color.fromARGB(255, 71, 63, 63),
                        fontSize: 14,
                      ),
                      prefixIcon: Icon(
                        Icons.search,
                        color: Color.fromARGB(255, 71, 63, 63),
                      ),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Container(
                width: 48,
                height: 48,
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 220, 215, 215),
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.tune, color: Colors.black),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Banner Slider
          SizedBox(
            height: 160,
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: (int page) {
                setState(() {
                  _currentPage = page;
                });
              },
              itemCount: bannerImges.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 4.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                      image: NetworkImage(bannerImges[index]),
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: 10),

          // Page Indicator
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              bannerImges.length,
              (index) => AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                margin: const EdgeInsets.symmetric(horizontal: 3),
                height: 8,
                width: _currentPage == index ? 20 : 8,
                decoration: BoxDecoration(
                  color: _currentPage == index
                      ? const Color(0xFFE07A5F)
                      : Colors.grey.shade400,
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),

          // 📌 Product Grid Display (ພ້ອມ Loading Check)
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : ProductData.products.isEmpty
                    ? const Center(child: Text("ບໍ່ມີຂໍ້ມູນສິນຄ້າ"))
                    : GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 12,
                          childAspectRatio: 0.75,
                        ),
                        itemCount: ProductData.products.length,
                        itemBuilder: (context, index) {
                          final item = ProductData.products[index];
                          return ProductCard(item: item);
                        },
                      ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // 📌 ແກ້ໄຂ: ຍ້າຍ List ຂອງ Pages ມາໄວ້ໃນ build() ເພື່ອໃຫ້ມັນ Re-build ຄ່າໃໝ່ສະເໝີ
    final List<Widget> pages = [
      productPage(),
      const Cart(),
      const FavoritePage(),
      const Placeholder(),
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 235, 147, 147),
        leading: Padding(
          padding: const EdgeInsets.all(5),
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Profile()),
              );
            },
            child: const CircleAvatar(
              radius: 20,
              backgroundImage: NetworkImage(
                'https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=150',
              ),
            ),
          ),
        ),
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Delivery location",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            Row(
              children: [
                Icon(Icons.location_on, size: 16),
                SizedBox(width: 4),
                Text("Columbus, Ohio, USA", style: TextStyle(fontSize: 14)),
              ],
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: CircleAvatar(
              backgroundColor: Colors.white,
              child: IconButton(
                onPressed: () {},
                icon: const Icon(Icons.notifications_none),
              ),
            ),
          ),
        ],
      ),
      body: pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xFFE07A5F),
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag_outlined),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border),
            label: 'Favorite',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'History',
          ),
        ],
      ),
    );
  }
}