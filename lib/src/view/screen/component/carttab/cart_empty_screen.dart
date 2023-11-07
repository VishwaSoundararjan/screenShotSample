import 'package:flutter/material.dart';

class CartEmptyScreen extends StatelessWidget {
  const CartEmptyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("Empty cart"),
      ),
    );
  }
}
