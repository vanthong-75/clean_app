import 'dart:async';
import 'package:clean_app/feature/presentation/layouts/profile.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;

  final List<String> bannerImges = [
    'https://img.magnific.com/free-photo/make-up-brushes-copy-space-top-view_23-2148408348.jpg?semt=ais_hybrid&w=740&q=80',
    'https://static.vecteezy.com/system/resources/thumbnails/040/826/154/small/ai-generated-modern-glass-perfume-bottle-with-peony-flowers-on-empty-pale-pink-background-theme-a-wide-banner-with-copy-space-area-photo.jpeg',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRP_B9F2X_Uwye5wtRPlUuJLdoxPKLm0ljZSQ8BEggJUpZwgpEDp6eQVVM&s',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQN3j3ViMNQI_u0OSQg9DSMUJam8-blGPdw7HM_2j5hjGgfXgXJ3Hzxud8&s',
    'https://static.vecteezy.com/system/resources/thumbnails/053/781/384/small/bottle-of-pink-perfume-cosmetic-free-photo.jpg',
  ];

  List<Map<String, dynamic>> products = [
    {
      "name": "productA",
      "price": 20000,
      "proPrice": 15000,
      "image":
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQYBchWaa_c52WnP-oYluN8oz5316h4odbq4DEDvAHE9A&s=10",
    },
    {
      "name": "productB",
      "price": 20000,
      "proPrice": 15000,
      "image":
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQYBchWaa_c52WnP-oYluN8oz5316h4odbq4DEDvAHE9A&s=10",
    },
    {
      "name": "productC",
      "price": 20000,
      "proPrice": 15000,
      "image":
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQYBchWaa_c52WnP-oYluN8oz5316h4odbq4DEDvAHE9A&s=10",
    },
    {
      "name": "productD",
      "price": 20000,
      "proPrice": 15000,
      "image":
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQYBchWaa_c52WnP-oYluN8oz5316h4odbq4DEDvAHE9A&s=10",
    },
  ];

  final PageController _pageController = PageController();
  int _currentPage = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 235, 147, 147),
        leading: Padding(
          padding: const EdgeInsets.all(5),
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Profile()),
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
        title: Column(
          children: [
            Text(
              "Delivery locatiion",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            Row(
              children: [
                Icon(Icons.location_on),
                Text("Columbus, Ohio, USA", style: TextStyle(fontSize: 18)),
              ],
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: Stack(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.white,
                  child: IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.notifications_none),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          children: [
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
                    color: const Color.fromARGB(255, 220, 215, 215),
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.tune, color: Colors.black),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 16,
            ), // ໄລຍະຫ່າງລະຫວ່າງ Search Bar ແລະ Banner
            // 📌 [ບ່ອນເຕີ່ມ 3] ເພີ່ມ Banner Auto Slider ໄວ້ບ່ອນນີ້
            SizedBox(
              height: 160, // ຄວາມສູງຂອງ Banner
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
      
            // (ແຖມ) ຈຸດ Dot ສະແດງຕຳແໜ່ງໜ້າ Banner (Page Indicator)
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
            SizedBox(height: 20),
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
                itemCount: products.length,
                itemBuilder: (context, index) {
                  final item = products[index];
                  return Card(
                    child: Text('${item["name"]}'),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index; // ອັບເດດເມື່ອມີການກົດປ່ຽນ Tab
          });
        },
        type: BottomNavigationBarType.fixed, // ສະແດງຂໍ້ຄວາມ ແລະ ໄອຄອນຄົບ 4 ຢ່າງ
        selectedItemColor: const Color(0xFFE07A5F), // ສີເວລາເລືອກ
        unselectedItemColor: Colors.grey, // ສີເວລາບໍ່ໄດ້ເລືອກ
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
            icon: Icon(Icons.person_outline),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
