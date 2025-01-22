import 'package:ESMV_STORE/model/MLUserProfile.dart';
import 'package:ESMV_STORE/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:ESMV_STORE/components/MLProfileBottomComponent.dart';
import 'package:ESMV_STORE/utils/MLColors.dart';
import 'package:ESMV_STORE/utils/MLImage.dart';

class MLProfileFragment extends StatefulWidget {
  static String tag = '/MLProfileFragment';




  @override
  MLProfileFragmentState createState() => MLProfileFragmentState();
}

class MLProfileFragmentState extends State<MLProfileFragment> {
  MLUserProfile? userProfile;
  bool isLoading = true;
  String? nom ;
  @override
  void initState() {
    super.initState();
    init();
    fetchUserProfile();
  }

  Future<void> init() async {
    //
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  Future<void> fetchUserProfile() async {
    try {
      UserService userProfileService = UserService();
      var profile = await userProfileService.fetchUserProfile();
      setState(() {
        userProfile = profile;
        nom = userProfile!.firstname! + ' '+ userProfile!.lastName!;
        isLoading = false;
      });
    } catch (e) {
      print('Error fetching user profile: $e');
      setState(() {
        isLoading = false;
      });
    }
  }



  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: mlPrimaryColor,
        body: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              automaticallyImplyLeading: false,
              expandedHeight: 225,
              flexibleSpace: FlexibleSpaceBar(
                background: Container(
                  color: mlPrimaryColor,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(child: Image.asset(ml_ic_profile_picture!), radius: 40.0, backgroundColor: mlColorCyan),
                      8.height,
                      Text(nom?? " ", style: boldTextStyle(size: 20)),
                      4.height,
                      Text(userProfile?.email?? '', style: secondaryTextStyle(color: white, size: 16)),
                    ],
                  ),
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                      if ( index == 0 ) {
                        return MLProfileBottomComponent();
                      }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
