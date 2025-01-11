// import 'package:ecommerce/common/widgets/appbar/app_bar.dart';
// import 'package:ecommerce/presentation/settings/widgets/my_orders_tile.dart';
// import 'package:flutter/material.dart';

// import '../widgets/my_favorties_tile.dart';

// class SettingsPage extends StatelessWidget {
//   const SettingsPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const Scaffold(
//       appBar: BasicAppbar(
//         title: Text(
//           'Settings'
//         ),
//       ),
//       body: Padding(
//         padding: EdgeInsets.all(16),
//         child: Column(
//           children: [
//             MyFavortiesTile(),
//             SizedBox(height: 15,),
//             MyOrdersTile()
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:ecommerce/common/helper/navigator/app_navigator.dart';
import 'package:ecommerce/common/widgets/appbar/app_bar.dart';
import 'package:ecommerce/presentation/auth/pages/siginin.dart';
import 'package:ecommerce/presentation/settings/widgets/my_orders_tile.dart';
import 'package:flutter/material.dart';

import '../widgets/my_favorties_tile.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BasicAppbar(
        title: Text(
          'Cài đặt',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const MyFavortiesTile(),
            const SizedBox(height: 15),
            const MyOrdersTile(),
            const SizedBox(height: 15),
            ElevatedButton(
              onPressed: () {
                // Điều hướng đến màn hình đăng nhập
                AppNavigator.pushReplacement(
                  context,
                  SigninPage(),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
              ),
              child: const Text('Đăng Xuất'),
            ),
          ],
        ),
      ),
    );
  }
}
