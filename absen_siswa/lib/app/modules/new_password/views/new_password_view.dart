import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/new_password_controller.dart';

class NewPasswordView extends GetView<NewPasswordController> {
  const NewPasswordView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Ganti Password'),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            // 1padding: EdgeInsets.all(20),
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                // children: [
                // Image.asset('assets/a.png'),
                child: Image.asset('../../../../assets/images/change.jpg'),
                // <-- SEE HERE
                // ],
              ),
              TextField(
                controller: controller.newPassC,
                autocorrect: false,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: "Password Baru",
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  controller.newPassword();
                },
                child: Text("LANJUTKAN"),
              )
            ],
          ),
        ));
  }
}
