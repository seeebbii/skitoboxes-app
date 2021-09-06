import 'package:flutter/material.dart';
import 'package:skitoboxes/constants/colors.dart';
import 'package:skitoboxes/constants/controllers.dart';
import 'package:skitoboxes/models/address.dart';

import 'form_field.dart';

enum FormType {
  addNew,
  edit,
}

class AddressForm extends StatefulWidget {
  AddressForm({
    Key? key,
    @required this.typeMode,
    this.address,
  }) : super(key: key);

  FormType? typeMode;
  Address? address;

  @override
  _AddressFormState createState() => _AddressFormState();
}

class _AddressFormState extends State<AddressForm> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();

  TextEditingController receiverNameController = TextEditingController();

  TextEditingController phoneController = TextEditingController();

  TextEditingController addressController = TextEditingController();

  TextEditingController cityController = TextEditingController();

  TextEditingController provinceController = TextEditingController();

  TextEditingController zipController = TextEditingController();

  void _saveAddress(int? index) async {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if (isValid) {
      _formKey.currentState!.save();
      if (widget.typeMode == FormType.addNew) {
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
        navigationController.goBack();
      } else if (widget.typeMode == FormType.edit) {
        orderController.address.indexWhere((element) {
          if (element.id == index) {
            element.name = nameController.text;
            element.receiverName = receiverNameController.text;
            element.receiverNumber = phoneController.text;
            element.address = addressController.text;
            element.city = cityController.text;
            element.province = provinceController.text;
            element.zipCode = zipController.text;
            navigationController.goBack();
          }

          return element.id == index;
        });
      }
    }
  }

  @override
  void initState() {
    if (widget.typeMode == FormType.edit) {
      nameController.text = widget.address!.name!;
      receiverNameController.text = widget.address!.receiverName!;
      phoneController.text = widget.address!.receiverNumber!;
      addressController.text = widget.address!.address!;
      cityController.text = widget.address!.city!;
      provinceController.text = widget.address!.province!;
      zipController.text = widget.address!.zipCode!;

      super.initState();
    }
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
              formField(
                title: 'Name',
                controller: nameController,
                hintText: 'Home/Work',
              ),
              formField(
                title: 'Reciever Name',
                controller: receiverNameController,
                hintText: 'Who is going to receive the order?',
              ),
              formField(
                title: 'Phone Number',
                controller: phoneController,
                hintText: '03---------',
                inputType: TextInputType.number,
              ),
              formField(
                title: 'Address',
                controller: addressController,
                hintText: 'House/Street/Block/Town',
              ),
              formField(
                title: 'City',
                controller: cityController,
                hintText: '',
              ),
              formField(
                title: 'Province',
                controller: provinceController,
                hintText: '',
              ),
              formField(
                title: 'ZipCode',
                controller: zipController,
                hintText: 'Postal Code',
                inputType: TextInputType.number,
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: ElevatedButton(
                  onPressed: () {
                    if (widget.typeMode == FormType.addNew) {
                      _saveAddress(-1);
                    } else {
                      _saveAddress(widget.address?.id);
                    }
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
      ),
    );
  }
}
