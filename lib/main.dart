import 'package:customer_app/local_db/customer_db/customer_info_db.dart';
import 'package:customer_app/local_db/customer_db/cutomer_owned_cars_model.dart';
import 'package:customer_app/local_db/mechanic_services_db/break_down_model.dart';
import 'package:customer_app/provider/customer_cars/customer_car_provider.dart';
import 'package:customer_app/provider/maps_preparation/mapsProvider.dart';
import 'package:customer_app/provider/maps_preparation/polyLineProvider.dart';
import 'package:customer_app/provider/mechanic_services/mechanic_services_provider.dart';
import 'package:customer_app/provider/winch_request/winch_request_provider.dart';
import 'package:customer_app/screens/dash_board/dash_board.dart';
import 'package:customer_app/screens/onboarding_screens/intro_screens/intro.dart';
import 'package:customer_app/screens/to_mechanic/choosing_mechanic_services.dart';
import 'package:customer_app/screens/to_mechanic/break_down_services.dart';
import 'package:customer_app/utils/routes.dart';
import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'localization/demo_localization.dart';
import 'localization/localization_constants.dart';
import 'themes/light_theme.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  final appDocumentDir = await path_provider.getApplicationDocumentsDirectory();
  Hive.init(appDocumentDir.path);
  //Hive.registerAdapter(customerInfoDBAdapter());
  Hive.registerAdapter(customerOwnedCarsDBAdapter());
  Hive.registerAdapter(BreakDownDBAdapter());
  await Hive.openBox<customerOwnedCarsDB>(
      "customerCarsDBBox"); // for customer cars
  await Hive.openBox<BreakDownDBAdapter>("BreakDownDBBox");
  await Hive.openBox<String>("customerInfoDBBox"); // for customer info
  bool devicePreview = false;
  if (devicePreview == false)
    return runApp(App());
  else
    runApp(DevicePreview(
      enabled: !kReleaseMode,
      builder: (context) => App(),
    ));
}

class App extends StatelessWidget {
  // Create the initialization Future outside of `build`:
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire:
      future: _initialization,
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          return Text("SomethingWentWrong");
          //SomethingWentWrong();
        }
        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return MyApp();
        }
        // Otherwise, show something whilst waiting for initialization to complete
        return Container(
          child: Center(
            child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.blue[800])),
          ),
        ); //ProgressHUD(child: null, inAsyncCall: null,); //Loading();
      },
    );
  }
}

class MyApp extends StatefulWidget {
  static void setLocale(BuildContext context, Locale locale) {
    _MyAppState state = context.findAncestorStateOfType<_MyAppState>();
    state.setLocale(locale);
  }

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale _locale;
  String TOKEN = loadJwtTokenFromDB();
  String BACKEND_ID = loadBackendIDFromDB();

  setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  void didChangeDependencies() {
    getLocale().then((local) => {
          setState(() {
            _locale = local;
          })
        });
    super.didChangeDependencies();
  }

  @override
  Widget build(context) {
    if (_locale == null) {
      return Container(
        child: Center(
          child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.blue[800])),
        ),
      );
    } else {
      // TODO: implement build
      return MultiProvider(
        providers: [
          ChangeNotifierProvider<MapsProvider>(create: (_) => MapsProvider()),
          ChangeNotifierProvider<WinchRequestProvider>(
              create: (_) => WinchRequestProvider()),
          ChangeNotifierProvider<CustomerCarProvider>(
              create: (_) => CustomerCarProvider()),
          ChangeNotifierProvider<PolyLineProvider>(
              create: (_) => PolyLineProvider()),
          ChangeNotifierProvider<MechanicServiceProvider>(
              create: (_) => MechanicServiceProvider()),
        ],
        child: new MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: lightTheme(),
          builder: DevicePreview.appBuilder,
          initialRoute:
              ChoosingMechanicServices.routeName, //RegisterNewUser.routeName,
          // TOKEN == "" || BACKEND_ID == ""
          //     ? Intro.routeName
          //     : DashBoard.routeName,
          routes: routes,
          locale: _locale,
          supportedLocales: [
            Locale("en", "US"),
            Locale("ar", "EG"),
          ],
          localizationsDelegates: [
            DemoLocalization.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          localeResolutionCallback: (deviceLocal, supportedLocales) {
            for (var local in supportedLocales) {
              if (local.languageCode == deviceLocal.languageCode &&
                  local.countryCode == deviceLocal.countryCode) {
                return deviceLocal;
              }
            }
            return supportedLocales.first;
          },
        ),
      );
    }
  }
}
