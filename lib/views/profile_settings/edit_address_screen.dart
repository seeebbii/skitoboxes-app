import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skitoboxes/constants/colors.dart';
import 'package:skitoboxes/constants/controllers.dart';
import 'package:skitoboxes/controllers/order_controller.dart';
import 'package:skitoboxes/models/address.dart';

class EditAddressScreen extends StatefulWidget {
  EditAddressScreen({Key? key, this.address}) : super(key: key);

  Address? address;

  @override
  _EditAddressScreenState createState() => _EditAddressScreenState();
}

class _EditAddressScreenState extends State<EditAddressScreen> {
  OrderController orderController = Get.put(OrderController());
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
    nameController.text = widget.address!.name!;
    receiverNameController.text = widget.address!.receiverName!;
    phoneController.text = widget.address!.receiverNumber!;
    addressController.text = widget.address!.address!;
    cityController.text = widget.address!.city!;
    provinceController.text = widget.address!.province!;
    zipController.text = widget.address!.zipCode!;
    super.initState();
  }

  void _saveAddress(int index) async {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();

    if (isValid) {
      _formKey.currentState!.save();
      orderController.address.indexWhere((element) {
        if (element.id == index) {
          element.name = nameController.text;
          element.receiverName = receiverNameController.text;
          element.receiverNumber = phoneController.text;
          element.address = addressController.text;
          element.city = cityController.text;
          element.province = provinceController.text;
          element.zipCode = zipController.text;
        }
        return element.id == index;
      });
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
                textFieldBody(context, 'Name', nameController),
                textFieldBody(context, 'Reciever Name', receiverNameController),
                textFieldBody(context, 'Phone Number', phoneController),
                textFieldBody(context, 'Address', addressController),
                textFieldBody(context, 'City', cityController),
                textFieldBody(context, 'Province', provinceController),
                textFieldBody(context, 'ZipCode', zipController),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: ElevatedButton(
                    onPressed: () {
                      _saveAddress(widget.address!.id!);
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

  Padding textFieldBody(
      BuildContext context, String? title, TextEditingController? _controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: TextFormField(
        controller: _controller,
        style: Theme.of(context).textTheme.bodyText1,
        decoration: InputDecoration(
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
