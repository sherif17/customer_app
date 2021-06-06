import 'package:customer_app/screens/dash_board/dash_board.dart';
import 'package:customer_app/screens/login_screens/confirm_user/confirm_is_that_user.dart';
import 'package:customer_app/screens/login_screens/otp/phone_verification.dart';
import 'package:customer_app/screens/login_screens/phone_number/enter_phone_number.dart';
import 'package:customer_app/screens/login_screens/user_register/register_new_user.dart';
import 'package:customer_app/screens/onboarding_screens/intro_screens/intro.dart';
import 'package:customer_app/screens/to_mechanic/choosing_mechanic_services.dart';
import 'package:customer_app/screens/to_mechanic/break_down_services.dart';
import 'package:customer_app/screens/winch_service/ongoing_trip/accepted_winch_driver_sheet.dart';
import 'package:customer_app/screens/winch_service/ongoing_trip/accepted_winch_trip_map.dart';
import 'package:customer_app/screens/winch_service/to_winch_map.dart';
import 'package:customer_app/screens/winch_service/winch_map.dart';
import 'package:flutter/widgets.dart';

import 'package:customer_app/screens/to_mechanic/routine_maintenance_services.dart';

import '../screens/dash_board/chatbot/chat.dart';

final Map<String, WidgetBuilder> routes = {
  Intro.routeName: (context) => Intro(),
  EnterPhoneNumber.routeName: (context) => EnterPhoneNumber(),
  VerifyPhoneNumber.routeName: (context) => VerifyPhoneNumber(),
  ConfirmThisUser.routeName: (context) => ConfirmThisUser(),
  RegisterNewUser.routeName: (context) => RegisterNewUser(),
  DashBoard.routeName: (context) => DashBoard(),
  ChatBot.routeName: (context) => ChatBot(),
  WinchMap.routeName: (context) => WinchMap(),
  ToWinchMap.routeName: (context) => ToWinchMap(),
  AcceptedWinchDriverSheet.routeName: (context) => AcceptedWinchDriverSheet(),
  WinchToCustomer.routeName: (context) => WinchToCustomer(),
  ChoosingMechanicServices.routeName: (context) => ChoosingMechanicServices(),
  BreakDownServices.routeName: (context) => BreakDownServices(),
  RoutineMaintenanceServices.routeName: (context) =>
      RoutineMaintenanceServices(),
};
