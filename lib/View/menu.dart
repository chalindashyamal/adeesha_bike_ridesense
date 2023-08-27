import 'package:flutter/material.dart';

class Menu extends StatelessWidget {
  final itemTexts = [
    'Last Trip',
    'History',
    'Static',
    'Loyalty Point',
    'Settings',
    'Log out',
  ];

  final icons = [
    Icons.trip_origin,
    Icons.history,
    Icons.bar_chart,
    Icons.star,
    Icons.settings,
    Icons.logout,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Menu'),
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        itemCount: itemTexts.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              // Handle item tap here
            },
            child: Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    icons[index],
                    size: 48,
                    color: Colors.white,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    itemTexts[index],
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
