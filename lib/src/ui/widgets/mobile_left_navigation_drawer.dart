import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:ob_admin_panel/src/constants/constants.dart';
import 'package:ob_admin_panel/src/ui/widgets/mobile_menu_item.dart';
import 'package:ob_admin_panel/src/ui/widgets/profile_pic.dart';

class MobileLeftNavigationMenu extends StatelessWidget {
  final int tappedMenuIndex;
  MobileLeftNavigationMenu({
    @required this.tappedMenuIndex,
  });

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;
    return Container(
      width: mediaQuery.width * 0.56,
      child: Drawer(
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: 2.0,
            sigmaY: 2.0,
          ),
          child: SafeArea(
            child: SingleChildScrollView(
              child: Container(
                height: mediaQuery.height -
                    MediaQuery.of(context).padding.bottom -
                    MediaQuery.of(context).padding.top,
                color: Color(ColorConstants.LOGIN_REGISTER_TEXT_COLOR),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: Stack(
                        children: [
                          Builder(
                            builder: (
                              BuildContext context,
                            ) =>
                                IconButton(
                              icon: Icon(
                                Icons.menu,
                                color: Colors.white,
                                size: 35.0,
                              ),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ),
                          Align(
                            alignment: Alignment.topRight,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 5, right: 5),
                              child: ProfilePic(),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    ...[
                      for (int i = 0; i < Constants.TAB_COUNT; i++) ...[
                        _buildNavigationMenues(tappedMenuIndex == i)[i]
                      ]
                    ],
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      height: 1,
                      color: Colors.white,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    ...[
                      for (int i = 0; i < 3; i++) ...[_buildControlOptions()[i]]
                    ],
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildControlOptions() {
    return [
      MenuItem(
        title: ConstantTexts.SETTINGS,
      ),
      MenuItem(
        title: ConstantTexts.SWITCH_ACCOUNTS,
      ),
      MenuItem(
        title: ConstantTexts.LOGOUT,
      ),
    ];
  }

  List<Widget> _buildNavigationMenues(
    bool isTapped,
  ) {
    return [
      MenuItem(
        title: ConstantTexts.HOME,
        isTapped: isTapped,
      ),
      MenuItem(
        title: ConstantTexts.MAP.toUpperCase(),
        isTapped: isTapped,
      ),
      MenuItem(
        title: ConstantTexts.WEATHER_MARINE,
        isTapped: isTapped,
      ),
      MenuItem(
        title: ConstantTexts.DEVICES,
        isTapped: isTapped,
      ),
      MenuItem(
        title: ConstantTexts.MESSAGES,
        isTapped: isTapped,
      ),
      MenuItem(
        title: ConstantTexts.ACCESS_MANAGEMENT,
        isTapped: isTapped,
      ),
      MenuItem(
        title: ConstantTexts.LOCATIONS,
        isTapped: isTapped,
      ),
    ];
  }
}