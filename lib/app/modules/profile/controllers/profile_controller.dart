import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_example/app/routes/app_pages.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProfileController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isNewPasswordHidden = true.obs;
  RxBool isConfirmNewPasswordHidden = true.obs;
  TextEditingController fullNameC = TextEditingController();
  TextEditingController fullNameC2 = TextEditingController();
  TextEditingController emailC = TextEditingController();
  TextEditingController emailC2 = TextEditingController();
  TextEditingController passwordC = TextEditingController();
  TextEditingController passwordC2 = TextEditingController();
  TextEditingController confirmPasswordC2 = TextEditingController();
  SupabaseClient client = Supabase.instance.client;

  Future<void> logout() async {
    await client.auth.signOut();
    Get.offAllNamed(Routes.LOGIN);
  }

  Future<void> getProfile() async {
    List<dynamic> res = await client
        .from("users")
        .select()
        .match({"uid": client.auth.currentUser!.id});
    Map<String, dynamic> user = (res).first as Map<String, dynamic>;
    fullNameC.text = user["full_name"];
    fullNameC2.text = user["full_name"];
    emailC.text = user["email"];
    emailC2.text = user["email"];
  }

  Future<void> updateProfile() async {
    if (fullNameC2.text.isNotEmpty && emailC2.text.isNotEmpty) {
      isLoading.value = true;

      if (passwordC2.text != confirmPasswordC2.text) {
        Get.snackbar("Error", "New password and confirm password do not match");
        isLoading.value = false;
      } else {
        final updateData = {
          "full_name": fullNameC2.text,
          "email": emailC2.text,
        };

        if (passwordC2.text.isNotEmpty && confirmPasswordC2.text.isNotEmpty) {
          updateData["password"] = passwordC2.text;
        }

        await client
            .from("users")
            .update(updateData)
            .match({"uid": client.auth.currentUser!.id});

        if (passwordC2.text.isNotEmpty) {
          if (passwordC2.text.length >= 6) {
            try {
              await client.auth.updateUser(UserAttributes(
                password: passwordC2.text,
              ));
            } catch (e) {
              Get.snackbar("ERROR", e.toString());
            }
          } else {
            Get.snackbar("ERROR", "Password must be longer than 6 characters");
          }
        }

        Get.defaultDialog(
            barrierDismissible: false,
            title: "Update Profile success",
            middleText: "Name, Email or Password will be updated",
            actions: [
              OutlinedButton(
                  onPressed: () {
                    Get.back();
                    Get.back();
                  },
                  child: const Text("OK"))
            ]);
      }

      isLoading.value = false;
    }
  }
}
