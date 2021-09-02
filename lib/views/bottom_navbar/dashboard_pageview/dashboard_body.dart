import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skitoboxes/constants/colors.dart';
import 'package:skitoboxes/constants/controllers.dart';
import 'package:skitoboxes/controllers/product/product_controller.dart';
import 'package:skitoboxes/models/box.dart';
import 'package:skitoboxes/router/route_generator.dart';
import 'package:skitoboxes/views/bottom_navbar/dashboard_pageview/category_screen.dart';
import 'package:skitoboxes/views/bottom_navbar/dashboard_pageview/dashboard_screen.dart';
import 'package:skitoboxes/widgets/custom_drawer.dart';


class DashboardBody extends StatefulWidget {
  DashboardBody({Key? key}) : super(key: key);

  @override
  _DashboardBodyState createState() => _DashboardBodyState();
}

class _DashboardBodyState extends State<DashboardBody> {
  ProductController _productController = Get.put(ProductController());
  int _currentPageIndex = 0;
  Category? categoryType;
  void onDataChange(Category newData) {
    setState(() => categoryType = newData);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: CustomDrawer(),
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(70),
          child: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.white,
            elevation: 0,
            leading: _currentPageIndex == 0
                ? Builder(
                    builder: (context) => IconButton(
                        icon: Icon(Icons.border_all_rounded),
                        onPressed: () => Scaffold.of(context).openDrawer()),
                  )
                : IconButton(
                    onPressed: () {
                      navigationController.categoryPageController.animateToPage(
                          0,
                          duration: Duration(milliseconds: 500),
                          curve: Curves.fastOutSlowIn);
                    },
                    icon: Icon(Icons.arrow_back)),
            title: _currentPageIndex == 0
                ? Text('Dashboard')
                : Text(categoryType.toString().split('.').last),
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
                  badgeContent: Text(
                      _productController.inCart.length.toString(),
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
            ],
          ),
        ),
        body: PageView(
          physics: NeverScrollableScrollPhysics(),
          controller: navigationController.categoryPageController,
          onPageChanged: (index) => setState(() => _currentPageIndex = index),
          children: [
            DashboardScreen(
              categoryType: categoryType,
              onDataChange: onDataChange,
            ),
            CategoryScreen(
              categoryType: categoryType,
              onDataChange: onDataChange,
            ),
          ],
        ),
      ),
    );
  }
}
