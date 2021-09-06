import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skitoboxes/constants/colors.dart';
import 'package:skitoboxes/constants/controllers.dart';
import 'package:skitoboxes/router/route_generator.dart';
import 'package:skitoboxes/views/profile_settings/address/address_form.dart';

class ManageAddressScreen extends StatefulWidget {
  ManageAddressScreen({Key? key}) : super(key: key);

  @override
  _ManageAddressScreenState createState() => _ManageAddressScreenState();
}

class _ManageAddressScreenState extends State<ManageAddressScreen> {
  void _onChangeAddress(value) {
    setState(() {
      orderController.selectedAddress = value;
    });
  }

  void _onDeleteAddress(value) {
    setState(() {
      orderController.address.removeWhere((element) => element.id == value);
      orderController.selectedAddress = orderController.address.first;
    });
  }

  @override
  void initState() {
    if (orderController.selectedAddress == null) {
      orderController.selectedAddress = 0;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Manage Address'),
          centerTitle: true,
        ),
        body: Obx(
          () => orderController.address.isEmpty
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
                          setState(() {});
                        });
                      },
                      child: Text('Add Address'),
                    ),
                  ],
                )
              : Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Column(
                    children: [
                      Expanded(
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
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1!
                                            .copyWith(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold)),
                                  ),
                                  Dismissible(
                                    key: Key(orderController.address[index].id
                                        .toString()),
                                    background: Container(
                                      padding: const EdgeInsets.only(left: 20),
                                      alignment: Alignment.centerLeft,
                                      child: Icon(
                                        Icons.delete_outlined,
                                        color: Colors.red,
                                      ),
                                    ),
                                    direction: DismissDirection.startToEnd,
                                    confirmDismiss: (direction) async {
                                      final bool result = await showDialog(
                                          context: context,
                                          barrierDismissible: false,
                                          builder: (context) {
                                            return AlertDialog(
                                                content: Text(
                                                  'Are you sure you want to delete ${orderController.address[index].name} address? ',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyText1!
                                                      .copyWith(fontSize: 16),
                                                ),
                                                actions: [
                                                  TextButton(
                                                      onPressed: () {
                                                        navigationController
                                                            .goBack();
                                                      },
                                                      child: Text(
                                                        'No',
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodyText1!
                                                            .copyWith(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                      )),
                                                  TextButton(
                                                      onPressed: () {
                                                        navigationController
                                                            .goBack();
                                                        _onDeleteAddress(index);
                                                      },
                                                      child: Text(
                                                        'Yes',
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodyText1!
                                                            .copyWith(
                                                                color:
                                                                    Colors.red,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                      )),
                                                ]);
                                          });
                                      return result;
                                    },
                                    child: InkWell(
                                      onTap: () {
                                        _onChangeAddress(index);
                                      },
                                      child: Card(
                                        elevation: 5,
                                        color: Colors.white,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                        child: Row(
                                          children: [
                                            ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(12),
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
                                                          fontWeight:
                                                              FontWeight.bold),
                                                ),
                                                subtitle: Text(
                                                  '${orderController.address[index].address}, ${orderController.address[index].city} ${orderController.address[index].zipCode}, ${orderController.address[index].province}',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyText1!
                                                      .copyWith(
                                                          fontSize: 12,
                                                          color: Colors
                                                              .grey.shade700),
                                                ),
                                                trailing: orderController
                                                            .selectedAddress ==
                                                        index
                                                    ? Icon(
                                                        Icons
                                                            .radio_button_checked,
                                                        color: darkBlue,
                                                      )
                                                    : Icon(Icons
                                                        .radio_button_unchecked),
                                              ),
                                            ),
                                          ],
                                        ),
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
                                                addressForm, {
                                          "typeMode": FormType.edit,
                                          "address":
                                              orderController.address[index],
                                        }).then((value) {
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
                                                    decoration: TextDecoration
                                                        .underline)),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            }),
                      ),
                      TextButton(
                        onPressed: () {
                          navigationController
                              .navigateToWithArguments(addressForm, {
                            'typeMode': FormType.addNew,
                            'address': null,
                          }).then((value) {
                            setState(() {});
                          });
                        },
                        child: Text('Add Another Address'),
                      ),
                    ],
                  ),
                ),
        ));
  }
}
