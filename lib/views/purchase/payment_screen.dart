import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skitoboxes/constants/colors.dart';
import 'package:skitoboxes/controllers/order_controller.dart';
import 'package:skitoboxes/controllers/product/product_controller.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({Key? key}) : super(key: key);

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  ProductController productController = Get.put(ProductController());
  OrderController orderController = Get.put(OrderController());

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
              Card(
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
                          '${orderController.address[0].name}',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                          '${orderController.address[0].address}, ${orderController.address[0].city} ${orderController.address[0].zipCode}, ${orderController.address[0].province}',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(
                                  fontSize: 12, color: Colors.grey.shade700),
                        ),
                      ),
                    ),
                  ],
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
              Card(
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
                        child: Image.asset(
                          'assets/images/mastercard.png',
                          width: 40,
                          height: 40,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    title: Text(
                      'MasterCard',
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      '*********2312',
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(fontSize: 12, color: Colors.grey.shade700),
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
                        onPressed: () {},
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.05),
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
                  onPressed: () {},
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
