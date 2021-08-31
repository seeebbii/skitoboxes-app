import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:skitoboxes/constants/colors.dart';
import 'package:skitoboxes/constants/controllers.dart';
import 'package:skitoboxes/controllers/product/product_controller.dart';
import 'package:skitoboxes/models/box.dart';
import 'package:skitoboxes/router/route_generator.dart';

class CategoryScreen extends StatefulWidget {
  CategoryScreen(
      {Key? key, @required this.categoryType, @required this.onDataChange})
      : super(key: key);

  Category? categoryType;
  final Function(Category)? onDataChange;

  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  ProductController productController = Get.put(ProductController());
  List<Box> _filterList = [];
  @override
  void initState() {
    super.initState();
    _filterList = productController.boxes
        .where((element) => element.category == widget.categoryType)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: ListView.builder(
        itemCount: _filterList.length,
        // gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        //     crossAxisCount: 2,
        //     crossAxisSpacing: 12,
        //     mainAxisSpacing: 12,
        //     childAspectRatio: 1.2),
        itemBuilder: (BuildContext context, int index) => InkWell(
          onTap: () {
            navigationController.navigateToWithArguments(
                boxDetails, _filterList[index]);
          },
          child: Stack(
            children: [
              Card(
                color: Colors.transparent,
                semanticContainer: true,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                child: Hero(
                  tag: _filterList[index].id!,
                  child: Image.network(
                    _filterList[index].image!,
                    fit: BoxFit.fill,
                  ),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                elevation: 5,
                margin: const EdgeInsets.all(8),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 60),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 60, vertical: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.black.withOpacity(0.2),
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Text(
                            _filterList[index].name!,
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 2),
                          child: Text(
                            '${_filterList[index].items!.length.toString()} Items',
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 2),
                          child: Text(
                            'Rs. ${_filterList[index].price.toString().split('.').first}',
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                          ),
                        ),
                      ],
                    ),
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
