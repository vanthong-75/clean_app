import 'package:clean_app/feature/presentation/components/button_component.dart';
import 'package:clean_app/feature/presentation/components/input_text.dart';
import 'package:clean_app/feature/presentation/pages/sign_in.dart';
import 'package:clean_app/feature/presentation/pages/forgot_password.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool isRememberMe = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: MediaQuery.sizeOf(context).width,
            height: MediaQuery.sizeOf(context).height,
            color: const Color.fromARGB(255, 223, 129, 129),
            child: const Padding(
              padding: EdgeInsets.only(top: 80, left: 25, right: 25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Create Account',
                    style: TextStyle(fontSize: 32, color: Colors.white),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Register your account today',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'using a valid email and password.',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                width: MediaQuery.sizeOf(context).width,
                height: MediaQuery.sizeOf(context).height * 0.7,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(25),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Sign in', style: TextStyle(fontSize: 25)),
                      const SizedBox(height: 20),
                      InputText.inputText(
                        'Enter your email',
                        const Icon(Icons.email),
                      ),
                      const SizedBox(height: 15),
                      InputText.inputText(
                        'Enter password',
                        const Icon(Icons.lock),
                      ),
                      const SizedBox(height: 15,),
                      InputText.inputText(
                        'Conform your password',
                        const Icon(Icons.lock),
                      ),
                      const SizedBox(height: 15,),
                      InputText.inputText(
                        'Enter referral ID(Optional) ',
                        const Icon(Icons.person),
                      ),
                      const SizedBox(height: 20),

                      // 📍 2. ສ່ວນປັບປຸງ UI ຂອງ Remember me & Forgot password
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //   children: [
                      //     // ຫຸ້ມ GestureDetector ເພື່ອກົດຢູ່ໂຕໜັງສື 'Remember me' ແລ້ວຕິກໄດ້
                      //     GestureDetector(
                      //       onTap: () {
                      //         setState(() {
                      //           isRememberMe = !isRememberMe;
                      //         });
                      //       },
                      //       child: Row(
                      //         children: [
                      //           SizedBox(
                      //             height: 24,
                      //             width: 24,
                      //             child: Checkbox(
                      //               value:
                      //                   isRememberMe, // ໃຊ້ຄ່າ variable ທີ່ປະກາດໄວ້
                      //               onChanged: (bool? value) {
                      //                 setState(() {
                      //                   isRememberMe = value ?? false;
                      //                 });
                      //               },
                      //             ),
                      //           ),
                      //           const SizedBox(
                      //             width: 8,
                      //           ), // ໄລຍະຫ່າງ Checkbox ກັບ Text
                      //           const Text('Remember me'),
                      //         ],
                      //       ),
                      //     ),

                      //     // ປຸ່ມ Forgot password
                      //     GestureDetector(
                      //      onTap: () {
                      //         Navigator.push(context, 
                      //         MaterialPageRoute(builder: (context) => const ForgotPassword()));
                      //         // Action ເວລາກົດ Forgot password
                      //       },
                      //       child: const Text(
                      //         'Forgot password',
                      //         style: TextStyle(
                      //           color: Colors.blue,
                      //           fontWeight: FontWeight.bold,
                      //         ),
                      //       ),
                      //     ),
                      //   ],
                      // ),

                      const SizedBox(height: 50),
                      ButtonComponent.buttonComponent(
                        context,
                        'Sign up',
                        const Icon(Icons.login, color: Colors.white, size: 30),
                        () {
                          
                        },
                      ),
                      const SizedBox(height: 70),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('already have an account?'),
                          const SizedBox(width: 9),

                          // 📍 ຫຸ້ມ Text('Sign up') ດ້ວຍ GestureDetector
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const SignIn(),
                                ),
                              );
                            },
                            child: const Text(
                              'Sign in',
                              style: TextStyle(
                                color: Color.fromRGBO(3, 131, 235, 1),
                                fontWeight: FontWeight
                                    .bold, // ເພີ່ມຄວາມເຂັ້ມໃຫ້ເບິ່ງຄືປຸ່ມ
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
