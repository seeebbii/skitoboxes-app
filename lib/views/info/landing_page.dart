import 'package:flutter/material.dart';
import 'package:skitoboxes/constants/controllers.dart';
import 'package:skitoboxes/views/authentication/auth_page_viewer.dart';

class LandingPage extends StatelessWidget {
  LandingPage({Key? key}) : super(key: key);

  void loginSheet(BuildContext ctx) {
    showModalBottomSheet(
        isDismissible: true,
        enableDrag: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        isScrollControlled: true,
        context: ctx,
        builder: (context) {
          return ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
            child: Container(
              height: MediaQuery.of(ctx).size.height * 0.95,
              child: const AuthPageViewer(),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Noting to show right now',
              style: Theme.of(context).textTheme.bodyText1,
            ),
            ElevatedButton(
                onPressed: () => loginSheet(context),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Log in',
                    style: Theme.of(context)
                        .primaryTextTheme
                        .headline5!
                        .copyWith(color: Colors.white),
                  ),
                )),
            ElevatedButton(
                onPressed: () {
                  navigationController.navigateTo('/home-screen');
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Landing Page',
                    style: Theme.of(context)
                        .primaryTextTheme
                        .headline5!
                        .copyWith(color: Colors.white),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
