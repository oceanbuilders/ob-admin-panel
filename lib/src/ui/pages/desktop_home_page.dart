import 'package:flutter/material.dart';
import 'package:ob_admin_panel/src/constants/constants.dart';
import 'package:ob_admin_panel/src/helpers/size_calcs.dart';
import 'package:ob_admin_panel/src/ui/tabs/access_management.dart';
import 'package:ob_admin_panel/src/ui/tabs/devices.dart';
import 'package:ob_admin_panel/src/ui/tabs/home.dart';
import 'package:ob_admin_panel/src/ui/tabs/locations.dart';
import 'package:ob_admin_panel/src/ui/tabs/map.dart';
import 'package:ob_admin_panel/src/ui/tabs/messages.dart';
import 'package:ob_admin_panel/src/ui/tabs/weather.dart';
import 'package:ob_admin_panel/src/ui/widgets/admin_panel_header.dart';

class DesktopHomepage extends StatefulWidget {
  @override
  _DesktopHomepageState createState() => _DesktopHomepageState();
}

class _DesktopHomepageState extends State<DesktopHomepage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: Constants.TAB_COUNT, vsync: this)
      ..addListener(() {
        setState(() {});
      });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final verticalRotation = Constants.TURNS_TO_ROTATE_RIGHT;
    final revertVerticalRotation = Constants.TURNS_TO_ROTATE_LEFT;
    var sizeCalcs = SizeCalcs(context: context);
    final tabViewHeight = sizeCalcs.calculateTabViewHeight();
    final tabViewWidth = sizeCalcs.calculateTabViewWidth();
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AdminPanelHeader(),
            Expanded(
              child: Row(
                children: [
                  NavigationMenu(
                    verticalRotation: verticalRotation,
                    revertVerticalRotation: revertVerticalRotation,
                    tabController: _tabController,
                  ),
                  RotatedBox(
                    quarterTurns: verticalRotation,
                    child: Container(
                      height: tabViewHeight,
                      width: tabViewWidth,
                      child: TabBarView(
                        controller: _tabController,
                        children: _buildTabViews().map(
                          (widget) {
                            // Revert the rotation on the tab views.
                            return Container(
                              color: Color(
                                ColorConstants.TAB_BACKGROUND,
                              ),
                              child: widget,
                            );
                          },
                        ).toList(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: Constants.BOTTOM_APP_PADDING_HEIGHT,
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildTabViews() {
    return [
      HomeView(),
      MapView(),
      WeatherView(),
      DevicesView(),
      MessagesView(),
      AccessManagementView(),
      LocationsView(),
    ];
  }
}

class NavigationMenu extends StatelessWidget {
  const NavigationMenu({
    Key key,
    @required this.verticalRotation,
    @required this.revertVerticalRotation,
    @required TabController tabController,
  })  : _tabController = tabController,
        super(key: key);

  final int verticalRotation;
  final int revertVerticalRotation;
  final TabController _tabController;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Constants.LEFT_NAVIGATION_WIDTH,
      child: Column(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundImage: AssetImage(
              'assets/images/avatar.png',
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            'Welcome Shimaa',
            style: TextStyle(
              fontSize: 14,
              color: Colors.black,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(
            height: 18,
          ),
          RotatedBox(
            quarterTurns: verticalRotation,
            child: _TabBar(
              tabs: _buildTabs(
                context: context,
              ).map(
                (widget) {
                  // Revert the rotation on the tabs.
                  return RotatedBox(
                    quarterTurns: revertVerticalRotation,
                    child: widget,
                  );
                },
              ).toList(),
              tabController: _tabController,
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildTabs({
    BuildContext context,
  }) {
    return [
      _AdminPanelTab(
        title: ConstantTexts.HOME,
        tabIndex: 0,
        tabController: _tabController,
      ),
      _AdminPanelTab(
        title: ConstantTexts.MAP,
        tabIndex: 1,
        tabController: _tabController,
      ),
      _AdminPanelTab(
        title: ConstantTexts.WEATHER_MARINE,
        tabIndex: 2,
        tabController: _tabController,
      ),
      _AdminPanelTab(
        title: ConstantTexts.DEVICES,
        tabIndex: 3,
        tabController: _tabController,
      ),
      _AdminPanelTab(
        title: ConstantTexts.MESSAGES,
        tabIndex: 4,
        tabController: _tabController,
      ),
      _AdminPanelTab(
        title: ConstantTexts.ACCESS_MANAGEMENT,
        tabIndex: 5,
        tabController: _tabController,
      ),
      _AdminPanelTab(
        title: ConstantTexts.LOCATIONS,
        tabIndex: 6,
        tabController: _tabController,
      ),
    ];
  }
}

class _TabBar extends StatelessWidget {
  const _TabBar({Key key, this.tabs, this.tabController}) : super(key: key);

  final List<Widget> tabs;
  final TabController tabController;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(ColorConstants.MAIN_COLOR),
      child: TabBar(
        isScrollable: true,
        labelPadding: EdgeInsets.zero,
        tabs: tabs,
        controller: tabController,
        indicatorColor: Colors.transparent,
      ),
    );
  }
}

class _AdminPanelTab extends StatefulWidget {
  _AdminPanelTab({
    this.title,
    int tabIndex,
    TabController tabController,
  }) : isExpanded = tabController.index == tabIndex;

  final String title;

  final bool isExpanded;

  @override
  _AdminPanelTabState createState() => _AdminPanelTabState();
}

class _AdminPanelTabState extends State<_AdminPanelTab>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 35,
      width: 180,
      padding: EdgeInsets.only(
        left: 15,
        top: 10,
      ),
      color: widget.isExpanded
          ? Color(
              ColorConstants.LOGIN_REGISTER_TEXT_COLOR,
            )
          : Colors.white,
      child: Text(
        widget.title,
        textAlign: TextAlign.start,
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w500,
          color: widget.isExpanded
              ? Colors.white
              : Color(
                  ColorConstants.LOGIN_REGISTER_TEXT_COLOR,
                ),
        ),
      ),
    );
  }
}