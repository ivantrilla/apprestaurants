// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_example/app/controllers/auth_controller.dart';
import 'package:supabase_example/app/routes/app_pages.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  final authC = Get.find<AuthController>();

  LoginView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'LOGIN',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 23,
            ),
          ),
          centerTitle: true,
          backgroundColor: const Color.fromARGB(255, 243, 173, 33),
        ),
        backgroundColor: const Color.fromARGB(255, 225, 255, 213),
        body: ListView(
          padding: const EdgeInsets.all(10),
          children: [
            TextField(
              autocorrect: false,
              controller: controller.emailC,
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(
                labelText: "Email",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.email),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Obx(() => TextField(
                  autocorrect: false,
                  controller: controller.passwordC,
                  textInputAction: TextInputAction.done,
                  obscureText: controller.isPasswordHidden.value,
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                        onPressed: () => controller.isPasswordHidden.toggle(),
                        icon: controller.isPasswordHidden.isTrue
                            ? const Icon(Icons.remove_red_eye)
                            : const Icon(Icons.remove_red_eye_outlined)),
                    labelText: "Password",
                    border: const OutlineInputBorder(),
                    prefixIcon: const Icon(Icons.lock),
                  ),
                )),
            const SizedBox(
              height: 30,
            ),
            Obx(() => ElevatedButton(
                  onPressed: () async {
                    if (controller.isLoading.isFalse) {
                      bool? cekAutoLogout = await controller.login();
                      if (cekAutoLogout != null && cekAutoLogout == true) {
                        await authC.autoLogout();
                        Get.offAllNamed(Routes.HOME);
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    primary: const Color.fromARGB(255, 243, 173, 33),
                  ),
                  child: Text(
                      controller.isLoading.isFalse ? "LOGIN" : "Loading..."),
                )),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
                onPressed: () => Get.toNamed(Routes.REGISTER),
                style: ElevatedButton.styleFrom(
                    primary: const Color.fromARGB(255, 243, 173, 33),
                  ),
                child: const Text("REGISTER"))
          ],
        ));
  }
}
