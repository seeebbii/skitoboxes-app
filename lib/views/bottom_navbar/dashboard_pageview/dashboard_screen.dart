import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:skitoboxes/constants/controllers.dart';

class DashboardScreen extends StatefulWidget {
  DashboardScreen(
      {Key? key, @required this.categoryType, @required this.onDataChange})
      : super(key: key);

  String? categoryType;
  final Function(String)? onDataChange;

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  List<int> carouselImgList = [1, 2, 3, 4];
  List<String> allCategoriesList = [
    'Sncacks',
    'Beauty',
    'Books',
    'Health',
    'Selfcare',
    'Fashion',
    'Stationery'
  ];
  var _currentCarouselIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.3,
            width: MediaQuery.of(context).size.width * 0.9,
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              child: Center(
                  child: CarouselSlider(
                options: CarouselOptions(
                    initialPage: 0,
                    autoPlayInterval: Duration(seconds: 3),
                    autoPlayAnimationDuration: Duration(milliseconds: 800),
                    autoPlayCurve: Curves.fastOutSlowIn,
                    onPageChanged: (index, reason) {
                      setState(() {
                        _currentCarouselIndex = index;
                      });
                    }),
                items: carouselImgList.map((i) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20)),
                          child: Center(
                            child: Text(
                              'Image $i',
                              style: TextStyle(fontSize: 16.0),
                            ),
                          ));
                    },
                  );
                }).toList(),
              )),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: carouselImgList.map(
              (image) {
                int index = carouselImgList.indexOf(image);
                return Container(
                  width: 10,
                  height: 10,
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 8),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _currentCarouselIndex == index
                          ? Theme.of(context).accentColor
                          : Theme.of(context).accentColor.withOpacity(0.3)),
                );
              },
            ).toList(),
          ),
          Container(
            alignment: Alignment.topLeft,
            margin: EdgeInsets.symmetric(vertical: 10),
            child: Text(
              'Skito Category',
              style: Theme.of(context)
                  .primaryTextTheme
                  .headline5!
                  .copyWith(fontFamily: 'Avenir'),
            ),
          ),
          Expanded(
            child: StaggeredGridView.countBuilder(
              crossAxisCount: 4,
              itemCount: allCategoriesList.length,
              itemBuilder: (BuildContext context, int index) => InkWell(
                onTap: () {
                  widget.onDataChange!(allCategoriesList[index]);
                  navigationController.categoryPageController.animateToPage(1,
                      duration: Duration(milliseconds: 500),
                      curve: Curves.fastOutSlowIn);
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                      color: Theme.of(context).primaryColor,
                      child: Center(
                        child: Text('${allCategoriesList[index]}'),
                      )),
                ),
              ),
              staggeredTileBuilder: (int index) =>
                  StaggeredTile.count(2, index.isEven ? 3 : 2),
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
            ),
          ),
        ],
      ),
    );
  }
}
