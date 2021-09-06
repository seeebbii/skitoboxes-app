import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:skitoboxes/constants/colors.dart';
import 'package:skitoboxes/constants/controllers.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:skitoboxes/router/route_generator.dart';

class ManagePaymentScreen extends StatefulWidget {
  const ManagePaymentScreen({Key? key}) : super(key: key);

  @override
  _ManagePaymentScreenState createState() => _ManagePaymentScreenState();
}

class _ManagePaymentScreenState extends State<ManagePaymentScreen> {
  var _currentCarouselIndex = 0;

  void _onTapCard(value) {
    setState(() {
      orderController.selectedPaymentCard = value;
    });
  }

  void initState() {
    if (orderController.selectedPaymentCard == null) {
      orderController.selectedPaymentCard = 0;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Manage Payments'),
        centerTitle: true,
      ),
      body: orderController.paymentCards.isEmpty
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Text('No card/payment method added yet!',
                      style: Theme.of(context).textTheme.bodyText1),
                ),
                TextButton(
                  onPressed: () {
                    navigationController.navigateTo(addPayment).then((value) {
                      setState(() {});
                    });
                  },
                  child: Text('Add Card'),
                ),
              ],
            )
          : Column(
              children: [
                // Expanded(
                //   child: ListView.builder(
                //     itemCount: orderController.paymentCards.length,
                //     itemBuilder: (context, index) {
                //       return InkWell(
                //         onTap: () {
                //           _onTapCard(index);
                //         },
                //         child: CreditCardWidget(
                //           cardNumber:
                //               orderController.paymentCards[index].cardNumber!,
                //           cardHolderName: orderController
                //               .paymentCards[index].cardHolderName!,
                //           expiryDate:
                //               orderController.paymentCards[index].expiryDate!,
                //           cvvCode: orderController.paymentCards[index].cvv!,
                //           showBackView: false,
                //         ),
                //       );
                //     },
                //   ),
                // ),
                Center(
                    child: CarouselSlider(
                  options: CarouselOptions(
                      initialPage: orderController.selectedPaymentCard,
                      enableInfiniteScroll: false,
                      aspectRatio: 1.5,
                      viewportFraction: 1,
                      enlargeCenterPage: true,
                      onPageChanged: (index, reason) {
                        setState(() {
                          _currentCarouselIndex = index;
                          orderController.selectedPaymentCard = index;
                        });
                      }),
                  items: orderController.paymentCards.map((i) {
                    return Builder(
                      builder: (BuildContext context) {
                        return CreditCardWidget(
                          cardNumber: i.cardNumber!,
                          cardHolderName: i.cardHolderName!,
                          expiryDate: i.expiryDate!,
                          cvvCode: i.cvv!,
                          showBackView: false,
                        );
                      },
                    );
                  }).toList(),
                )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: orderController.paymentCards.map(
                    (image) {
                      int index = orderController.paymentCards.indexOf(image);
                      return Container(
                        width: 10,
                        height: 10,
                        margin:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 4),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: _currentCarouselIndex == index
                                ? Theme.of(context).accentColor
                                : Theme.of(context)
                                    .accentColor
                                    .withOpacity(0.3)),
                      );
                    },
                  ).toList(),
                ),
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: ElevatedButton(
                    onPressed: () {
                      navigationController
                          .navigateTo(addPayment)
                          .then((value) => setState(() {}));
                    },
                    child: Text(
                      'Add New Card',
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(primary: darkBlue),
                  ),
                ),
              ],
            ),
    );
  }
}
