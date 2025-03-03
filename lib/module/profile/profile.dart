import 'package:flutter/material.dart';

import '../../global/index.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final service = GetIt.I<ProfileService>();

  void _showPopupMenu(BuildContext context, Offset position) async {
    final selectedValue = await showMenu(context: context, position: RelativeRect.fromLTRB(position.dx, position.dy, 0, 0), items: [
      PopupMenuItem(
          padding: EdgeInsets.zero,
          height: 0,
          value: 1,
          child: Column(children: [
            Container(
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                color: Colors.white,
                child: Row(children: [
                  const Image(image: AssetImage("assets/icon/flat-icon/tr-flag.png"), width: 25, height: 15),
                  SizedBox(width: 10),
                  Text("Türkçe".tr(), style: kMontserrat18)
                ]))
          ])),
      PopupMenuItem(
          padding: EdgeInsets.zero,
          height: 0,
          value: 2,
          child: Column(children: [
            Container(
                color: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                child: Row(children: [
                  const Image(image: AssetImage("assets/icon/flat-icon/en-flag.png"), width: 25, height: 15),
                  SizedBox(width: 10),
                  Text("English".tr(), style: kMontserrat18)
                ]))
          ]))
    ]);
    if (selectedValue != null) {
      if (selectedValue == 1) {
        setState(() {
          selectedlang = "tr";
          context.locale = Locale("tr");
        });
      } else if (selectedValue == 2) {
        setState(() {
          selectedlang = "en";
          context.locale = Locale("en");
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final double W = MediaQuery.of(context).size.width;

    return StreamBuilder(
        stream: member$.stream,
        builder: (context, snapshot) {
          return Scaffold(
            appBar: AppBar(title: Text("Profile".tr()), leading: null),
            body: SingleChildScrollView(
              child: Padding(
                padding: paddingAll10,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        margin: marginAll5,
                        padding: paddingAll10,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.6), spreadRadius: 3, blurRadius: 10, offset: Offset(0, 3))]),
                        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
                          SizedBox(height: W / 40),
                          Container(
                              alignment: Alignment.center,
                              child: Container(
                                  decoration: const BoxDecoration(shape: BoxShape.circle),
                                  height: W / 3,
                                  width: W / 3,
                                  child: ClipOval(
                                      child: CachedNetworkImage(
                                          imageUrl: member$.value?.first.profile.photourl ??
                                              "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png",
                                          fit: BoxFit.cover,
                                          placeholder: (context, url) => CircularProgressIndicator(color: config.primaryColor),
                                          errorWidget: (context, url, error) => Icon(Icons.error))))),
                          SizedBox(height: W / 60),
                          Text(member$.value?.first.profile.fullname ?? "", style: kAxiforma20),
                          Column(
                              children: member$.value?.map((e) {
                                    return Column(
                                        children: e.membership.map((item) {
                                              return Column(children: [
                                                Text(item.membershiptype, style: kMontserrat20.copyWith(color: config.primaryColor)),
                                                Text(
                                                    "${DateFormat("dd-MMM-yyyy").format(item.startdate)} - ${DateFormat("dd-MMM-yyyy").format(item.lastdate!)}",
                                                    style: kMontserrat20),
                                              ]);
                                            }).toList() ??
                                            []);
                                  }).toList() ??
                                  []),
                          SizedBox(height: W / 80),
                          Row(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center, children: [
                            const Icon(Icons.email),
                            SizedBox(width: W / 30),
                            Text("${member$.value?.first.profile.email}", style: kMontserrat17)
                          ]),
                          SizedBox(height: W / 80),
                          Row(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center, children: [
                            const Icon(Icons.phone),
                            SizedBox(width: W / 30),
                            Text(member$.value?.first.profile.phone ?? "", style: kMontserrat17)
                          ])
                        ])),
                    SizedBox(height: W / 60),
                    InkWell(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const Measurements()));
                        },
                        child: Container(
                            height: W / 8,
                            padding: paddingAll10,
                            margin: marginAll5,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(color: Colors.white, borderRadius: borderRadius10, boxShadow: [
                              BoxShadow(color: Colors.grey.withOpacity(0.4), spreadRadius: 3, blurRadius: 10, offset: const Offset(0, 3))
                            ]),
                            width: W,
                            child: Row(children: [
                              SizedBox(height: W / 15, width: W / 15, child: Image.asset("assets/icon/mesurements.png", color: config.primaryColor)),
                              SizedBox(width: W / 40),
                              Text("My Measurements".tr(), style: kMontserrat16)
                            ]))),
                    SizedBox(height: W / 60),
                    InkWell(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const MemberType()));
                        },
                        child: Container(
                            height: W / 8,
                            padding: paddingAll10,
                            margin: marginAll5,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: borderRadius10,
                                boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.4), spreadRadius: 3, blurRadius: 10, offset: Offset(0, 3))]),
                            width: W,
                            child: Row(
                              children: [
                                Icon(Icons.published_with_changes_sharp, color: config.primaryColor, size: 26),
                                SizedBox(width: W / 40),
                                Text("Member Type".tr(), style: kMontserrat16)
                              ],
                            ))),
                    SizedBox(height: W / 60),
                    InkWell(
                        onTapDown: (details) {
                          _showPopupMenu(context, details.globalPosition);
                        },
                        child: Container(
                            padding: paddingAll10,
                            height: W / 8,
                            margin: marginAll5,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: borderRadius10,
                                boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.4), spreadRadius: 3, blurRadius: 10, offset: Offset(0, 3))]),
                            width: W,
                            child: Row(children: [
                              Icon(Icons.language, color: config.primaryColor, size: 25),
                              SizedBox(width: W / 40),
                              Text("Language".tr(), style: kMontserrat16)
                            ]))),
                    SizedBox(height: W / 60),
                    InkWell(
                      onTap: () {
                        Navigator.popUntil(context, (route) => route.isFirst);
                        Navigator.pushReplacement(
                            context,
                            PageRouteBuilder(
                              pageBuilder: (context, animation, secondaryAnimation) => Login(),
                            ));
                      },
                      child: Container(
                        padding: paddingAll10,
                        height: W / 8,
                        margin: marginAll5,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: borderRadius10,
                            boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.4), spreadRadius: 3, blurRadius: 10, offset: Offset(0, 3))]),
                        width: W,
                        child: Row(
                          children: [
                            Container(height: W / 15, width: W / 15, child: Image.asset("assets/icon/exit-icon.png", color: Colors.red)),
                            SizedBox(width: W / 40),
                            Text("Log Out".tr(), style: kMontserrat16.copyWith(color: Colors.red))
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }
}
