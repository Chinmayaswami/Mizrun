import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vendor/Auth/MobileNumber/UI/phone_number.dart';
import 'package:vendor/Auth/Verification/UI/verification_page.dart';
import 'package:vendor/Routes/routes.dart';

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class LoginRoutes {
  static const String loginRoot = 'login/';
  static const String verification = 'login/verification';
  static const String orderItemAccountPagerest =
      'login/orderItemAccountPagerest';
}

class LoginData {
  final String phoneNumber;
  final String name;
  final String email;

  LoginData(this.phoneNumber, this.name, this.email);
}

class LoginNavigator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        var canPop = navigatorKey.currentState.canPop();
        if (canPop) {
          navigatorKey.currentState.pop();
        }
        return !canPop;
      },
      child: Navigator(
        key: navigatorKey,
        initialRoute: LoginRoutes.loginRoot,
        onGenerateRoute: (RouteSettings settings) {
          WidgetBuilder builder;
          switch (settings.name) {
            case LoginRoutes.loginRoot:
              builder = (BuildContext _) => PhoneNumber();
              break;
            case LoginRoutes.orderItemAccountPagerest:
              builder = (BuildContext _) => GoMarketMangerHomeRestt();
              break;
            case LoginRoutes.verification:
              builder = (BuildContext _) => VerificationPage(
                    () {
                      hitNavitgator(context);
                    },
                  );
              break;
          }
          return MaterialPageRoute(builder: builder, settings: settings);
        },
        onPopPage: (Route<dynamic> route, dynamic result) {
          return route.didPop(result);
        },
      ),
    );
  }

  hitNavitgator(context) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String uiType = pref.getString("ui_type");
    if (uiType != null && uiType == "2") {
      Navigator.popAndPushNamed(context, PageRoutes.orderItemAccountPageRest);
    } else if (uiType != null && uiType == "5") {
      Navigator.popAndPushNamed(context, PageRoutes.orderItemAccountPharma);
    } else if (uiType != null && uiType == "4") {
      Navigator.popAndPushNamed(context, PageRoutes.orderItemAccountparcel);
    } else {
      Navigator.popAndPushNamed(context, PageRoutes.orderItemAccountPage);
    }
  }
}
