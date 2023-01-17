// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_key_in_widget_constructors, must_be_immutable, unnecessary_string_interpolations, unused_import, file_names, avoid_print, sized_box_for_whitespace

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:elostaaz/modules/HomeScreen.dart';
import 'package:elostaaz/shared/components/components.dart';
import 'package:elostaaz/shared/network/Style/colors.dart';
import 'package:elostaaz/shared/network/cacheHelper.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../firebase_options.dart';
import '../layout/MotoLayoutScreen.dart';
import '../shared/network/Style/them.dart';
//1 create class to change image in screen
class BoardingModel{
  final String image;
  final String text;

  BoardingModel({required this.image,required this.text});
}

class OnBoardingScreen extends StatefulWidget {
  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
// 2-create list contain images
    List<BoardingModel>boardin=[
      // frist image
      BoardingModel(
        image: 'assets/images/fix1.jpg',
        text: 'Repairing motorcycles and replacing required spare parts',
        ),
      BoardingModel(
        image: 'assets/images/tool1.gif',
        text: 'elostaaz store has all the spare parts required for the motorcycle'),
      BoardingModel(
          image: 'assets/images/fix5.jpg',
          text: 'We can fix your motorcycle'
      ),
      BoardingModel(
        image: 'assets/images/moto.jpg',
        text: 'You can also use its application to view the best types of spare parts'
        ),
      // BoardingModel(image: 'assets/images/chat2.png',text: 'Enjoy with best friend'),
    ];
    bool islast= false;
      //fun to make saveData in sharedPrefrence and navigate finish to nextPage
    void submit()
    {
      cacheHelper.saveData(
          key: 'onBoarding',
          value: true
      ).then((value)
      {
        print(value);
        if(value!)
        {
          navigateAndFinish(context, MotoLayout());}}
      );
    }
    var boardController=PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(onPressed: (){
            submit();
          },
              child: Text('SKIP',style: TextStyle(
                  color: defaultColor,fontSize: 23
              ,fontWeight: FontWeight.bold,
                fontFamily: 'Pacifico'
              ),)
          ),
          IconButton(onPressed: (){
            // NewsCubit.get(context).changeAppMode();
            // Get.changeThemeMode(Get.isDarkMode?ThemeMode.light:ThemeMode.dark);
            ThemeService().changeThemeMode();
          }, icon: Icon(Icons.brightness_4_outlined))

        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            // if(DefaultFirebaseOptions.currentPlatform.apiKey!='AIzaSyBD5sQluSQp5RpioDX8aM7Q9nLvrbLLTJk')
           Expanded(
             child: DefaultTextStyle(
              style:  TextStyle(
                fontSize: 50,
                color: Colors.white,
                fontWeight: FontWeight.w800,
                shadows: [
                  Shadow(
                    blurRadius: 30.0,
                    color: defaultColor,
                    offset: Offset(0, 0),
                  ),
                ],
              ),
              child: AnimatedTextKit(
                repeatForever: true,
                animatedTexts: [
                  FlickerAnimatedText('Elostaaz')
                ],
              ),
          ),
           ),
            // Expanded(
            //   child: DefaultTextStyle(
            //     style:  TextStyle(
            //
            //       color: Colors.green,
            //       fontWeight: FontWeight.w800,
            //       shadows: [
            //         Shadow(
            //           blurRadius: 30.0,
            //           color: defaultColor,
            //           offset: Offset(0, 0),
            //         ),
            //       ],
            //     ),
            //     child: AnimatedTextKit(
            //
            //       repeatForever: true,
            //       animatedTexts: [
            //         FlickerAnimatedText('Elostaaz',textStyle: TextStyle(fontSize: 25))
            //       ],
            //     ),
            //   ),
            // ),
            SizedBox(height: 50.0,),
            Container(
                 height: 400.0,
                 width: double.infinity,
                 child: PageView.builder(
                   //function to check index is last ==true > islast =true else islast=false
                   //build on last= true > navigate to next page used in floating
                   onPageChanged: (int index){
                     if(index==boardin.length-1){
                       setState(() {
                         islast=true;
                         print(index);
                       });
                     }
                     else{
                       setState(() {
                         islast=false;
                         print(index);
                       });
                     }
                   },
                   controller: boardController,
                   //controller make page dynamic
                   physics: BouncingScrollPhysics(),
                   //move page
                   itemBuilder: (context, index) =>  buildBoardingItem(boardin[index]),
                   itemCount: boardin.length,
                   //length list
                   ),
               ),
            SizedBox(height: 20.0,),
            Spacer(),
            SmoothPageIndicator(
               controller: boardController,
                count: boardin.length,
                //design =>effect
                effect: ExpandingDotsEffect(
                 dotColor: Colors.grey[300] as Color,
                 offset: 20.0,
                 strokeWidth: 1.5,
                 dotWidth: 15.0,
                 radius: 20.0,
                 paintStyle: PaintingStyle.fill,
                 expansionFactor: 2,
                 dotHeight: 10.0,
                 spacing: 3,
                 activeDotColor:defaultColor,
                ),
                ) ,
            Spacer(),
               if(islast)
                SizedBox(
                  width:200.0 ,
                    height: 50,
                    child: defaultButton(function: ()
                    {
                          if(islast){
                            submit();
                          }
                          else{
                            boardController.nextPage(
                                duration:
                                Duration(milliseconds: 1000),
                                curve:Curves.fastLinearToSlowEaseIn
                            );
                      }

                    }, text: ' Start',
                    background: defaultColor,
                      fontfamily: 'Pacifico'
                    )),



          ],
        ),
      ),

    );
  }

  // widget use in page.view(itemBuilde) call it
  Widget buildBoardingItem(BoardingModel model)=>Column(
        children: [
          Expanded(child: Image(image: AssetImage('${model.image}'))),

          Text('${model.text}',style: TextStyle(
            fontSize: 20,
            color: Color.fromARGB(255, 110, 107, 107),),)

        ],
      );
}