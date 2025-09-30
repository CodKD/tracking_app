
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:tracking_app/core/resources/firebase_constants.dart';
@injectable
@lazySingleton
class FirebaseManager {
  Future<void> updateOrderDetails(
      String orderId, Map<String, dynamic> data) async {
    FirebaseFirestore.instance
        .collection(FirebaseConstants.ordersCollection)
        .doc(orderId)
        .update(data);
  }
}
