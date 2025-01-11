import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/add_to_cart_req.dart';
import '../models/order_registration_req.dart';

abstract class OrderFirebaseService {
  Future<Either> addToCart(AddToCartReq addToCartReq);
  Future<Either> getCartProducts();
  Future<Either> removeCartProduct(String id);
  Future<Either> orderRegistration(OrderRegistrationReq order);
  Future<Either> getOrders();
}

class OrderFirebaseServiceImpl extends OrderFirebaseService {
  @override
  Future<Either> addToCart(AddToCartReq addToCartReq) async {
    try {
      var user = FirebaseAuth.instance.currentUser;
      await FirebaseFirestore.instance
          .collection('Users')
          .doc(user!.uid)
          .collection('Cart')
          .add(addToCartReq.toMap());
      return const Right('Đã thêm vào giỏ');
    } catch (e) {
      return const Left('Vui lòng thử lại');
    }
  }

  @override
  Future<Either> getCartProducts() async {
    try {
      var user = FirebaseAuth.instance.currentUser;
      var returnedData = await FirebaseFirestore.instance
          .collection('Users')
          .doc(user!.uid)
          .collection('Cart')
          .get();

      List<Map> products = [];
      for (var item in returnedData.docs) {
        var data = item.data();
        data.addAll({'id': item.id});
        products.add(data);
      }
      return Right(products);
    } catch (e) {
      return const Left('Vui lòng thử lại');
    }
  }

  @override
  Future<Either> removeCartProduct(String id) async {
    try {
      var user = FirebaseAuth.instance.currentUser;
      await FirebaseFirestore.instance
          .collection('Users')
          .doc(user!.uid)
          .collection('Cart')
          .doc(id)
          .delete();
      return const Right('Sản phẩm đã được xóa thành công');
    } catch (e) {
      return const Left('Vui lòng thử lại');
    }
  }

  Future<String> _generateUniqueCode() async {
    String code;
    bool exists = true;

    do {
      // Sinh mã 6 chữ số ngẫu nhiên
      code = (Random().nextInt(900000) + 100000).toString();

      // Kiểm tra mã có tồn tại trong Firestore không
      var querySnapshot = await FirebaseFirestore.instance
          .collectionGroup('Orders')
          .where('code', isEqualTo: code)
          .get();

      exists = querySnapshot.docs.isNotEmpty;
    } while (exists); // Lặp lại nếu mã đã tồn tại

    return code;
  }

  @override
  Future<Either> orderRegistration(OrderRegistrationReq order) async {
    try {
      var user = FirebaseAuth.instance.currentUser;

      // Tạo mã đơn hàng (code)
      String orderCode = await _generateUniqueCode();

      // Tạo trạng thái đơn hàng với các title khác nhau
      List<Map<String, dynamic>> initialOrderStatus = [
        {
          'title': 'Đã đặt',
          'createdDate': Timestamp.now(),
          'done': true,
        },
        {
          'title': 'Đã xác nhận',
          'createdDate': Timestamp.now(),
          'done': false,
        },
        {
          'title': 'Vận chuyển',
          'createdDate': Timestamp.now(),
          'done': false,
        },
      ];

      // Chuyển dữ liệu order thành Map và thêm code + orderStatus
      Map<String, dynamic> orderData = order.toMap();
      orderData['code'] = orderCode;
      orderData['orderStatus'] = initialOrderStatus;

      // Lưu dữ liệu vào Firestore
      await FirebaseFirestore.instance
          .collection('Users')
          .doc(user!.uid)
          .collection('Orders')
          .add(orderData);

      for (var item in order.products) {
        await FirebaseFirestore.instance
            .collection('Users')
            .doc(user.uid)
            .collection('Cart')
            .doc(item.id)
            .delete();
      }

      return const Right('Đặt hàng thành công');
    } catch (e) {
      return const Left('Vui lòng thử lại');
    }
  }

  @override
  Future<Either> getOrders() async {
    try {
      var user = FirebaseAuth.instance.currentUser;
      var returnedData = await FirebaseFirestore.instance
          .collection("Users")
          .doc(user!.uid)
          .collection('Orders')
          .get();
      return Right(returnedData.docs.map((e) => e.data()).toList());
    } catch (e) {
      return const Left('Vui lòng thử lại');
    }
  }
}
