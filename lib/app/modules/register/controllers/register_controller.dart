import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class RegisterController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isPasswordHidden = true.obs;
  TextEditingController fullNameC = TextEditingController();
  TextEditingController emailC = TextEditingController();
  TextEditingController passwordC = TextEditingController();
  TextEditingController birthdateC = TextEditingController();
  TextEditingController phoneNumberC = TextEditingController();
  SupabaseClient client = Supabase.instance.client;

  Future<void> signUp() async {
    if (emailC.text.isNotEmpty &&
        passwordC.text.isNotEmpty &&
        fullNameC.text.isNotEmpty) {
      isLoading.value = true;
      try {
        AuthResponse res = await client.auth
            .signUp(password: passwordC.text, email: emailC.text);
        isLoading.value = false;

        await client.from("users").insert({
          "full_name": fullNameC.text,
          "email": emailC.text,
          "password": passwordC.text,
          "birthdate": birthdateC.text,
          "phone_number": phoneNumberC.text,
          "created_at": DateTime.now().toIso8601String(),
          "uid": res.user!.id,
        });

        Get.defaultDialog(
            barrierDismissible: false,
            title: "Registration success",
            middleText: "Please confirm email: ${res.user!.email}",
            actions: [
              OutlinedButton(
                  onPressed: () {
                    Get.back();
                    Get.back();
                  },
                  child: const Text("OK"))
            ]);
      } catch (e) {
        isLoading.value = false;
        Get.snackbar("ERROR", e.toString());
      }
    } else {
      Get.snackbar("ERROR", "Email, password and name are required");
    }
  }
}
