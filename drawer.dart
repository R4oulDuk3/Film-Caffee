import 'package:film_caffe_aplikacija/Constants/constants.dart';
import 'package:film_caffe_aplikacija/screens/AdminReservationManagerScreen.dart';
import 'package:film_caffe_aplikacija/screens/Admin_Event_Manager.dart';
import 'package:film_caffe_aplikacija/screens/TableManagerScreen.dart';
import 'package:film_caffe_aplikacija/screens/home.dart';
import 'package:film_caffe_aplikacija/screens/info.dart';
import 'package:film_caffe_aplikacija/screens/reservations.dart';
import 'package:film_caffe_aplikacija/services/auth_service.dart';
import 'package:film_caffe_aplikacija/wrapper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:film_caffe_aplikacija/screens/AdminSpecialOfferManager.dart';

class NavigationDrawerWidget extends StatelessWidget {
  final padding = EdgeInsets.symmetric(horizontal: 20);
  NavigationDrawerWidget({required this.adminMode});
  final bool adminMode;
  static bool hasBeenUsed=false;


  @override
  Widget build(BuildContext context) {

    List<Widget> widgets=
    [const SizedBox(height: 12),
        //buildSearchField(),
    const SizedBox(height: 24),
    buildMenuItem(
    text: 'Dogadjaji',
    icon: Icons.people,
    onClicked: () => selectedItem(context, 0),
    ),
    const SizedBox(height: 16),
    buildMenuItem(
    text: 'Rezervacije',
    icon: Icons.favorite_border,
    onClicked: () => selectedItem(context, 1),
    ),
    const SizedBox(height: 16),
    buildMenuItem(
    text: 'Informacije',
    icon: Icons.workspaces_outline,
    onClicked: () => selectedItem(context, 2),
    ),
    ];
    if(adminMode){
      widgets+=[
          Divider(color: Colors.white70),
          const SizedBox(height: 24),
          buildMenuItem(
            text: 'Admin_Dogadjaji',
            icon: Icons.account_tree_outlined,
            onClicked: () => selectedItem(context, 3),
          ),
          const SizedBox(height: 16),
          buildMenuItem(
            text: 'Admin_stolovi',
            icon: Icons.notifications_outlined,
            onClicked: () => selectedItem(context, 4),
          ),
        const SizedBox(height: 16),
        buildMenuItem(
          text: 'Admin_Rezervacije',
          icon: Icons.notifications_outlined,
          onClicked: () => selectedItem(context, 5),
        ),
        const SizedBox(height: 16),
        buildMenuItem(
          text: 'Admin_Akcije',
          icon: Icons.notifications_outlined,
          onClicked: () => selectedItem(context, 6),
        )
      ];
    }
    widgets+=[
      Divider(color: Colors.white70),


      Align(
        alignment: FractionalOffset.bottomCenter,
        child: buildMenuItem(
          text: 'Logout',
          icon: Icons.account_tree_outlined,
          onClicked: () {
            AuthService().signOut();
            print(hasBeenUsed);
            if(hasBeenUsed)
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) => AuthWrapper(),
              ),
                  (route) => false,
            );
            hasBeenUsed=false;
            },

        ),
      )
    ];

    return Drawer(
      child: Material(
        color: Colors.purple,
        child: ListView(
          children: <Widget>[
            /*buildHeader(
              urlImage: urlImage,
              name: name,
              email: email,
              onClicked: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => UserPage(
                  name: 'Sarah Abs',
                  urlImage: urlImage,
                ),
              )),
            ),*/
            Container(
              padding: padding,
              child: Column(
                children: widgets,
              ),
            ),

          ],
        ),
      ),
    );
  }

  Widget buildHeader({
    required String urlImage,
    required String name,
    required String email,
    required VoidCallback onClicked,
  }) =>
      InkWell(
        onTap: onClicked,
        child: Container(
          padding: padding.add(EdgeInsets.symmetric(vertical: 40)),
          child: Row(
            children: [
              CircleAvatar(radius: 30, backgroundImage: NetworkImage(urlImage)),
              SizedBox(width: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    email,
                    style: TextStyle(fontSize: 14, color: Colors.white),
                  ),
                ],
              ),
              Spacer(),
              CircleAvatar(
                radius: 24,
                backgroundColor: Color.fromRGBO(30, 60, 168, 1),
                child: Icon(Icons.add_comment_outlined, color: Colors.white),
              )
            ],
          ),
        ),
      );

  Widget buildSearchField() {
    final color = Colors.white;

    return TextField(
      style: TextStyle(color: color),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        hintText: 'Search',
        hintStyle: TextStyle(color: color),
        prefixIcon: Icon(Icons.search, color: color),
        filled: true,
        fillColor: Colors.white12,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(color: color.withOpacity(0.7)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(color: color.withOpacity(0.7)),
        ),
      ),
    );
  }

  Widget buildMenuItem({
    required String text,
    required IconData icon,
    VoidCallback? onClicked,
  }) {
    final color = Colors.white;
    final hoverColor = Colors.white70;

    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(text, style: drawerStil),
      hoverColor: hoverColor,
      onTap: onClicked,
    );
  }

  void selectedItem(BuildContext context, int index) {
    hasBeenUsed=true;
    Navigator.of(context).pop();

    switch (index) {
      case 0:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => HomePage(adminMode: adminMode),
        ));
        break;
      case 1:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => ReservationScreen(adminMode: adminMode),
        ));
        break;
      case 2:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => CaffeInfo(adminMode: adminMode),
        ));
        break;
      case 3:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => EventManager(adminMode: adminMode),
        ));
        break;
      case 4:Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => TableManagerScreen(adminMode: adminMode),
      ));
      break;
      case 5:Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => AdminReservationManagerScreen(adminMode: adminMode),
      ));
      break;
      case 6:Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => AdminSpecialOfferManager(adminMode: adminMode),
      ));
      break;
    }
  }
}