import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skitoboxes/constants/colors.dart';
import 'package:skitoboxes/constants/controllers.dart';
import 'package:skitoboxes/controllers/product/product_controller.dart';
import 'package:skitoboxes/router/route_generator.dart';

class OrderConfirmedScreen extends StatelessWidget {
  OrderConfirmedScreen({Key? key}) : super(key: key);
  ProductController productController = Get.put(ProductController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
            children: [
          Container(
            child: Text(
              'Your order has been confirmed!',
              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(bottom: 20, top: 40),
            child: ElevatedButton(
              onPressed: () {
                productController.inCart.remove(
                    productController.inCart[0]);
                navigationController.getOffAll(homeScreen);
              },
              child: Text(
                'Go to Homescreen',
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                primary: darkBlue,
                elevation: 0,
                fixedSize: Size(400, 55),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          )
        ]),
      ),
    );
  }
}
