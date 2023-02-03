import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(
        //   title: const Text('LOGIN'),
        //   centerTitle: true,
        // ),
        body: ListView(
      padding: EdgeInsets.all(20),
      children: [
        Column(
          children: [
            // Image.asset("assets/images/a.png"),
            Image.asset('../../../../assets/images/a.png'),
            // <-- SEE HERE
          ],
        ),
        SizedBox(
          height: 10,
        ),
        TextField(
          autocorrect: false,
          controller: controller.emailC,
          decoration: InputDecoration(
            labelText: "Email",
            border: OutlineInputBorder(),
          ),
        ),
        SizedBox(height: 20),
        TextField(
          autocorrect: false,
          controller: controller.passC,
          obscureText: true,
          decoration: InputDecoration(
            labelText: "Password",
            border: OutlineInputBorder(),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Obx(
          () => ElevatedButton(
            onPressed: () async {
              if (controller.isLoading.isFalse) {
                await controller.login();
              }
            },
            child:
                Text(controller.isLoading.isFalse ? "LOGIN" : "LOADING. . ."),
          ),
        ),
        TextButton(onPressed: () {}, child: Text("Lupa password ?"))
      ],
    ));
  }
}
