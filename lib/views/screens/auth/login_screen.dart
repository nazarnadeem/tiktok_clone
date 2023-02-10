import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tiktok_clone/constants.dart';
import 'package:tiktok_clone/views/screens/auth/signup_screen.dart';
import 'package:tiktok_clone/views/widgets/text_input_field.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

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
              "Login",
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w700,
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
                if (_emailController.text.isNotEmpty &&
                    _passwordController.text.isNotEmpty) {
                  authController.loginUser(
                    _emailController.text,
                    _passwordController.text,
                  );
                } else {
                  Get.snackbar(
                    'Missing Fields',
                    'Both fields are required.',
                  );
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
                            'Login',
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
                  'Don\'t have an account? ',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SignupScreen(),
                      ),
                    );
                  },
                  child: Text(
                    'Register',
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
