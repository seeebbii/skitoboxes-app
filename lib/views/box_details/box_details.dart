import 'package:flutter/material.dart';
import 'package:skitoboxes/constants/colors.dart';
import 'package:skitoboxes/models/box.dart';

import 'heart.dart';

class BoxDetails extends StatefulWidget {
  BoxDetails({Key? key, @required this.box}) : super(key: key);

  final Box? box;

  @override
  _BoxDetailsState createState() => _BoxDetailsState();
}

class _BoxDetailsState extends State<BoxDetails> {
  int? _selectedPurchaseType;

  void _purchaseType(value) {
    setState(() {
      _selectedPurchaseType = value;
    });
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
      ),
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              ClipRRect(
                  child: Hero(
                tag: widget.box!.id!,
                child: Image.network(
                  widget.box!.image!,
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
                trailing: Heart(),
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
                    fixedSize: Size(0, 55),
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
