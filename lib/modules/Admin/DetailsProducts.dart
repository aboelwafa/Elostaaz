// ignore_for_file: file_names, unnecessary_import, must_be_immutable, avoid_unnecessary_containers, prefer_const_constructors, duplicate_ignore, prefer_const_constructors_in_immutables, sort_child_properties_last

import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:elostaaz/models/ProductModel.dart';
import 'package:elostaaz/modules/Admin/EditProducts.dart';
import 'package:elostaaz/shared/components/components.dart';
import 'package:elostaaz/shared/network/Style/colors.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:video_player/video_player.dart';

import 'layout/cubitAdmin/cubit.dart';
import 'layout/cubitAdmin/states.dart';

class DetailsProduct extends StatefulWidget {
  DetailsProduct({super.key});

  @override
  State<DetailsProduct> createState() => _DetailsProductState();
}

class _DetailsProductState extends State<DetailsProduct> {
  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      AdminMotoCubit.get(context).getProducts();
      return BlocConsumer<AdminMotoCubit, AdminMotoStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = AdminMotoCubit.get(context);
          return Scaffold(
            body: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                children: [
                  SizedBox(
                    height: 1,
                  ),
                  ConditionalBuilder(
                    condition:cubit.PRODUCT.length>0,
                    builder: (context) => ListView.separated(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) => buildProductItem(
                            cubit.PRODUCT[index], context, index),
                        separatorBuilder: (context, index) => SizedBox(
                          height: 10,
                        ),
                        itemCount: cubit.PRODUCT.length),
                    fallback: (context) => Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 208.0,bottom: 30),
                          child: CircularProgressIndicator(),
                        ),
                        SizedBox(height: 50,),
                        Center(child: Text('There are no products, please add at least one product'),),
                      ],
                    ),

                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                ],
              ),
            ),
          );
        },
      );
    });
  }

  Widget buildProductItem(PostModel model, context, index) => InkWell(
        onTap: () {
          navigateTo(context, EditProduct(postModel: model));
          print(model.code);
        },
        child: Card(
          elevation: 5.0,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (model.postImage != null)
                Padding(
                  padding: const EdgeInsetsDirectional.only(
                    top: 5.0,
                  ),
                  child: Container(
                    height: 650.0,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        image: DecorationImage(
                            image: NetworkImage('${model.postImage}'),
                            fit: BoxFit.fill)),
                  ),
                ),
              // if(model.postVideo !=null)
              // Padding(
              //     padding: const EdgeInsetsDirectional.only(top: 15.0),
              //     child: Container(
              //       height: 300.0,
              //       width: double.infinity,
              //       child: FlickVideoPlayer(
              //         flickManager: FlickManager(
              //           videoPlayerController: VideoPlayerController.network('${model.postVideo}')
              //           ,
              //           autoPlay: false,
              //           autoInitialize: true,
              //         ),
              //       ),
              //     ),
              //   ),
              Row(
                children: [
                  Text(
                    'productName:',
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          fontSize: 22,
                          color: HexColor('#3A7B90'),
                        ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(
                      '${model.data}',
                      style: Theme.of(context)
                          .textTheme
                          .bodyText2!
                          .copyWith(color: Colors.blue, fontSize: 22),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    'price:',
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          fontSize: 22,
                          color: HexColor('#3A7B90'),
                        ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(
                      '${model.price} pound',
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(color: Colors.green),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    'code_product:',
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          fontSize: 22,
                          color: HexColor('#3A7B90'),
                        ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(
                      '${model.code}',
                      style: Theme.of(context).textTheme.bodyText2!.copyWith(
                            color: Colors.red,
                          ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      );
}
