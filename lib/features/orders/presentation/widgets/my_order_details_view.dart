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
  State<MyOrderDetailsView> createState() =>
      _OrderDetailsViewState();
}

class _OrderDetailsViewState
    extends State<MyOrderDetailsView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Order details",style: TextStyle(color: Colors.black,fontSize: 17,),),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: MyOrderDetailsViewBody(
          orders: widget.orders,
        ),
      ),
    );
  }
}
