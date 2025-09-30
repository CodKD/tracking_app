import 'package:json_annotation/json_annotation.dart';
import 'package:tracking_app/features/home/presentation/Tabs/home_tab/domain/entities/pending_orders_entity.dart';


part 'pending_orders_response.g.dart'; // هذا الملف سيتم إنشاؤه تلقائيًا

/// --------------------------------------------------------------------------------
/// PendingOrdersResponse
/// --------------------------------------------------------------------------------

@JsonSerializable(explicitToJson: true)
class PendingOrdersResponse {
  PendingOrdersResponse({
    this.message,
    this.metadata,
    this.orders,
  });

  factory PendingOrdersResponse.fromJson(Map<String, dynamic> json) => _$PendingOrdersResponseFromJson(json);

  @JsonKey(name: 'message')
  final String? message;

  @JsonKey(name: 'metadata')
  final Metadata? metadata;

  @JsonKey(name: 'orders')
  final List<Orders>? orders;

  Map<String, dynamic> toJson() => _$PendingOrdersResponseToJson(this);

  // دالة التحويل إلى الـ Entity تبقى كما هي
  PendingDriverOrdersEntity toPendingDriverOrderEntity() {
    return PendingDriverOrdersEntity(
      metadata: metadata,
      orders: orders, // تحتاج إلى تعديل بسيط في طبقة الـ Entity لتقبل Orders كنوع
      message: message,
    );
  }
}

/// --------------------------------------------------------------------------------
/// Orders
/// --------------------------------------------------------------------------------

@JsonSerializable(explicitToJson: true)
class Orders {
  Orders({
    this.id,
    this.user,
    this.orderItems,
    this.totalPrice,
    this.paymentType,
    this.isPaid,
    this.isDelivered,
    this.state,
    this.createdAt,
    this.updatedAt,
    this.orderNumber,
    this.v,
    this.store,
  });

  factory Orders.fromJson(Map<String, dynamic> json) => _$OrdersFromJson(json);

  @JsonKey(name: '_id')
  final String? id;

  @JsonKey(name: 'user')
  final User? user;

  @JsonKey(name: 'orderItems')
  final List<OrderItems>? orderItems;

  @JsonKey(name: 'totalPrice')
  final num? totalPrice;

  @JsonKey(name: 'paymentType')
  final String? paymentType;

  @JsonKey(name: 'isPaid')
  final bool? isPaid;

  @JsonKey(name: 'isDelivered')
  final bool? isDelivered;

  @JsonKey(name: 'state')
  final String? state;

  @JsonKey(name: 'createdAt')
  final String? createdAt;

  @JsonKey(name: 'updatedAt')
  final String? updatedAt;

  @JsonKey(name: 'orderNumber')
  final String? orderNumber;

  @JsonKey(name: '__v')
  final num? v;

  @JsonKey(name: 'store')
  final Store? store;

  Map<String, dynamic> toJson() => _$OrdersToJson(this);
}

/// --------------------------------------------------------------------------------
/// Store
/// --------------------------------------------------------------------------------

@JsonSerializable()
class Store {
  Store({
    this.name,
    this.image,
    this.address,
    this.phoneNumber,
    this.latLong,
  });

  factory Store.fromJson(Map<String, dynamic> json) => _$StoreFromJson(json);

  @JsonKey(name: 'name')
  final String? name;

  @JsonKey(name: 'image')
  final String? image;

  @JsonKey(name: 'address')
  final String? address;

  @JsonKey(name: 'phoneNumber')
  final String? phoneNumber;

  @JsonKey(name: 'latLong')
  final String? latLong;

  Map<String, dynamic> toJson() => _$StoreToJson(this);
}

/// --------------------------------------------------------------------------------
/// OrderItems
/// --------------------------------------------------------------------------------

@JsonSerializable(explicitToJson: true)
class OrderItems {
  OrderItems({
    this.product,
    this.price,
    this.quantity,
    this.id,
  });

  factory OrderItems.fromJson(Map<String, dynamic> json) => _$OrderItemsFromJson(json);

  @JsonKey(name: 'product')
  final Product? product;

  @JsonKey(name: 'price')
  final num? price;

  @JsonKey(name: 'quantity')
  final num? quantity;

  @JsonKey(name: '_id')
  final String? id;

  Map<String, dynamic> toJson() => _$OrderItemsToJson(this);
}

/// --------------------------------------------------------------------------------
/// Product
/// --------------------------------------------------------------------------------

@JsonSerializable()
class Product {
  Product({
    this.id,
    this.title,
    this.slug,
    this.description,
    this.imgCover,
    this.images,
    this.price,
    this.priceAfterDiscount,
    this.quantity,
    this.category,
    this.occasion,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.discount,
    this.sold,
  });

  factory Product.fromJson(Map<String, dynamic> json) => _$ProductFromJson(json);

  @JsonKey(name: '_id')
  final String? id;

  @JsonKey(name: 'title')
  final String? title;

  @JsonKey(name: 'slug')
  final String? slug;

  @JsonKey(name: 'description')
  final String? description;

  @JsonKey(name: 'imgCover')
  final String? imgCover;

  @JsonKey(name: 'images')
  final List<String>? images;

  @JsonKey(name: 'price')
  final num? price;

  @JsonKey(name: 'priceAfterDiscount')
  final num? priceAfterDiscount;

  @JsonKey(name: 'quantity')
  final num? quantity;

  @JsonKey(name: 'category')
  final String? category;

  @JsonKey(name: 'occasion')
  final String? occasion;

  @JsonKey(name: 'createdAt')
  final String? createdAt;

  @JsonKey(name: 'updatedAt')
  final String? updatedAt;

  @JsonKey(name: '__v')
  final num? v;

  @JsonKey(name: 'discount')
  final num? discount;

  @JsonKey(name: 'sold')
  final num? sold;

  Map<String, dynamic> toJson() => _$ProductToJson(this);
}

/// --------------------------------------------------------------------------------
/// User
/// --------------------------------------------------------------------------------

@JsonSerializable()
class User {
  User({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.gender,
    this.phone,
    this.photo,
    this.passwordChangedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  @JsonKey(name: '_id')
  final String? id;

  @JsonKey(name: 'firstName')
  final String? firstName;

  @JsonKey(name: 'lastName')
  final String? lastName;

  @JsonKey(name: 'email')
  final String? email;

  @JsonKey(name: 'gender')
  final String? gender;

  @JsonKey(name: 'phone')
  final String? phone;

  @JsonKey(name: 'photo')
  final String? photo;

  @JsonKey(name: 'passwordChangedAt')
  final String? passwordChangedAt;

  Map<String, dynamic> toJson() => _$UserToJson(this);
}

/// --------------------------------------------------------------------------------
/// Metadata
/// --------------------------------------------------------------------------------

@JsonSerializable()
class Metadata {
  Metadata({
    this.currentPage,
    this.totalPages,
    this.totalItems,
    this.limit,
  });

  factory Metadata.fromJson(Map<String, dynamic> json) => _$MetadataFromJson(json);

  @JsonKey(name: 'currentPage')
  final num? currentPage;

  @JsonKey(name: 'totalPages')
  final num? totalPages;

  @JsonKey(name: 'totalItems')
  final num? totalItems;

  @JsonKey(name: 'limit')
  final num? limit;

  Map<String, dynamic> toJson() => _$MetadataToJson(this);
}