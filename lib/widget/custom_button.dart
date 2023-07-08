import 'package:flutter/material.dart';

class CustomButtom extends StatelessWidget {
  const CustomButtom(
      {super.key,
      required this.text,
      required this.ontap,
      required this.isLoading});
  final String text;
  final Function ontap;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => ontap(),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.065,
        decoration: const BoxDecoration(color: Colors.red),
        child: Center(
          child: isLoading
              ? const CircularProgressIndicator(
                  color: Colors.blue,
                )
              : Text(
                  text,
                  style: Theme.of(context).textTheme.titleSmall,
                ),
        ),
      ),
    );
  }
}
