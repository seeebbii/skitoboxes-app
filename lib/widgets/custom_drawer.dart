import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
          topRight: Radius.circular(50), bottomRight: Radius.circular(50)),
      child: Drawer(
        child: Container(
          color: Theme.of(context).primaryColor,
          child: ListView(
            children: <Widget>[
              DrawerHeader(
                child: Column(
                  children: [
                    ListTile(
                      leading: CircleAvatar(
                        child: Icon(Icons.person),
                      ),
                      trailing: Icon(Icons.notes_outlined),
                    ),
                    ListTile(
                      title: Text(
                        'Skitobox User',
                        style: Theme.of(context)
                            .primaryTextTheme
                            .headline5!
                            .copyWith(fontFamily: 'Avenir'),
                      ),
                      subtitle: Text('@someuser'),
                    )
                  ],
                ),
              ),
              ListTile(
                leading: Icon(Icons.home_outlined),
                title: Text(
                  'Home',
                ),
              ),
              ListTile(
                leading: Icon(Icons.subscriptions_outlined),
                title: Text('Subscrptions'),
              ),
              ListTile(
                leading: Icon(Icons.delivery_dining_outlined),
                title: Text('Orders'),
              ),
              ListTile(
                leading: Icon(Icons.favorite_outline),
                title: Text('Wishlist'),
              ),
              ListTile(
                leading: Icon(Icons.message_outlined),
                title: Text('Customer Care'),
              ),
              Divider(),
              ListTile(
                leading: Icon(
                  Icons.email_outlined,
                ),
                title: Text('Contact Us'),
              ),
              ListTile(
                leading: Icon(
                  Icons.logout_outlined,
                ),
                title: Text('Logout'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
