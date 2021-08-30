import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:skitoboxes/constants/colors.dart';
import 'package:skitoboxes/constants/controllers.dart';

class CategoryScreen extends StatefulWidget {
  CategoryScreen(
      {Key? key, @required this.categoryType, @required this.onDataChange})
      : super(key: key);

  String? categoryType;
  final Function(String)? onDataChange;

  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  List<int> boxesList = [1, 2, 3, 4, 5, 6, 7];
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: GridView.builder(
        itemCount: boxesList.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 1,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 1.2),
        itemBuilder: (BuildContext context, int index) => InkWell(
          onTap: () {},
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Container(
                color: darkBlue,
                child: Center(
                  child: Text('Box ${boxesList[index]}',
                      style: TextStyle(
                        color: Colors.white,
                      )),
                )),
          ),
        ),
      ),
    );
  }
}
