import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skitoboxes/constants/controllers.dart';
import 'package:skitoboxes/controllers/product/product_controller.dart';
import 'package:skitoboxes/models/box.dart';
import 'package:skitoboxes/router/route_generator.dart';
import 'package:skitoboxes/widgets/product_item.dart';

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
    return ListView.builder(
        itemCount: _filterList.length,
        itemBuilder: (BuildContext context, int index) => InkWell(
              onTap: () {
                navigationController.navigateToWithArguments(
                    boxDetails, {"boxDetails": _filterList[index]});
              },
              child: ProductItem(box: _filterList[index]),
            ));
  }
}
