import 'package:flutter/material.dart';
import 'package:skitoboxes/views/authentication/body.dart';

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
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            child: Container(
              height: MediaQuery.of(ctx).size.height * 0.90,
              child: BodyAuth(),
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
              'Noting to show rightnow',
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
                ))
          ],
        ),
      ),
    );
  }
}
