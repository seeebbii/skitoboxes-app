import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:skitoboxes/constants/controllers.dart';
import 'package:skitoboxes/models/box.dart';
import 'package:skitoboxes/views/bottom_navbar/dashboard_pageview/category_screen.dart';
import 'package:skitoboxes/views/bottom_navbar/dashboard_pageview/dashboard_screen.dart';
import 'package:skitoboxes/widgets/custom_drawer.dart';

class DashboardBody extends StatefulWidget {
  DashboardBody({Key? key}) : super(key: key);

  @override
  _DashboardBodyState createState() => _DashboardBodyState();
}

class _DashboardBodyState extends State<DashboardBody> {
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
                ? Text('')
                : Text(categoryType.toString().split('.').last),
            actions: [
              IconButton(
                icon: Icon(Icons.search_outlined),
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(Icons.card_travel_outlined),
                onPressed: () {},
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
