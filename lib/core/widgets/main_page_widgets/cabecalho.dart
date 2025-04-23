import 'package:flutter/material.dart';

class Cabecalho extends StatefulWidget {
  @override
  _CabecalhoState createState() => _CabecalhoState();
}

class _CabecalhoState extends State<Cabecalho> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Olá, User',
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        Row(
          children: [
            IconButton(
              icon: const Icon(Icons.search, size: 24),
              color: Colors.white,
              onPressed: () {},
              style: IconButton.styleFrom(
                backgroundColor: const Color(0xFF1E1E1E),
                shape: const CircleBorder(),
                padding: const EdgeInsets.all(12),
              ),
            ),
            const SizedBox(width: 10),
            IconButton(
              icon: const Icon(Icons.person, size: 24),
              color: Colors.white,
              onPressed: () {
                print('user clicked on the botton');
              },
              style: IconButton.styleFrom(
                backgroundColor: const Color(0xFF1E1E1E),
                shape: const CircleBorder(),
                padding: const EdgeInsets.all(12),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
