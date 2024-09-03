import 'package:eagle_valet_parking/bloc/calculate_duration_bloc/calculate_duration_cubit.dart';
import 'package:eagle_valet_parking/bloc/parking_cubit/parking_cubit.dart';
import 'package:eagle_valet_parking/generated/l10n.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/authentication_bloc/auth_bloc.dart';
import 'bloc/authentication_bloc/auth_events.dart';
import 'bloc/sharedprefrences/sharedpref_bloc.dart';
import 'bloc/sharedprefrences/sharedpref_state.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'bloc/user_bloc/user_bloc.dart';
import 'resources/router.dart';
import 'resources/routes.dart';
import 'resources/theme_manager.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

 

  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (context) => SharedPrefBloc()..appStarted(),
        lazy: false,
      ),
      BlocProvider(
        create: (context) => AuthenticationBloc()..add(AppStarted()),
        lazy: false,
      ),
      BlocProvider(create: (context) => UserBloc()),
      BlocProvider(create: (context) => ParkingCubit()),
      BlocProvider(create: (context) => CalculateDurationCubit()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SharedPrefBloc, SettingsStates>(
      builder: (BuildContext context, SettingsStates state) => MaterialApp(
        debugShowCheckedModeBanner: false,
        locale: Locale(context.read<SharedPrefBloc>().lang),
        localizationsDelegates: const [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: S.delegate.supportedLocales,
        title: 'Eagle valet parking',
        theme: ThemeManager.lightTheme,
        initialRoute: Routes.splashScreen,
        onGenerateRoute: (settings) => RoutesGeneratour.getRoute(settings),
      ),
    );
  }
}
