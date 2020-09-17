import 'package:details_showcase/pages/home/domain/entity/user_model.dart';
import 'package:details_showcase/pages/home/presentation/controllers/home_controller.dart';
import 'package:details_showcase/pages/home/presentation/widgets/expanded_panel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserDetailsView extends StatelessWidget {
  final HomeController homeController = Get.find();
  final List<String> headings = <String>[
    "Id",
    "Name",
    "Username",
    "Email",
    "Address",
    "Phone",
    "Website",
    "Company"
  ];
  @override
  Widget build(BuildContext context) {
    final UserModel user = homeController.selectedUser;
    final Widget id = Text(user.id.toString(), softWrap: true);
    final Widget name = Text(user.name, softWrap: true);
    final Widget username = Text(user.username, softWrap: true);
    final Widget email = Text(user.email, softWrap: true);
    final Widget address = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text("Street: " + user.address.street, softWrap: true),
        Text("Suite: " + user.address.suite, softWrap: true),
        Text("City: " + user.address.city, softWrap: true),
        Text("ZipCode: " + user.address.zipcode, softWrap: true),
        Text("Geo: "),
        Container(
          padding: EdgeInsets.only(left: 10.0),
          child: Column(
            children: <Widget>[
              Text("Lat: " + user.address.geo.lat, softWrap: true),
              Text("Lng: " + user.address.geo.lng, softWrap: true),
            ],
          ),
        ),
      ],
    );
    final Widget phone = Text(user.phone, softWrap: true);
    final Widget website = Text(user.website, softWrap: true);
    final Widget company = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text("Name: " + user.company.name, softWrap: true),
        Text("CatchPhrase: " + user.company.catchPhrase, softWrap: true),
        Text("Bs: " + user.company.bs, softWrap: true)
      ],
    );
    final List<Widget> data = <Widget>[
      id,
      name,
      username,
      email,
      address,
      phone,
      website,
      company,
    ];
    return ListView.builder(
      padding: EdgeInsets.all(10.0),
      itemCount: headings.length,
      itemBuilder: (context, index) {
        return ExpandedWidget(
            title: headings[index],
            body: Center(
                child: Container(
                    padding: EdgeInsets.only(bottom: 10.0),
                    child: data[index])));
      },
    );
  }
}
