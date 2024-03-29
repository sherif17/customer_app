import 'package:customer_app/screens/dash_board/dash_board.dart';
import 'package:customer_app/screens/login_screens/confirm_user/confirm_is_that_user.dart';
import 'package:customer_app/screens/login_screens/otp/phone_verification.dart';
import 'package:customer_app/screens/login_screens/phone_number/enter_phone_number.dart';
import 'package:customer_app/screens/login_screens/user_register/register_new_user.dart';
import 'package:customer_app/screens/onboarding_screens/intro_screens/intro.dart';
import 'package:customer_app/screens/to_mechanic/acceptted_mechanic_service/acceppted_mechanic_service_map.dart';
import 'package:customer_app/screens/to_mechanic/confirming_mechanic_service/confirming_mechanic_service_map.dart';
import 'package:customer_app/screens/to_mechanic/mechanic_services/break_down/break_down_services.dart';
import 'package:customer_app/screens/to_mechanic/mechanic_services/Choosing_mechanic_services/choosing_mechanic_services.dart';
import 'package:customer_app/screens/to_mechanic/mechanic_services/routine_maintenance/routine_maintenance_services.dart';
import 'package:customer_app/screens/to_mechanic/mechanic_services/cart_summary/view_selected_mechanic_services.dart';
import 'package:customer_app/screens/to_mechanic/starting_mechanic_service/car_checking.dart';
import 'package:customer_app/screens/to_mechanic/starting_mechanic_service/cheking_componants/ripple_animation.dart';
import 'package:customer_app/screens/to_mechanic/starting_mechanic_service/starting_mechanic_service.dart';
import 'package:customer_app/screens/winch_service/ongoing_trip/service_acceptted/accepted_winch_service_sheet.dart';
import 'package:customer_app/screens/winch_service/ongoing_trip/accepted_winch_trip_map.dart';
import 'package:customer_app/screens/winch_service/to_winch_map.dart';
import 'package:customer_app/screens/winch_service/winch_map.dart';
import 'package:flutter/widgets.dart';

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
  AcceptedWinchServiceSheet.routeName: (context) => AcceptedWinchServiceSheet(),
  WinchToCustomer.routeName: (context) => WinchToCustomer(),
  ChoosingMechanicServices.routeName: (context) => ChoosingMechanicServices(),
  BreakDownServices.routeName: (context) => BreakDownServices(),
  RoutineMaintenanceServices.routeName: (context) =>
      RoutineMaintenanceServices(),
  ViewSelectedMechanicServices.routeName: (context) =>
      ViewSelectedMechanicServices(),
  ConfirmingMechanicServiceMap.routeName: (context) =>
      ConfirmingMechanicServiceMap(),
  AcceptedMechanicServiceMap.routeName: (context) =>
      AcceptedMechanicServiceMap(),
  CarChecking.routeName: (context) => CarChecking(),
  StartingMechanicService.routeName: (context) => StartingMechanicService(),
};
