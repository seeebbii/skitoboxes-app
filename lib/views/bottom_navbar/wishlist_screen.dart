import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skitoboxes/controllers/product/product_controller.dart';
import 'package:skitoboxes/widgets/custom_drawer.dart';
import 'package:skitoboxes/widgets/product_item.dart';

class WishlistScreen extends StatelessWidget {
  WishlistScreen({
    Key? key,
  }) : super(key: key);
  ProductController productController = Get.put(ProductController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: CustomDrawer(),
        appBar: AppBar(
          title: Text('Wishlist'),
          automaticallyImplyLeading: false,
          leading: Builder(
            builder: (context) => IconButton(
                icon: Icon(Icons.border_all_rounded),
                onPressed: () => Scaffold.of(context).openDrawer()),
          ),
        ),
        body: Obx(() => productController.favoriteBoxes.isEmpty
            ? Center(child: Text('No items in wishlist'))
            : ProductItem(filterList: productController.favoriteBoxes)),
      ),
    );
  }
}
