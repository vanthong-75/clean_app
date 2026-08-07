import 'package:flutter/material.dart';

class OtpVerification extends StatefulWidget {
  final String? phoneNumber;

  const OtpVerification({super.key, this.phoneNumber});

  @override
  State<OtpVerification> createState() => _OtpVerificationState();
}

class _OtpVerificationState extends State<OtpVerification> {
  // ເລີ່ມຕົ້ນດ້ວຍ List ຫວ່າງเปลົ່າ 4 ช่อง
  List<String> otpCode = ['', '', '', ''];

  // 📍 ຟັງຊັນຈັດການການກົດຕົວເລກ ແລະ ກົດລຶບ
  void _onKeyTap(String value) {
    setState(() {
      if (value == 'backspace') {
        // ຖ້າກົດປຸ່ມລຶບ: ຊອກຫາช่องສຸມສຸດທີ່ມີຕົວເລກ ແລ້ວລຶບອອກ
        for (int i = otpCode.length - 1; i >= 0; i--) {
          if (otpCode[i].isNotEmpty) {
            otpCode[i] = '';
            break;
          }
        }
      } else if (value != '#') {
        // ຖ້າກົດຕົວເລກ: ຊອກຫາช่องທຳອິດທີ່ຍັງຫວ່າງ ແລ້ວຕື່ມຕົວເລກໃສ່
        for (int i = 0; i < otpCode.length; i++) {
          if (otpCode[i].isEmpty) {
            otpCode[i] = value;
            break;
          }
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    const primaryBlue = Color(0xFF4285F4);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.only(left: 16.0, top: 8.0),
          child: CircleAvatar(
            backgroundColor: const Color(0xFFF2F4F7),
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.black, size: 20),
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            children: [
              const SizedBox(height: 20),
              // Header Titles
              const Text(
                'Verify Code',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Enter the code we just sent to',
                style: TextStyle(color: Colors.grey, fontSize: 14),
              ),
              const SizedBox(height: 6),
              Text(
                widget.phoneNumber ?? '2052754554',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 35),

              // 📍 OTP Input Boxes 4 ช่อง
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(4, (index) {
                  // ເຊັກວ່າช่องນີ້ແມ່ນช่องປັດຈຸບັນທີ່ກຳລັງຈະປ້ອນຫຼືບໍ່
                  bool isCurrentFocus =
                      otpCode[index].isEmpty && (index == 0 || otpCode[index - 1].isNotEmpty);

                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    width: 60,
                    height: 60,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: isCurrentFocus ? primaryBlue : Colors.grey.shade200,
                        width: isCurrentFocus ? 2 : 1.5,
                      ),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Text(
                      otpCode[index],
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  );
                }),
              ),

              const SizedBox(height: 30),

              // Didn't get OTP? Resend code
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Didn't get OTP? ",
                    style: TextStyle(color: Colors.grey, fontSize: 13),
                  ),
                  GestureDetector(
                    onTap: () {
                      // TODO: Resend OTP Logic
                    },
                    child: const Text(
                      'Resend code',
                      style: TextStyle(
                        color: primaryBlue,
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                      ),
                    ),
                  ),
                ],
              ),

              const Spacer(),

              // 📍 Custom Keypad
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFFEFF1F5),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Column(
                  children: [
                    _buildKeypadRow(['1', '2', '3']),
                    const SizedBox(height: 12),
                    _buildKeypadRow(['4', '5', '6']),
                    const SizedBox(height: 12),
                    _buildKeypadRow(['7', '8', '9']),
                    const SizedBox(height: 12),
                    _buildKeypadRow(['#', '0', 'backspace']),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // 📍 Verify Button
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  onPressed: () {
                    String fullCode = otpCode.join();
                    if (fullCode.length == 4) {
                      print("Verified OTP Successfully: $fullCode");
                      // TODO: ດຳເນີນການຕໍ່ເມື່ອປ້ອນລະຫັດຄົບ 4 ໂຕ
                    } else {
                      print("Please enter complete 4-digit code");
                    }
                  },
                  child: const Text(
                    'Verify',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }

  // ຟັງຊັນສ້າງແຖວ Keypad
  Widget _buildKeypadRow(List<String> keys) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: keys.map((key) {
        return Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: _buildKeypadButton(key),
          ),
        );
      }).toList(),
    );
  }

  // ຟັງຊັນສ້າງປຸ່ມ Keypad
  Widget _buildKeypadButton(String key) {
    return InkWell(
      onTap: () => _onKeyTap(key),
      borderRadius: BorderRadius.circular(12),
      child: Container(
        height: 52,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        alignment: Alignment.center,
        child: key == 'backspace'
            ? const Icon(
                Icons.backspace_outlined,
                size: 20,
                color: Colors.black87,
              )
            : Text(
                key,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
      ),
    );
  }
}