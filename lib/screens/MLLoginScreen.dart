import 'package:esmv_store/l10n/gen/app_localizations.dart';
import 'package:esmv_store/main.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import 'package:esmv_store/utils/MLCommon.dart';
import 'package:esmv_store/screens/MLForgetPasswordScreen.dart';
import 'package:esmv_store/utils/MLColors.dart';
import 'package:esmv_store/utils/MLImage.dart';
import 'package:esmv_store/providers/auth_provider.dart';

class MLLoginScreen extends StatefulWidget {
  static String tag = '/MLLoginScreen';

  @override
  _MLLoginScreenState createState() => _MLLoginScreenState();
}
class _MLLoginScreenState extends State<MLLoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _rememberMe = false;
  bool _isPasswordHidden = true;
  String _selectedLanguage = 'fr';

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    changeStatusColor(mlPrimaryColor);
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      backgroundColor: mlPrimaryColor,
      body: Stack(
        children: [
          Container(
            margin: EdgeInsets.only(top: 250),
            height: context.height(),
            decoration: boxDecorationWithRoundedCorners(
              borderRadius: radiusOnly(topRight: 32),
              backgroundColor: context.cardColor,
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  60.height,
                  Text(AppLocalizations.of(context)!.seconnecter, style: secondaryTextStyle(size: 16)),
                  16.height,
                  Row(
                    children: [
                      16.width,
                      AppTextField(
                        controller: _emailController,
                        textFieldType: TextFieldType.EMAIL,
                        decoration: InputDecoration(
                          labelText: AppLocalizations.of(context)!.email,
                          labelStyle: secondaryTextStyle(size: 16),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: mlColorLightGrey.withOpacity(0.2), width: 1),
                          ),
                        ),
                      ).expand(),
                    ],
                  ),
                  16.height,
                  AppTextField(
                    controller: _passwordController,
                    textFieldType: TextFieldType.PASSWORD,
                    obscureText: _isPasswordHidden, // Use this property to toggle password visibility
                    decoration: InputDecoration(
                      labelText: AppLocalizations.of(context)!.password,
                      labelStyle: secondaryTextStyle(size: 16),
                      prefixIcon: Icon(Icons.lock_outline, color: appStore.isDarkModeOn ? white : black),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _isPasswordHidden ? Icons.visibility_off : Icons.visibility,
                          color: appStore.isDarkModeOn ? white : black,
                        ),
                        onPressed: () {
                          setState(() {
                            _isPasswordHidden = !_isPasswordHidden; // Toggle visibility
                          });
                        },
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: mlColorLightGrey.withOpacity(0.2)),
                      ),
                    ),
                  ),
                  8.height,
                  Align(
                    alignment: Alignment.topRight,
                    child: Text(AppLocalizations.of(context)!.motdepasseoulier, style: secondaryTextStyle(size: 16)).onTap(
                          () {
                        MLForgetPasswordScreen().launch(context);
                      },
                    ),
                  ),
                  16.height,
                  DropdownButton<String>(
                    value: _selectedLanguage,
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedLanguage = newValue!;
                      });
                      // Update app locale
                      AppLocalizations.delegate.load(Locale(newValue!));
                      MyApp.setLocale(context, Locale(newValue));
                    },
                    items: <String>['en', 'fr', 'ar'] // Add supported languages
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value == 'en' ? 'English' :
                          value == 'fr' ? 'Français' :
                          'العربية', // Arabic label
                          style: TextStyle(fontFamily: 'ArabicFont'), // Optional: Ensure proper Arabic font
                        ),
                      );
                    }).toList(),
                  ),
                  8.height,
                  Row(
                    children: [
                      Checkbox(
                        value: _rememberMe,
                        onChanged: (bool? value) {
                          setState(() {
                            _rememberMe = value!;
                          });
                        },
                      ),
                      Text(AppLocalizations.of(context)!.rememberme, style: secondaryTextStyle(size: 16)),
                    ],
                  ),
                  24.height,
                  AppButton(
                    color: mlPrimaryColor,
                    width: double.infinity,
                    onTap: () {
                      authProvider.login(
                        _emailController.text.trim(),
                        _passwordController.text.trim(),
                        context,
                        _rememberMe, // Pass the remember me value
                      );
                    },
                    child: Text(AppLocalizations.of(context)!.login, style: boldTextStyle(color: white)),
                  ),
                  22.height,
                ],
              ).paddingOnly(left: 16, right: 16),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 75),
            width: context.width(),
            child: commonCachedNetworkImage(ml_ic_register_indicator!, alignment: Alignment.center, width: 200, height: 180),
          ),
          if (authProvider.isLoading) Center(child: CircularProgressIndicator()),
        ],
      ),
    );
  }
}

