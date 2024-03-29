import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skitoboxes/constants/colors.dart';
import 'package:skitoboxes/constants/controllers.dart';
import 'package:skitoboxes/controllers/product/product_controller.dart';
import 'package:skitoboxes/router/route_generator.dart';
import 'package:skitoboxes/views/profile_settings/address/address_form.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({Key? key}) : super(key: key);

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  ProductController productController = Get.put(ProductController());

  TextEditingController voucherController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Payment'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(vertical: 15),
                alignment: Alignment.topLeft,
                child: Text('Address',
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(fontSize: 16, fontWeight: FontWeight.bold)),
              ),
              orderController.address.isEmpty
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                          child: Text('No address added yet!',
                              style: Theme.of(context).textTheme.bodyText1),
                        ),
                        TextButton(
                          onPressed: () {
                            navigationController
                                .navigateToWithArguments(addressForm, {
                              'typeMode': FormType.addNew,
                              'address': null,
                            }).then((value) {
                              setState(() {
                                orderController.selectedAddress = 0;
                              });
                            });
                          },
                          child: Text('Add Address'),
                        ),
                      ],
                    )
                  : InkWell(
                      onTap: () {
                        navigationController
                            .navigateTo(manageAddress)
                            .then((value) => setState(() {}));
                      },
                      child: Card(
                        elevation: 5,
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.asset(
                                'assets/images/map.jpg',
                                width: 120,
                                height: 100,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Expanded(
                              child: ListTile(
                                title: Text(
                                  '${orderController.address[orderController.selectedAddress].name}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                ),
                                subtitle: Text(
                                  '${orderController.address[orderController.selectedAddress].address}, ${orderController.address[orderController.selectedAddress].city} ${orderController.address[orderController.selectedAddress].zipCode}, ${orderController.address[orderController.selectedAddress].province}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(
                                          fontSize: 12,
                                          color: Colors.grey.shade700),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 15),
                alignment: Alignment.topLeft,
                child: Text('Payment Method',
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(fontSize: 16, fontWeight: FontWeight.bold)),
              ),
              orderController.paymentCards.isEmpty
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                          child: Text('No card/payment method added yet!',
                              style: Theme.of(context).textTheme.bodyText1),
                        ),
                        TextButton(
                          onPressed: () {
                            navigationController
                                .navigateTo(addPayment)
                                .then((value) {
                              setState(() {
                                orderController.selectedPaymentCard = 0;
                              });
                            });
                          },
                          child: Text('Add Card'),
                        ),
                      ],
                    )
                  : Card(
                      elevation: 5,
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListTile(
                          leading: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Colors.grey.shade200,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8),
                              child: orderController
                                          .paymentCards[orderController
                                              .selectedPaymentCard]
                                          .cardNumber!
                                          .startsWith('5') ==
                                      true
                                  ? Image.asset(
                                      'assets/images/mastercard.png',
                                      width: 40,
                                      height: 40,
                                      fit: BoxFit.cover,
                                    )
                                  : Image.asset('assets/images/visa.png',
                                      width: 40,
                                      height: 40,
                                      fit: BoxFit.contain),
                            ),
                          ),
                          title: Text(
                            orderController
                                .paymentCards[
                                    orderController.selectedPaymentCard]
                                .cardHolderName!,
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                            '**** **** **** ${orderController.paymentCards[orderController.selectedPaymentCard].cardNumber!.substring(15)}',
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(
                                    fontSize: 12, color: Colors.grey.shade700),
                          ),
                          trailing: Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: blue,
                            ),
                            child: IconButton(
                              icon: Icon(
                                Icons.arrow_forward_ios_outlined,
                                color: Colors.white,
                                size: 20,
                              ),
                              onPressed: () {
                                navigationController
                                    .navigateTo(managePayment)
                                    .then((value) => setState(() {}));
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
              ListTile(
                title: Text('Shipping Cost',
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(fontSize: 16)),
                trailing: Text(
                  'Rs. ${250}',
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .copyWith(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
              ListTile(
                title: Text('Subtotal',
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(fontSize: 18)),
                trailing: Text(
                  'Rs. ${productController.inCart.map((item) => item.price).reduce((a, b) => a! + b!)}',
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .copyWith(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
              Divider(
                height: 0,
                indent: 10,
                endIndent: 10,
                color: Colors.grey.shade400,
              ),
              ListTile(
                title: Text('Total',
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(fontSize: 16)),
                trailing: Text(
                  'Rs. ${productController.inCart.map((item) => item.price).reduce((a, b) => a! + b!)! + 250}',
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .copyWith(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: blue),
                ),
                child: ListTile(
                  contentPadding: const EdgeInsets.only(left: 10),
                  title: TextField(
                    controller: voucherController,
                    decoration: InputDecoration(
                      hintText: 'Enter Voucher Code',
                      hintStyle:
                          Theme.of(context).textTheme.bodyText1!.copyWith(
                                color: Colors.grey.shade400,
                              ),
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                    ),
                  ),
                  trailing: Container(
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Text('Apply',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white)),
                      style: ElevatedButton.styleFrom(
                        fixedSize: Size(100, 100),
                        primary: blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(11),
                              bottomRight: Radius.circular(11)),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(bottom: 20),
                child: ElevatedButton(
                  onPressed: () {
                    navigationController.getOffAll(orderConfirmed);
                  },
                  child: Text(
                    'Place Order',
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
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
}
