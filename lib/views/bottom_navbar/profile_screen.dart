import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skitoboxes/constants/colors.dart';
import 'package:skitoboxes/constants/controllers.dart';
import 'package:skitoboxes/router/route_generator.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final List<RadioCardModel> cardData = [
    RadioCardModel(false, Icons.subscriptions_outlined, 'Subscriptions',
        subscriptionScreen),
    RadioCardModel(false, Icons.delivery_dining_outlined, 'Orders', ''),
    RadioCardModel(false, Icons.favorite_outline, 'Wishlist', ''),
    RadioCardModel(
        false, Icons.notifications_active_outlined, 'Notifications', ''),
    RadioCardModel(false, Icons.settings_outlined, 'Settings', ''),
    RadioCardModel(false, Icons.logout_outlined, 'Sign Out', signOut),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile Settings'),
        automaticallyImplyLeading: false,
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: Card(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
                side: BorderSide(
                  color: Colors.grey.withOpacity(0.5),
                  width: 1,
                ),
              ),
              child: Theme(
                data: ThemeData().copyWith(
                  dividerColor: Colors.transparent,
                ),
                child: ExpansionTile(
                  title: Obx(() => Text('${authController.currentUser.value.name}',
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(fontSize: 18, fontWeight: FontWeight.bold))),
                  subtitle: Text('@profilename',
                      style: Theme.of(context).textTheme.bodyText1),
                  leading: CircleAvatar(
                    child: Icon(Icons.person),
                  ),
                  children: [
                    InkWell(
                      onTap: () {
                        navigationController.navigateTo(manageAddress);
                      },
                      child: ListTile(
                        title: Text('Manage Address',
                            style: Theme.of(context).textTheme.bodyText1),
                        leading: Icon(Icons.location_city_outlined, size: 18),
                        trailing: Icon(
                          Icons.arrow_forward_outlined,
                          size: 18,
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        navigationController.navigateTo(managePayment);
                      },
                      child: ListTile(
                        title: Text('Manage Payment Details',
                            style: Theme.of(context).textTheme.bodyText1),
                        leading: Icon(Icons.credit_card_outlined, size: 18),
                        trailing: Icon(
                          Icons.arrow_forward_outlined,
                          size: 18,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.02),
          Expanded(
            child: ListView.builder(
              itemCount: cardData.length,
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  highlightColor: Colors.transparent,
                  splashFactory: NoSplash.splashFactory,
                  onTap: () {
                    navigationController
                        .navigateTo(cardData[index].navigationRoute);
                    setState(() {
                      cardData.forEach((element) => element.isSelected = false);
                      cardData[index].isSelected = true;
                    });
                  },
                  child: RadioItem(cardData[index]),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class RadioItem extends StatelessWidget {
  final RadioCardModel _item;
  RadioItem(this._item);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Card(
        elevation: _item.isSelected ? 5 : 0,
        color: _item.isSelected ? darkBlue : Colors.white,
        margin: const EdgeInsets.symmetric(horizontal: 25),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: ListTile(
            leading: Icon(_item.icon,
                color: _item.isSelected ? Colors.white : Colors.black),
            title: Text(_item.title,
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: _item.isSelected ? Colors.white : Colors.black)),
          ),
        ),
      ),
    );
  }
}

class RadioCardModel {
  bool isSelected;
  final IconData icon;
  final String title;
  final String navigationRoute;

  RadioCardModel(this.isSelected, this.icon, this.title, this.navigationRoute);
}
