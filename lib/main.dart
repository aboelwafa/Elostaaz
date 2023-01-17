// ignore_for_file: unused_import, unnecessary_import, deprecated_member_use, must_be_immutable

import 'package:bloc/bloc.dart';
import 'package:elostaaz/modules/OnBoardingScreen.dart';
import 'package:elostaaz/shared/components/constants.dart';
import 'package:elostaaz/shared/network/Style/them.dart';
import 'package:elostaaz/shared/network/bloc_observed.dart';
import 'package:elostaaz/shared/network/cacheHelper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'layout/MotoLayoutScreen.dart';

import 'layout/cubit/cubit.dart';
import 'layout/cubit/states.dart';
// Import the generated file
import 'firebase_options.dart';
import 'modules/Admin/layout/AdminMotoLayoutScreen.dart';
import 'modules/Admin/layout/cubitAdmin/cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
print(DefaultFirebaseOptions.currentPlatform.apiKey);
  Bloc.observer = MyBlocObserver();
  await cacheHelper.init();
  Widget? widget;
  bool? onBoarding= cacheHelper.getData(key: 'onBoarding');
  print(onBoarding);
  uId = cacheHelper.getData(key: 'uId') ;
  print(uId);
  if(onBoarding!=null)
  {
    if(uId!=null)
    {
      widget=AdminMotoLayout();
    }
    else {
      widget = MotoLayout();
    }
  }
  else{
    widget=OnBoardingScreen();
  }


  runApp( MyApp(
    StartWidget: widget,
  ));
}

class MyApp extends StatelessWidget {
  late Widget StartWidget;
  MyApp(
      {
        required this.StartWidget,
      }
      );

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create:(context) =>MotoCubit()..getProducts()),
        BlocProvider(create:(context) =>AdminMotoCubit()..getProducts()),
      ],
      child: BlocConsumer<MotoCubit,MotoStates>
        (
        listener: (context, state) {

        },
        builder: (context, state) {

          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Elostaaz',
            theme: ThemeService().lightTheme,
            darkTheme: ThemeService().darkTheme,
            themeMode: ThemeService().getThemeMode(),
            home: StartWidget,
          );
        },
      ),
    );
  }
}

