import 'package:flutter/material.dart';

class CustomBody extends StatelessWidget {
  final String? appBarTittle;
  final bool? showLogoInBarTittle;
  final Widget child;

  const CustomBody({
    super.key,
    required this.child,
    this.appBarTittle,
    this.showLogoInBarTittle,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Conditionally render the AppBar
      appBar: appBarTittle != null
          ? AppBar(
            backgroundColor: Colors.transparent,
              title: Row(
                children: [
                  ?showLogoInBarTittle != null ? Image.asset(
                    'assets/logo.png',
                    height: 32,
                  ) : null,
                  const SizedBox(width: 8),
                  Text(appBarTittle!),
                ],
              ),
            )
          : null, // If appBarTittle is null, the appBar itself will be null
      backgroundColor: Colors.transparent,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 255, 255, 255),
              Color.fromARGB(237, 237, 237, 237),
              Color.fromARGB(255, 175, 175, 175),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: child,
      ),
    );
  }
}