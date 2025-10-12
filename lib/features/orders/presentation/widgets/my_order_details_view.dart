import 'package:flutter/material.dart';
import 'package:tracking_app/features/orders/presentation/widgets/my_orders_details_view_body.dart';

import '../../data/models/my_orders_response.dart';

class MyOrderDetailsView extends StatefulWidget {
  const MyOrderDetailsView({
    required this.orders,
    super.key,
  });

  final Orders orders;

  @override
  State<MyOrderDetailsView> createState() => _OrderDetailsViewState();
}

class _OrderDetailsViewState extends State<MyOrderDetailsView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.grey,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Align(
                alignment: Alignment.topLeft,
                child: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            Expanded(
              child: MyOrderDetailsViewBody(
                orders: widget.orders,
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
