import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tiktok_clone/constants.dart';
import 'package:tiktok_clone/controllers/auth_controller.dart';
import 'package:tiktok_clone/views/screens/auth/login_screen.dart';
import 'package:tiktok_clone/views/widgets/text_input_field.dart';

class SignupScreen extends StatelessWidget {
  SignupScreen({Key? key}) : super(key: key);
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "TikTok Clone",
              style: TextStyle(
                fontSize: 35,
                color: buttonColor,
                fontWeight: FontWeight.w900,
              ),
            ),
            const Text(
              "Register",
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            Stack(
              children: [
                CircleAvatar(
                  radius: 60,
                  backgroundColor: Colors.white,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(60),
                    child: Image.network(
                        'https://www.pngitem.com/pimgs/m/150-1503945_transparent-user-png-default-user-image-png-png.png'),
                  ),
                ),
                Positioned(
                  bottom: -2,
                  right: 1,
                  child: IconButton(
                    onPressed: () {
                      authController.pickImage();
                    },
                    icon: const Icon(
                      Icons.camera_alt,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 25,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: TextInputField(
                controller: _emailController,
                labelText: 'Email',
                icon: Icons.email_outlined,
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: TextInputField(
                controller: _usernameController,
                labelText: 'Username',
                icon: Icons.person,
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: TextInputField(
                controller: _passwordController,
                isObsecure: true,
                labelText: 'Password',
                icon: Icons.lock,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            InkWell(
              onTap: () {
                if (_usernameController.text.isNotEmpty &&
                    _passwordController.text.isNotEmpty &&
                    _emailController.text.isNotEmpty &&
                    authController.profilePhoto != null) {
                  authController.register(
                    _usernameController.text,
                    _passwordController.text,
                    _emailController.text,
                    authController.profilePhoto,
                  );
                } else {
                  Get.snackbar('Error', 'Sorry all fields are required.');
                }
              },
              child: Container(
                width: MediaQuery.of(context).size.width - 40,
                height: 60,
                decoration: BoxDecoration(
                  color: buttonColor,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Obx(() {
                  return Center(
                    child: authController.isLoading.value
                        ? const CircularProgressIndicator(
                            color: Colors.white,
                          )
                        : const Text(
                            'Register',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                  );
                }),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Already have an account? ',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoginScreen(),
                      ),
                    );
                  },
                  child: Text(
                    'Login',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: buttonColor,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
