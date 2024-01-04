// ignore_for_file: use_key_in_widget_constructors, must_be_immutable, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_example/app/components/avatar.dart';
import 'package:supabase_example/app/controllers/auth_controller.dart';
import 'package:supabase_example/app/routes/app_pages.dart';

import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  final authC = Get.find<AuthController>();
  String? _imageUrl;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'PROFILE',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 23,
            ),
          ),
          centerTitle: true,
          backgroundColor: const Color.fromARGB(255, 243, 173, 33),
          actions: [
            TextButton(
                onPressed: () async {
                  await controller.logout();
                  await authC.resetTimer();
                  Get.offAllNamed(Routes.LOGIN);
                },
                child: const Text(
                  "LOGOUT",
                  style: TextStyle(color: Colors.white),
                ))
          ],
        ),
        backgroundColor: const Color.fromARGB(255, 225, 255, 213),
        body: FutureBuilder(
            future: controller.getProfile(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return ListView(
                padding: const EdgeInsets.all(10),
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Avatar(
                      imageUrl: _imageUrl,
                      onUpload: (imageUrl) {
                        _imageUrl = imageUrl;
                      }),
                  const SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: Text(
                      controller.emailC2.text,
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextField(
                    autocorrect: false,
                    controller: controller.fullNameC2,
                    textInputAction: TextInputAction.next,
                    decoration: const InputDecoration(
                      labelText: "Full Name",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextField(
                    autocorrect: false,
                    controller: controller.emailC2,
                    textInputAction: TextInputAction.next,
                    decoration: const InputDecoration(
                      labelText: "Email",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Obx(() => TextField(
                        autocorrect: false,
                        controller: controller.passwordC2,
                        textInputAction: TextInputAction.done,
                        obscureText: controller.isNewPasswordHidden.value,
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                              onPressed: () =>
                                  controller.isNewPasswordHidden.toggle(),
                              icon: controller.isNewPasswordHidden.isTrue
                                  ? const Icon(Icons.remove_red_eye)
                                  : const Icon(Icons.remove_red_eye_outlined)),
                          labelText: "New Password",
                          border: const OutlineInputBorder(),
                        ),
                      )),
                  const SizedBox(
                    height: 20,
                  ),
                  Obx(() => TextField(
                        autocorrect: false,
                        controller: controller.confirmPasswordC2,
                        textInputAction: TextInputAction.done,
                        obscureText:
                            controller.isConfirmNewPasswordHidden.value,
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                              onPressed: () => controller
                                  .isConfirmNewPasswordHidden
                                  .toggle(),
                              icon: controller.isConfirmNewPasswordHidden.isTrue
                                  ? const Icon(Icons.remove_red_eye)
                                  : const Icon(Icons.remove_red_eye_outlined)),
                          labelText: "Confirm New Password",
                          border: const OutlineInputBorder(),
                        ),
                      )),
                  const SizedBox(
                    height: 20,
                  ),
                  Obx(() => ElevatedButton(
                        onPressed: () async {
                          if (controller.isLoading.isFalse) {
                            if (controller.fullNameC.text ==
                                    controller.fullNameC2.text &&
                                controller.emailC.text ==
                                    controller.emailC2.text &&
                                controller.passwordC.text ==
                                    controller.passwordC2.text) {
                              Get.snackbar("Info", "There is no data to update",
                                  borderWidth: 1,
                                  borderColor: Colors.white,
                                  barBlur: 100);
                              return;
                            }
                            await controller.updateProfile();
                            if (controller.passwordC2.text.isNotEmpty &&
                                controller.passwordC2.text.length >= 6 &&
                                controller.passwordC2.text ==
                                    controller.confirmPasswordC2.text) {
                              await controller.logout();
                              await authC.resetTimer();
                              Get.offAllNamed(Routes.LOGIN);
                            }
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          primary: const Color.fromARGB(255, 243, 173, 33),
                        ),
                        child: Text(controller.isLoading.isFalse
                            ? "UPDATE PROFILE"
                            : "Loading..."),
                      )),
                ],
              );
            }));
  }
}
