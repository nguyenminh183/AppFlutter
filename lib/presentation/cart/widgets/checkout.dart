import 'package:ecommerce/common/helper/cart/cart.dart';
import 'package:ecommerce/common/helper/navigator/app_navigator.dart';
import 'package:ecommerce/common/widgets/button/basic_app_button.dart';
import 'package:ecommerce/core/configs/theme/app_colors.dart';
import 'package:ecommerce/presentation/cart/pages/checkout.dart';
import 'package:flutter/material.dart';

import '../../../domain/order/entities/product_ordered.dart';

class Checkout extends StatelessWidget {
  final List<ProductOrderedEntity> products;
  const Checkout({
    required this.products,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      height: MediaQuery.of(context).size.height / 3.5,
      color: AppColors.background,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Giá sản phẩm',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 16
                ),
              ),
              Text(
                '${CartHelper.calculateCartSubtotal(products).toString()} VND',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16
                ),
              )
            ],
          ),
             const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Phí vận chuyển',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 16
                ),
              ),
              Text(
                '30000 VND',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16
                ),
              )
            ],
          ),
          //    const Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: [SS
          //     // Text(
          //     //   'Tax',
          //     //   style: TextStyle(
          //     //     color: Colors.grey,
          //     //     fontSize: 16
          //     //   ),
          //     // ),
          //     // Text(
          //     //   '\$0.0',
          //     //   style: TextStyle(
          //     //     fontWeight: FontWeight.bold,
          //     //     fontSize: 16
          //     //   ),
          //     // )
          //   ],
          // ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Tổng thanh toán',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 16
                ),
              ),
              Text(
                '${CartHelper.calculateCartSubtotal(products) + 30000 } VND',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16
                ),
              )
            ],
          ),
          BasicAppButton(
            onPressed: (){
              AppNavigator.push(context, CheckOutPage(products: products,));
            },
            title: 'Thanh toán',
          )
        ],
      ),
    );
  }
}