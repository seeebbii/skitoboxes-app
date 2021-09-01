import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skitoboxes/controllers/product/product_controller.dart';
import 'package:skitoboxes/models/box.dart';

class CartScreen extends StatelessWidget {
  CartScreen({Key? key}) : super(key: key);

  ProductController productController = Get.put(ProductController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Cart'),
      ),
      body: Obx(
        () => productController.inCart.isEmpty
            ? Center(child: Text('Cart is empty'))
            : ListView.builder(
                itemCount: productController.inCart.length,
                itemBuilder: (BuildContext context, int index) => Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Card(
                    elevation: 5,
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.7,
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.asset(
                                  'assets/images/box.png',
                                  width: 100,
                                  height: 100,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Flexible(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15, vertical: 2),
                                      child: Text(
                                        productController.inCart[index].category
                                            .toString()
                                            .split('.')
                                            .last,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1!
                                            .copyWith(
                                                color: Colors.grey.shade400),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15, vertical: 2),
                                      child: Text(
                                        productController.inCart[index].name!,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1!
                                            .copyWith(fontSize: 17),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15, vertical: 5),
                                      child: Text(
                                        'Rs. ${productController.inCart[index].price.toString().split('.').first}',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1!
                                            .copyWith(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                            icon: Icon(Icons.delete_outline),
                            color: Colors.red,
                            onPressed: () {
                              productController.inCart
                                  .remove(productController.inCart[index]);
                            }),
                      ],
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
