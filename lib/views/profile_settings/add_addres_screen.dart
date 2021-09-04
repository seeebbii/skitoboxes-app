import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skitoboxes/constants/colors.dart';
import 'package:skitoboxes/constants/controllers.dart';
import 'package:skitoboxes/controllers/order_controller.dart';
import 'package:skitoboxes/models/address.dart';

class AddAddressScreen extends StatefulWidget {
  AddAddressScreen({Key? key}) : super(key: key);

  @override
  _AddAddressScreenState createState() => _AddAddressScreenState();
}

class _AddAddressScreenState extends State<AddAddressScreen> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();
  TextEditingController receiverNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController provinceController = TextEditingController();
  TextEditingController zipController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  void _saveAddress() async {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();

    if (isValid) {
      _formKey.currentState!.save();

      orderController.address.add(Address(
        id: orderController.address.length,
        name: nameController.text,
        receiverName: receiverNameController.text,
        receiverNumber: phoneController.text,
        address: addressController.text,
        city: cityController.text,
        province: provinceController.text,
        zipCode: zipController.text,
      ));
    }
    navigationController.goBack();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(70),
          child: AppBar(
            title: const Text('Edit Address'),
            centerTitle: true,
          ),
        ),
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                textFieldBody(context, 'Name', nameController, 'Home/Work'),
                textFieldBody(context, 'Reciever Name', receiverNameController,
                    'Who is going to receive the order?'),
                textFieldBody(
                    context, 'Phone Number', phoneController, '+923---------'),
                textFieldBody(context, 'Address', addressController,
                    'House/Street/Block/Town'),
                textFieldBody(context, 'City', cityController, ''),
                textFieldBody(context, 'Province', provinceController, ''),
                textFieldBody(context, 'ZipCode', zipController, 'Postal Code'),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: ElevatedButton(
                    onPressed: () {
                      _saveAddress();
                    },
                    child: Text(
                      'Save',
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: darkBlue,
                      elevation: 0,
                      fixedSize: Size(100, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }

  Padding textFieldBody(BuildContext context, String? title,
      TextEditingController? _controller, String? hintText) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: TextFormField(
        controller: _controller,
        style: Theme.of(context).textTheme.bodyText1,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: Theme.of(context)
              .textTheme
              .bodyText1!
              .copyWith(fontSize: 14, color: Colors.grey.shade500),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black, width: 1.5),
          ),
          labelText: title,
          labelStyle: Theme.of(context).textTheme.bodyText1,
        ),
      ),
    );
  }
}
