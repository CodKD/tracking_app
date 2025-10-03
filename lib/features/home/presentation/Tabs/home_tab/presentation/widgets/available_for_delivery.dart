import 'package:flutter/material.dart';
import 'package:tracking_app/core/extensions/project_extensions.dart';



class AvailableForDelivery extends StatelessWidget {
  const AvailableForDelivery({super.key});

  @override
  Widget build(BuildContext context) {
    return  Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              context.l10n.notAvailableForDelivery,
              textAlign: TextAlign.center,
              style: 
             const TextStyle(
                  color: Colors.black,
                  fontSize: 24,
                  fontWeight: FontWeight.w600),
            ),
           const SizedBox(
              height: 24,
            ),

          ],
        ));
  }
}
