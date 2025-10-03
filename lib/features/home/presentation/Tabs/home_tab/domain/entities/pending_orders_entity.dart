import 'package:tracking_app/features/home/presentation/Tabs/home_tab/data/models/pending_orders_response.dart';

class PendingDriverOrdersEntity
{

  PendingDriverOrdersEntity({
 this.metadata,
this.orders,
 this.message,
  });

  Metadata? metadata;
  List<Orders>? orders;
  String? message;


}