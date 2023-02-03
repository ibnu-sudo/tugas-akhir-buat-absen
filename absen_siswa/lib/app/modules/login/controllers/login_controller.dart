import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/app_pages.dart';

class LoginController extends GetxController {
  RxBool isLoading = false.obs;
  TextEditingController emailC = TextEditingController();
  TextEditingController passC = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> login() async {
    if (emailC.text.isNotEmpty && passC.text.isNotEmpty) {
      isLoading.value = true;
      try {
        UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: emailC.text,
          password: passC.text,
        );
        // print(userCredential);

        if (userCredential.user != null) {
          isLoading.value = false;
          if (userCredential.user!.emailVerified == true) {
            if (passC.text == "password") {
              Get.offAllNamed(Routes.NEW_PASSWORD);
            } else {
              Get.offAllNamed(Routes.HOME);
            }
          } else {
            Get.defaultDialog(
              title: "Belum Verifikasi",
              middleText:
                  "Kamu belum Verifikasi Akun ini. Silahkan Verifikasi di emailmu",
              actions: [
                OutlinedButton(
                  onPressed: () {
                    isLoading.value = false;
                    Get.back();
                  },
                  child: Text("CANCEL"),
                ),
                ElevatedButton(
                    onPressed: () async {
                      try {
                        await userCredential.user!.sendEmailVerification();
                        Get.back();
                        Get.snackbar("Berhasil",
                            "Kami telah berhasil mengirim email verifikasi di email mu!");
                        isLoading.value = false;
                      } catch (e) {
                        isLoading.value = false;
                        Get.snackbar("Terjadi Kesalahan",
                            "Tidak dapat mengirim email verifikasi. Hubungi admin atau custumer service");
                      }
                    },
                    child: Text(
                        "KIRIM ULANG")) //bisa buat tutup dialog dan bisa buat kembali
              ],
            );
          }
        }
        isLoading.value = false;

        // Get.offAllNamed(Routes.HOME);
      } on FirebaseAuthException catch (e) {
        isLoading.value = false;
        if (e.code == 'user-not-found') {
          Get.snackbar("Error", "Email belum terdaftar");
        } else if (e.code == 'wrong-password') {
          Get.snackbar("Error", "Password anda Salah");
        }
      } catch (e) {
        isLoading.value = false;
        Get.snackbar("Error", "Tidak dapat login");
      }
    } else {
      Get.snackbar("Error", "Email dan Password harus diisi!.");
    }
  }
}
