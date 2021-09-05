import 'package:flutter/material.dart';
import 'package:skitoboxes/models/box.dart';

class ProductItem extends StatelessWidget {
  ProductItem({Key? key, this.box}) : super(key: key);

  Box? box;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Stack(
        children: [
          Card(
            color: Colors.transparent,
            semanticContainer: true,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            child: Hero(
              tag: box!.id!,
              child: Image.asset(
                'assets/images/box.png',
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 60, vertical: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.black.withOpacity(0.2),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Text(
                        box!.name!,
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 2),
                      child: Text(
                        '${box!.items!.length.toString()} Items',
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 2),
                      child: Text(
                        'Rs. ${box!.price.toString().split('.').first}',
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
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
    );
  }
}
