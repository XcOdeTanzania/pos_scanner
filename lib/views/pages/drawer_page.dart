import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pos_scanner/scoped_model/main.dart';
import 'package:scoped_model/scoped_model.dart';

class DrawerPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant(
      builder: (context, child, MainModel model) {
        return Drawer(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              UserAccountsDrawerHeader(
                  currentAccountPicture:
                      Center(child: Image.asset('assets/icons/user.png')),
                  accountName: Text('Admin'),
                  accountEmail: Text(
                    'admin@admin.com',
                  )),
              ListTile(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) {
                    return;
                  }));
                },
                leading:
                    Icon(Icons.person, color: Theme.of(context).buttonColor),
                title: Text('Profile'),
              ),
              Divider(
                color: Theme.of(context).primaryColor,
              ),
              ListTile(
                onTap: () {},
                leading: Icon(FontAwesomeIcons.storeAlt,
                    color: Theme.of(context).buttonColor),
                title: Text('Store'),
              ),
              Divider(
                color: Theme.of(context).primaryColor,
              ),
              ListTile(
                onTap: () {},
                leading:
                    Icon(Icons.equalizer, color: Theme.of(context).buttonColor),
                title: Text('Terms & Conditions'),
              ),
              Divider(
                color: Theme.of(context).primaryColor,
              ),
              ListTile(
                onTap: () {},
                leading: Icon(Icons.help, color: Theme.of(context).buttonColor),
                title: Text('Help'),
              ),
              Divider(
                color: Theme.of(context).primaryColor,
              ),
              Spacer(),
              ListTile(
                onTap: () {},
                leading: Icon(Icons.exit_to_app,
                    color: Theme.of(context).buttonColor),
                title: Text('Logout'),
              ),
              SizedBox(
                height: 10,
              )
            ],
          ),
        );
      },
    );
  }
}
