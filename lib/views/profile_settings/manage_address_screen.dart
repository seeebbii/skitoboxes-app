import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skitoboxes/constants/colors.dart';
import 'package:skitoboxes/constants/controllers.dart';
import 'package:skitoboxes/controllers/order_controller.dart';
import 'package:skitoboxes/router/route_generator.dart';

class ManageAddressScreen extends StatefulWidget {
  ManageAddressScreen({Key? key}) : super(key: key);

  @override
  _ManageAddressScreenState createState() => _ManageAddressScreenState();
}

class _ManageAddressScreenState extends State<ManageAddressScreen> {
  OrderController orderController = Get.put(OrderController());

  int? _selectedAddres;

  void _onChangeAddress(value) {
    setState(() {
      _selectedAddres = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage Address'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: ListView.builder(
            itemCount: orderController.address.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 10),
                    alignment: Alignment.centerLeft,
                    child: Text('Address ${index + 1}',
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                  ),
                  InkWell(
                    onTap: () {
                      _onChangeAddress(index);
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
                              width: 80,
                              height: 80,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Expanded(
                            child: ListTile(
                              title: Text(
                                '${orderController.address[index].name}',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                              ),
                              subtitle: Text(
                                '${orderController.address[index].address}, ${orderController.address[index].city} ${orderController.address[index].zipCode}, ${orderController.address[index].province}',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(
                                        fontSize: 12,
                                        color: Colors.grey.shade700),
                              ),
                              trailing: _selectedAddres == index
                                  ? Icon(
                                      Icons.radio_button_checked,
                                      color: darkBlue,
                                    )
                                  : Icon(Icons.radio_button_unchecked),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Theme(
                    data: Theme.of(context).copyWith(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                    ),
                    child: InkWell(
                      onTap: () {
                        navigationController
                            .navigateToWithArguments(
                                editAddress, orderController.address[index])
                            .then((value) {
                          setState(() {});
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 20),
                        alignment: Alignment.centerRight,
                        child: Text('Edit Address',
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(
                                    decoration: TextDecoration.underline)),
                      ),
                    ),
                  ),
                ],
              );
            }),
      ),
    );
  }
}
