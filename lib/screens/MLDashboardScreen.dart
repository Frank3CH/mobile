import 'package:flutter/material.dart';
import 'package:ESMV_STORE/components/MLBottomNavigationBarWidget.dart';
import 'package:ESMV_STORE/fragments/MLCommandeFragment.dart';
import 'package:ESMV_STORE/fragments/MLHomeFragment.dart';
import 'package:ESMV_STORE/fragments/MLNotificationFragment.dart';
import 'package:ESMV_STORE/fragments/MLProfileFragemnt.dart';
import 'package:ESMV_STORE/fragments/MLAdminHomeFragment.dart';
import 'package:ESMV_STORE/utils/MLColors.dart';
import 'package:ESMV_STORE/utils/MLCommon.dart';

class MLDashboardScreen extends StatefulWidget {
  static String tag = '/MLDashboardScreen';
  final bool isAdmin;

  MLDashboardScreen({this.isAdmin = false});

  @override
  _MLDashboardScreenState createState() => _MLDashboardScreenState();
}

class _MLDashboardScreenState extends State<MLDashboardScreen> {
  int currentWidget = 0;
  late List<Widget> widgets;

  @override
  void initState() {
    super.initState();
    init();

    widgets = widget.isAdmin
        ? [MLAdminhomefragment(), MLCommandeFragment(), MLNotificationFragment(), MLProfileFragment()]
        : [MLHomeFragment(), MLCommandeFragment(), MLNotificationFragment(), MLProfileFragment()];
  }

  Future<void> init() async {
    //
  }

  @override
  void dispose() {
    changeStatusColor(mlPrimaryColor);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: widgets[currentWidget],
        bottomNavigationBar: Container(color: Colors.white, child: showBottomDrawer()),
      ),
    );
  }

  Widget showBottomDrawer() {
    return MLBottomNavigationBarWidget(
      index: currentWidget,
      onTap: (index) {
        setState(() {});
        currentWidget = index;
      },
    );
  }
}
