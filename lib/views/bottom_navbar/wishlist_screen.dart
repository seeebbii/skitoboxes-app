import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skitoboxes/constants/controllers.dart';
import 'package:skitoboxes/controllers/product/product_controller.dart';
import 'package:skitoboxes/router/route_generator.dart';
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
            backgroundColor: Colors.white,
            elevation: 0,
            title: Text('Wishlist'),
            automaticallyImplyLeading: false,
            leading: Builder(
              builder: (context) => IconButton(
                  icon: Icon(Icons.border_all_rounded),
                  onPressed: () => Scaffold.of(context).openDrawer()),
            ),
            actions: [
              IconButton(
                icon: Icon(Icons.search_outlined),
                onPressed: () {},
              ),
              Obx(
                () => Badge(
                  badgeColor: Colors.black,
                  position: BadgePosition.topEnd(top: 5, end: 5),
                  animationType: BadgeAnimationType.scale,
                  badgeContent: Text(productController.inCart.length.toString(),
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(color: Colors.white, fontSize: 12)),
                  child: IconButton(
                    icon: Icon(Icons.card_travel_outlined),
                    onPressed: () {
                      navigationController.navigateTo(cart);
                    },
                  ),
                ),
              )
            ]),
        body: Obx(() => productController.favoriteBoxes.isEmpty
            ? Center(child: Text('No items in wishlist'))
            : ProductItem(filterList: productController.favoriteBoxes)),
      ),
    );
  }
}
