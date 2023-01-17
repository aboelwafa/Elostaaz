import 'package:elostaaz/shared/components/components.dart';
import 'package:elostaaz/shared/components/constants.dart';
import 'package:elostaaz/shared/network/cacheHelper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../layout/MotoLayoutScreen.dart';
import '../../../shared/network/Style/colors.dart';
import '../../../shared/network/Style/them.dart';
import '../../Login/Moto_Login_Screen.dart';
import 'cubitAdmin/cubit.dart';
import 'cubitAdmin/states.dart';

class AdminMotoLayout extends StatelessWidget {
  const AdminMotoLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AdminMotoCubit, AdminMotoStates>(
      listener: (context, state) {
        if(state is SingoutAdminSuccessState)
        {
          cacheHelper.deleteData(key: 'uId');
          print(uId);
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: Colors.white,
              content: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 200, bottom: 50),
                    child: Image(
                      image: AssetImage('assets/images/logout.gif'),
                    ),
                  ),

                ],
              )));
          navigateAndFinish(context, MotoLayout());
        }
      },
      builder: (context, state) {
        var cubit = AdminMotoCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Center(child: Text(cubit.titles[cubit.currentIndex])),
            actions: <Widget>[
              IconButton(
                  onPressed: () {
                    // NewsCubit.get(context).changeAppMode();
                    // Get.changeThemeMode(Get.isDarkMode?ThemeMode.light:ThemeMode.dark);
                    ThemeService().changeThemeMode();
                  },
                  icon: const Icon(Icons.brightness_4_outlined)),
              TextButton(
                  onPressed: () {
                    cubit.singOut();
                  },
                  child: Text(
                    'logout',
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(color: Colors.blueAccent),
                  ))
            ],
            centerTitle: true,
          ),
          body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            elevation: 0.0,
            type: BottomNavigationBarType.fixed,
            onTap: (index) {
              cubit.ChangeBottom(index);
            },
            currentIndex: cubit.currentIndex,
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.home,
                  ),
                  label: 'Home '),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.info_outline,
                  ),
                  label: 'infoApp'),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.add_business,
                  ),
                  label: 'AddProduct'),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.settings,
                  ),
                  label: 'DetailsProduct'),
            ],
          ),
        );
      },
    );
  }
}
