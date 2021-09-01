import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:like_button/like_button.dart';
import 'package:skitoboxes/constants/colors.dart';
import 'package:skitoboxes/constants/controllers.dart';
import 'package:skitoboxes/controllers/product/product_controller.dart';
import 'package:skitoboxes/models/box.dart';
import 'package:skitoboxes/router/route_generator.dart';
import 'package:badges/badges.dart';

class BoxDetails extends StatefulWidget {
  BoxDetails({Key? key, @required this.box}) : super(key: key);

  final Box? box;

  @override
  _BoxDetailsState createState() => _BoxDetailsState();
}

class _BoxDetailsState extends State<BoxDetails> {
  ProductController _productController = Get.put(ProductController());
  bool? isFav;
  int? _selectedPurchaseType;
  bool? addedToCart;

  void _purchaseType(value) {
    setState(() {
      _selectedPurchaseType = value;
    });
  }

  Future<bool> onLikeButtonTapped(bool isLiked) async {
    if (isFav == false) {
      _productController.favoriteBoxes.add(widget.box!);
    } else {
      setState(() {
        isFav = false;
      });
      _productController.favoriteBoxes.remove(widget.box!);
    }

    return !isLiked;
  }

  void onAddToCard() {
    if (addedToCart == false) {
      _productController.inCart.add(widget.box!);
      setState(() {
        addedToCart = true;
      });
    } else {
      setState(() {
        addedToCart = false;
      });
      _productController.inCart.remove(widget.box!);
    }
  }

  @override
  void initState() {
    setState(() {
      isFav = _productController.favoriteBoxes.contains(widget.box!);
      addedToCart = _productController.inCart.contains(widget.box!);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          Badge(
            badgeColor: Colors.white,
            position: BadgePosition.topEnd(top: 5, end: 5),
            animationType: BadgeAnimationType.scale,
            badgeContent: Text(_productController.inCart.length.toString(),
                style: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(color: Colors.black54, fontSize: 12)),
            child: IconButton(
              icon: Icon(Icons.card_travel_outlined),
              onPressed: () {
                navigationController.navigateTo(cart);
              },
            ),
          )
        ],
      ),
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              ClipRRect(
                  child: Hero(
                tag: widget.box!.id!,
                child: Image.asset(
                  'assets/images/box.png',
                  height: 300,
                  fit: BoxFit.cover,
                  alignment: Alignment.topCenter,
                ),
              )),
              SizedBox(height: MediaQuery.of(context).size.height * 0.01),
              ListTile(
                title: Text(
                  widget.box!.name!,
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                subtitle: Text(
                  'Rs. ${widget.box!.price}',
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        letterSpacing: 1,
                        color: Colors.grey.shade600,
                      ),
                ),
                trailing: Container(
                  width: 60,
                  height: 60,
                  child: LikeButton(
                      onTap: onLikeButtonTapped,
                      likeBuilder: (bool isLiked) {
                        if (isFav != false) {
                          return Icon(Icons.favorite, color: orange);
                        }
                        return Icon(Icons.favorite,
                            color: isLiked ? orange : Colors.grey);
                      }),
                ),
              ),
              ListTile(
                title: Text(
                  'What\'s Inside:',
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                subtitle: Text(
                  '${widget.box!.items!.join('\n')}',
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        letterSpacing: 1,
                        color: Colors.grey.shade600,
                      ),
                ),
              ),
              ListTile(
                title: Text(
                  'Description',
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                subtitle: Text(
                  '${widget.box!.description}',
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        letterSpacing: 1,
                        color: Colors.grey.shade600,
                      ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                child: InkWell(
                  onTap: () {
                    _purchaseType(0);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: lightBlue, width: 2),
                    ),
                    child: ListTile(
                      minLeadingWidth: 20,
                      leading: _selectedPurchaseType == 0
                          ? Icon(
                              Icons.radio_button_checked,
                              color: darkBlue,
                            )
                          : Icon(Icons.radio_button_unchecked),
                      title: Text(
                        'One-time Purchase',
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1!
                            .copyWith(fontSize: 16, color: darkBlue),
                      ),
                      trailing: Text(
                        'Rs. ${widget.box!.price}',
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            fontWeight: FontWeight.bold, color: darkBlue),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                child: InkWell(
                  onTap: () {
                    _purchaseType(1);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: lightBlue, width: 2),
                    ),
                    child: ListTile(
                      minLeadingWidth: 20,
                      leading: _selectedPurchaseType == 1
                          ? Icon(
                              Icons.radio_button_checked,
                              color: darkBlue,
                            )
                          : Icon(Icons.radio_button_unchecked),
                      title: Text(
                        'Subscribe & Save 10%',
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1!
                            .copyWith(fontSize: 16, color: darkBlue),
                      ),
                      trailing: Text(
                        'Rs. ${widget.box!.price! * 0.90}',
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            fontWeight: FontWeight.bold, color: darkBlue),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                child: ElevatedButton(
                  onPressed: _selectedPurchaseType != null ? onAddToCard : null,
                  child: _selectedPurchaseType == 0
                      ? addedToCart == false
                          ? purchaseTypeButton(context, 'Add To Cart')
                          : purchaseTypeButton(context, 'Remove From Cart')
                      : purchaseTypeButton(context, 'Place Order'),
                  style: ElevatedButton.styleFrom(
                    primary: darkBlue,
                    elevation: 0,
                    fixedSize: Size(400, 55),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Text purchaseTypeButton(BuildContext context, String? text) {
    return Text(
      text!,
      style: Theme.of(context).textTheme.bodyText1!.copyWith(
          fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
    );
  }
}
