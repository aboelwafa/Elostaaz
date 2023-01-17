import 'package:elostaaz/shared/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../modules/Login/Moto_Login_Screen.dart';
import '../shared/network/Style/them.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';


class MotoLayout extends StatelessWidget {
  const MotoLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MotoCubit,MotoStates>(
      listener: (context, state) {

      },
      builder: (context, state) {
        var cubit=MotoCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            // leading:
            // Stack(
            //   children: [
            //     IconButton(
            //       onPressed: (){},
            //       icon: Icon(Icons.shopping_cart_outlined,size: 30,),
            //     ),
            //     Positioned(
            //       top: 4,
            //       right: 6,
            //       child: Container(
            //         height: 22,
            //         width: 22,
            //         decoration: const BoxDecoration(
            //           shape: BoxShape.circle,
            //           color: Colors.red,
            //         ),
            //         child: const Center(
            //             child: Text(
            //               "12",
            //               style: TextStyle(
            //                 fontSize: 11,
            //                 fontWeight: FontWeight.bold,
            //               ),
            //             )),
            //       ),
            //     ),
            //   ],
            //
            // ),
            title: Center(child: Text(cubit.titles[cubit.currentIndex])),
            actions: [

              IconButton(onPressed: (){
                // NewsCubit.get(context).changeAppMode();
                // Get.changeThemeMode(Get.isDarkMode?ThemeMode.light:ThemeMode.dark);
                ThemeService().changeThemeMode();
              }, icon: Icon(Icons.brightness_4_outlined)),
              TextButton(
                  onPressed: () {
                    navigateTo(context, FristLogin());
                  },
                  child: Text(
                    'login',
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
            onTap: (index){
              cubit.ChangeBottom(index);
            },
            currentIndex: cubit.currentIndex,
            items:  const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home,),
                  label: 'Home '

              ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.info_outline,),
                  label: 'InfoApp'

              ),



            ],
          ),
        );
      },
    );
  }
}
