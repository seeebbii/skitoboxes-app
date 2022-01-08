import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skitoboxes/controllers/product/product_controller.dart';

class PendingOrdersScreen extends StatelessWidget {
  PendingOrdersScreen({Key? key}) : super(key: key);
  ProductController productController = Get.put(ProductController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pending Orders'),
      ),
      body: productController.inCart.isEmpty
          ? Center(child: Text('No pending orders'))
          : InkWell(
              onTap: () {},
              child: Card(
                elevation: 5,
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.asset(
                        'assets/images/box.png',
                        width: 120,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Expanded(
                      child: ListTile(
                        title: Text(
                          '${productController.inCart[0].name}',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                          'Rs. ${productController.inCart[0].price}',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(
                                  fontSize: 12, color: Colors.grey.shade700),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
