import 'package:flutter/material.dart';



class AvailableForDelivery extends StatelessWidget {
  const AvailableForDelivery({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Not available \n for \n delivery ',
              textAlign: TextAlign.center,
              style: 
              TextStyle(
                  color: Colors.black,
                  fontSize: 24,
                  fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: 24,
            ),

          ],
        ));
  }
}
