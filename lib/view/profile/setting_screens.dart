import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nepalihiphub/widget/custom_button.dart';

import '../../controller/profile_controller.dart';

class SettingsScreen extends StatelessWidget {
  SettingsScreen({super.key});
  static final formkey = GlobalKey<FormState>();
  final TextEditingController oldPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ProfileController>();
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: const Text('Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Column(
          children: [
            ListTile(
              onTap: () {
                showModalBottomSheet(
                    context: context,
                    builder: (context) => SizedBox(
                          height: MediaQuery.of(context).size.height * 0.9,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Form(
                              key: formkey,
                              child: Column(
                                children: [
                                  TextFormField(
                                    controller: oldPasswordController,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return "field required";
                                      }
                                      return null;
                                    },
                                    decoration: const InputDecoration(
                                        border: OutlineInputBorder(),
                                        hintText: "old password"),
                                  ),
                                  SizedBox(height: 10.h),
                                  TextFormField(
                                    controller: newPasswordController,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return "field required";
                                      }
                                      return null;
                                    },
                                    decoration: const InputDecoration(
                                        border: OutlineInputBorder(),
                                        hintText: "new password"),
                                  ),
                                  SizedBox(height: 10.h),
                                  TextFormField(
                                    controller: confirmPasswordController,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return "field required";
                                      } else if (value !=
                                          newPasswordController.text) {
                                        return "password does not match";
                                      }
                                      return null;
                                    },
                                    decoration: const InputDecoration(
                                        border: OutlineInputBorder(),
                                        hintText: "confirm password"),
                                  ),
                                  SizedBox(height: 20.h),
                                  CustomButtom(
                                    text: "Change Password",
                                    ontap: () {
                                      if (formkey.currentState!.validate()) {
                                        controller.changePassword(
                                            oldPasswordController.text,
                                            newPasswordController.text, () {
                                          Navigator.of(context).pop();
                                        });
                                      }
                                    },
                                    isLoading: false,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ));
              },
              leading: const Icon(Icons.key),
              title: const Text("Change Password"),
              subtitle: const Text(
                "Change your password",
                style: TextStyle(fontSize: 12),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Divider(
                height: 1,
                color: Colors.grey,
              ),
            )
          ],
        ),
      ),
    );
  }
}
