import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () {
            Navigator.pop(context); // ກົດກັບຄືນ
          },
        ),
        actions: [
          TextButton(
            onPressed: () {
              // ຄຳສັ່ງບັນທຶກ (Save)
            },
            child: const Text(
              'Save',
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 24.0),
              color: const Color(0xFFF5F5F5),
              child: Column(
                children: [
                  Stack(
                    alignment: Alignment.topRight,
                    children: [
                      // ຮູບໂປຣໄຟລ໌
                      const CircleAvatar(
                        radius: 60,
                        backgroundImage: NetworkImage(
                          'https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=150',
                        ),
                      ),
                      // ໄອຄອນສໍແກ້ໄຂ
                      Positioned(
                        right: 0,
                        top: 0,
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.edit_outlined,
                            size: 18,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'PROFILE PHOTO',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),

            // 3. ລາຍການຂໍ້ມູນ (List Options)
            const SizedBox(height: 10),
            _buildProfileItem(
              label: 'NAME',
              value: 'Carrie Sanders',
              onTap: () {},
            ),
            _buildDivider(),
            _buildProfileItem(
              label: 'EMAIL',
              value: 'carrie_sanders@email.com',
              onTap: () {},
            ),
            _buildDivider(),
            _buildProfileItem(
              label: 'TITLE',
              value: 'Principal Product Designer',
              onTap: () {},
            ),
            _buildDivider(),
            _buildProfileItem(
              label: 'LOCATION',
              value: 'San Francisco, CA',
              onTap: () {},
            ),
            _buildDivider(),
          ],
        ),
      ),
    );
  }

  // Widget ສຳລັບສ້າງແຖບລາຍການຂໍ້ມູນ
  Widget _buildProfileItem({
    required String label,
    required String value,
    required VoidCallback onTap,
  }) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
      title: Text(
        label,
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.1,
          color: Colors.black,
        ),
      ),
      subtitle: Padding(
        padding: const EdgeInsets.only(top: 6.0),
        child: Text(
          value,
          style: const TextStyle(
            fontSize: 15,
            color: Colors.black87,
          ),
        ),
      ),
      trailing: const Icon(
        Icons.chevron_right,
        color: Colors.black,
        size: 22,
      ),
      onTap: onTap,
    );
  }

  // Widget ດຶງເສັ້ນຂີດຂັ້ນ
  Widget _buildDivider() {
    return const Divider(
      height: 1,
      thickness: 0.8,
      color: Color(0xFFEEEEEE),
      indent: 20,
      endIndent: 20,
    );
  }
}