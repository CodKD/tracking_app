// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pending_orders_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PendingOrdersResponse _$PendingOrdersResponseFromJson(
  Map<String, dynamic> json,
) => PendingOrdersResponse(
  message: json['message'] as String?,
  metadata: json['metadata'] == null
      ? null
      : Metadata.fromJson(json['metadata'] as Map<String, dynamic>),
  orders: (json['orders'] as List<dynamic>?)
      ?.map((e) => Orders.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$PendingOrdersResponseToJson(
  PendingOrdersResponse instance,
) => <String, dynamic>{
  'message': instance.message,
  'metadata': instance.metadata?.toJson(),
  'orders': instance.orders?.map((e) => e.toJson()).toList(),
};

Orders _$OrdersFromJson(Map<String, dynamic> json) => Orders(
  id: json['_id'] as String?,
  user: json['user'] == null
      ? null
      : User.fromJson(json['user'] as Map<String, dynamic>),
  orderItems: (json['orderItems'] as List<dynamic>?)
      ?.map((e) => OrderItems.fromJson(e as Map<String, dynamic>))
      .toList(),
  totalPrice: json['totalPrice'] as num?,
  paymentType: json['paymentType'] as String?,
  isPaid: json['isPaid'] as bool?,
  isDelivered: json['isDelivered'] as bool?,
  state: json['state'] as String?,
  createdAt: json['createdAt'] as String?,
  updatedAt: json['updatedAt'] as String?,
  orderNumber: json['orderNumber'] as String?,
  v: json['__v'] as num?,
  store: json['store'] == null
      ? null
      : Store.fromJson(json['store'] as Map<String, dynamic>),
);

Map<String, dynamic> _$OrdersToJson(Orders instance) => <String, dynamic>{
  '_id': instance.id,
  'user': instance.user?.toJson(),
  'orderItems': instance.orderItems?.map((e) => e.toJson()).toList(),
  'totalPrice': instance.totalPrice,
  'paymentType': instance.paymentType,
  'isPaid': instance.isPaid,
  'isDelivered': instance.isDelivered,
  'state': instance.state,
  'createdAt': instance.createdAt,
  'updatedAt': instance.updatedAt,
  'orderNumber': instance.orderNumber,
  '__v': instance.v,
  'store': instance.store?.toJson(),
};

Store _$StoreFromJson(Map<String, dynamic> json) => Store(
  name: json['name'] as String?,
  image: json['image'] as String?,
  address: json['address'] as String?,
  phoneNumber: json['phoneNumber'] as String?,
  latLong: json['latLong'] as String?,
);

Map<String, dynamic> _$StoreToJson(Store instance) => <String, dynamic>{
  'name': instance.name,
  'image': instance.image,
  'address': instance.address,
  'phoneNumber': instance.phoneNumber,
  'latLong': instance.latLong,
};

OrderItems _$OrderItemsFromJson(Map<String, dynamic> json) => OrderItems(
  product: json['product'] == null
      ? null
      : Product.fromJson(json['product'] as Map<String, dynamic>),
  price: json['price'] as num?,
  quantity: json['quantity'] as num?,
  id: json['_id'] as String?,
);

Map<String, dynamic> _$OrderItemsToJson(OrderItems instance) =>
    <String, dynamic>{
      'product': instance.product?.toJson(),
      'price': instance.price,
      'quantity': instance.quantity,
      '_id': instance.id,
    };

Product _$ProductFromJson(Map<String, dynamic> json) => Product(
  id: json['_id'] as String?,
  title: json['title'] as String?,
  slug: json['slug'] as String?,
  description: json['description'] as String?,
  imgCover: json['imgCover'] as String?,
  images: (json['images'] as List<dynamic>?)?.map((e) => e as String).toList(),
  price: json['price'] as num?,
  priceAfterDiscount: json['priceAfterDiscount'] as num?,
  quantity: json['quantity'] as num?,
  category: json['category'] as String?,
  occasion: json['occasion'] as String?,
  createdAt: json['createdAt'] as String?,
  updatedAt: json['updatedAt'] as String?,
  v: json['__v'] as num?,
  discount: json['discount'] as num?,
  sold: json['sold'] as num?,
);

Map<String, dynamic> _$ProductToJson(Product instance) => <String, dynamic>{
  '_id': instance.id,
  'title': instance.title,
  'slug': instance.slug,
  'description': instance.description,
  'imgCover': instance.imgCover,
  'images': instance.images,
  'price': instance.price,
  'priceAfterDiscount': instance.priceAfterDiscount,
  'quantity': instance.quantity,
  'category': instance.category,
  'occasion': instance.occasion,
  'createdAt': instance.createdAt,
  'updatedAt': instance.updatedAt,
  '__v': instance.v,
  'discount': instance.discount,
  'sold': instance.sold,
};

User _$UserFromJson(Map<String, dynamic> json) => User(
  id: json['_id'] as String?,
  firstName: json['firstName'] as String?,
  lastName: json['lastName'] as String?,
  email: json['email'] as String?,
  gender: json['gender'] as String?,
  phone: json['phone'] as String?,
  photo: json['photo'] as String?,
  passwordChangedAt: json['passwordChangedAt'] as String?,
);

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
  '_id': instance.id,
  'firstName': instance.firstName,
  'lastName': instance.lastName,
  'email': instance.email,
  'gender': instance.gender,
  'phone': instance.phone,
  'photo': instance.photo,
  'passwordChangedAt': instance.passwordChangedAt,
};

Metadata _$MetadataFromJson(Map<String, dynamic> json) => Metadata(
  currentPage: json['currentPage'] as num?,
  totalPages: json['totalPages'] as num?,
  totalItems: json['totalItems'] as num?,
  limit: json['limit'] as num?,
);

Map<String, dynamic> _$MetadataToJson(Metadata instance) => <String, dynamic>{
  'currentPage': instance.currentPage,
  'totalPages': instance.totalPages,
  'totalItems': instance.totalItems,
  'limit': instance.limit,
};
