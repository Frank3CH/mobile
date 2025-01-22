import 'package:flutter/material.dart';
import 'package:esmv_store/components/MLBottomNavigationBarWidget.dart';
import 'package:esmv_store/fragments/MLCommandeFragment.dart';
import 'package:esmv_store/fragments/MLHomeFragment.dart';
import 'package:esmv_store/fragments/MLNotificationFragment.dart';
import 'package:esmv_store/fragments/MLProfileFragemnt.dart';
import 'package:esmv_store/fragments/MLAdminHomeFragment.dart';
import 'package:esmv_store/utils/MLColors.dart';
import 'package:esmv_store/utils/MLCommon.dart';

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
