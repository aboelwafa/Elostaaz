// ignore_for_file: unnecessary_import
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elostaaz/layout/cubit/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc/bloc.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter_cart/flutter_cart.dart';

import '../../models/ProductModel.dart';
import '../../modules/Admin/AddProduct.dart';
import '../../modules/Admin/DetailsProducts.dart';
import '../../modules/Admin/EditProducts.dart';
import '../../modules/HomeScreen.dart';
import '../../modules/IinformationApp.dart';


class MotoCubit extends Cubit<MotoStates>
{
  MotoCubit():super(MotoInitialStates());

  static MotoCubit get(context)=>BlocProvider.of(context);

  // void getUserData()
  // {
  //   emit(MotoGetUserDataLoadingStates());
  //   FirebaseFirestore.instance.collection('USERS')
  //       .doc(uId)
  //       .get()
  //       .then((value) {
  //     userModel=MotoUserModel.fromJson(value.data());
  //     print(userModel?.name);
  //     print(userModel?.uId);
  //     print(userModel?.email);
  //
  //     emit(MotoGetUserDataSuccessStates());
  //   })
  //       .catchError((error){
  //     print(error.toString());
  //     emit(MotoGetUserDataErrorStates());
  //   });
  // }

  int currentIndex=0;

  List<Widget> screens=[
     HomeScreen(),
    InformationApp(),
    AddProduct(),
    DetailsProduct(),




  ];
  List<String> titles=[
    'Elostaaz Home',
    'Info App ',
    'AddProduct',
    'EditProduct',
    'HomeAdmin',
    'ProfileScreen ',
  ];

  void ChangeBottom(index)
  {
    if(index==0)
      getProducts();
    currentIndex=index;
    emit(MotoChangeNavBarItemStates());
  }

  // get product from firebase
  List<PostModel> PRODUCT = [];
  List<String> postId = [];

  void getProducts() {
    {
      emit(GetPostLoadingState());
      PRODUCT = [];
      FirebaseFirestore.instance
          .collection('posts')
          .get()
          .then((value) {
        value.docs.forEach((element) {
          postId.add(element.id);
          // if (element.data()['uId'] == userModel?.uId)
          PRODUCT.add(PostModel.fromJson(element.data()));
          print(postId);
        });

        emit(GetPostSuccessState());
      }).catchError((error) {
        emit(GetPostErrorState());
      });
    }
  }
  //
  // //get details product only
  List<PostModel> detailsProduct = [];

  void getDetailClient({
    required String data,
  }) {
    FirebaseFirestore.instance
        .collection('posts')
        .orderBy('dateTime')
        .snapshots()
        .listen((event) {
      //detailsClients=[];
      event.docs.forEach((element) {
        detailsProduct.add(PostModel.fromJson(element.data()));
        print(element.id);
      });
      emit(GetProductDetailsSuccessStates());
    });
  }
  //cart



}
