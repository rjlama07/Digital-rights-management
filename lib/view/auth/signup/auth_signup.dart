import 'package:flutter/material.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_navigation/get_navigation.dart';

class MainSignupPage extends StatelessWidget {
  const MainSignupPage({super.key});

  @override
  Widget build(BuildContext context) {
    Widget buildTextField({
      required String hintText,
      bool isObsecure = false,
    }) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(hintText),
          const SizedBox(height: 10),
          TextField(
            obscureText: isObsecure,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              fillColor: const Color(0xFF777777),
              filled: true,
              hintText: hintText,
            ),
          ),
        ],
      );
    }

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28),
          child: Column(
            children: [
              Row(
                children: [
                  InkWell(
                    onTap: ()=>Get.back(),
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.black),
                        color: Colors.black
                      ),
                      child: const Center(child: Icon(Icons.arrow_back_ios)),
                    ),
                  ),
                  const Spacer(),
                  Text("Create Account",
                      style: Theme.of(context)
                          .textTheme
                          .labelMedium!
                          .copyWith(fontSize: 20)),
                  const Spacer(),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              buildTextField(
                hintText: "Whats your name?",
              ),
              const SizedBox(height: 20),
              buildTextField(
                hintText: "Whats your email address?",
              ),
              const SizedBox(height: 20),
              buildTextField(
                isObsecure: true,
                hintText: "Create Password",
              ),
              const SizedBox(height: 20),
              buildTextField(
                isObsecure: true,
                hintText: "Confirm Password",
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: () {},
                child: const Center(child: Text("Sign Up")),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
