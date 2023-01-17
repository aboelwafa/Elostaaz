// ignore_for_file: file_names, unnecessary_import, must_be_immutable, avoid_unnecessary_containers, prefer_const_constructors, duplicate_ignore, prefer_const_constructors_in_immutables, sort_child_properties_last

import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:elostaaz/models/ProductModel.dart';
import 'package:elostaaz/shared/components/components.dart';
import 'package:elostaaz/shared/network/Style/colors.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_player/video_player.dart';

import 'Admin/layout/cubitAdmin/cubit.dart';
import 'Admin/layout/cubitAdmin/states.dart';
import 'cartScreen.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  CarouselController buttonCarouselController = CarouselController();

  int current = 0;

  final List<String> images = [
    'assets/images/fix1.jpg',
    'assets/images/fix2.jpg',
    'assets/images/fix3.jpg',
    'assets/images/fix4.jpg',
    'assets/images/fix5.jpg',
    'assets/images/moto.jpg',
    'assets/images/back.jpg',
  ];


  List<Widget> generateImageTitle() {
    return images
        .map((element) => ClipRRect(
              child: Image.asset(
                element,
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(20),
            ))
        .toList();
  }
  CollectionReference productRef = FirebaseFirestore.instance.collection('posts');



  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AdminMotoCubit,AdminMotoStates>(
      listener: (context, state) {

      },
      builder: (context, state) {
        return  Scaffold(
          body: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                Container(
                  color: Colors.white,
                  padding: EdgeInsets.only(top: 10),
                  child: Stack(
                    children: [
                      CarouselSlider(
                          items: generateImageTitle(),
                          options: CarouselOptions(
                            enlargeCenterPage: true,
                            autoPlay: true,
                            aspectRatio: 18 / 8,
                            height: 200,
                            onPageChanged: (index, reason) {
                              setState(() {
                                current = index;
                              });
                            },
                          )),

                    ],
                  ),
                ),
                Divider(color: Colors.grey),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0,right: 170),
                  child: Container(
                    width: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: defaultColor,
                    ),
                    child: Center(
                      child: Text(
                        'sales'
                        ,style: Theme.of(context).textTheme.bodyText1,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 1,),
                ConditionalBuilder(
                  condition: AdminMotoCubit.get(context).PRODUCT.length>0,
                  builder: (context) => ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),

                      itemBuilder:(context, index) => buildProductItem(AdminMotoCubit.get(context).PRODUCT[index], context, index) ,
                      itemCount:AdminMotoCubit.get(context).PRODUCT.length),
                  fallback: (context) => Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 208.0,bottom: 30),
                        child: CircularProgressIndicator(),
                      ),
                      SizedBox(height: 50,),
                      Center(child: Text('There are no products'),),
                    ],
                  ),
                ),
                SizedBox(height: 15.0,),

              ],
            ),
          ),
        );
      },
    );
  }

  Widget buildProductItem(PostModel model,context,index)=>
      InkWell(
        onTap: (){
          navigateTo(context, CartScreen(postModel: model,));
        },
        child: Card(
    elevation: 5.0,

    clipBehavior: Clip.antiAliasWithSaveLayer,
    child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          if(model.postImage!=null)
          Padding(
          padding: const EdgeInsetsDirectional.only(
        top: 5.0,
    ),
          child: Container(
            height:650.0 ,
            width: double.infinity,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),
                image: DecorationImage(image: NetworkImage('${model.postImage}'),
                    fit: BoxFit.fill
                )
            ),

          ),
        ),
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Text('code:'),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text('${model.code}',style: Theme.of(context).textTheme.bodyText1,),
              ),
            ],
          ),
          Row(
            children: [
              Text('Product_Name:'),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text('${model.data}',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Text('product_price:'),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text('${model.price}',style: Theme.of(context).textTheme.bodyText1,),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Icon(Icons.paid_outlined ,size: 25,color: Colors.green,),
              ),
            ],
          ),
          Row(
            children: [
              Text('Date:'),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text('${model.dateTime}',style: Theme.of(context).textTheme.bodyText1,),
              ),
            ],
          ),


        ],
    ),
  ),
      );
}
