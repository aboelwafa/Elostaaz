import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elostaaz/modules/Register/cubit/states.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:elostaaz/models/UserModel.dart';
import 'package:elostaaz/shared/network/cacheHelper.dart';



class SocialRegisterCubit extends Cubit<SocialRegisterStates>
{
  SocialRegisterCubit():super(SocialRegisterIntialStates());


  static SocialRegisterCubit get(context)=>BlocProvider.of(context);

  void userRegister({
    String? name,
    String? password,
    String? email,
    String? phone,
  })
  {
    emit(SocialRegisterLoadingStates());
    FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: '${email}',
        password: '${password}'
    ).then((value) {
      UserCreate(
          email: '${email}',
          name: '${name}',
          phone: '${phone}',
          uId: value.user?.uid
      );
      cacheHelper.saveData(key: 'uid', value: value.user!.uid);
      emit(SocialRegisterSucessUserStates());
    }).catchError((error){
      print(error.toString());
      emit(SocialRegisterErrorStates(error.toString()));
    });
  }

  void UserCreate({
    required String? name,
    required String? email,
    required String? phone,
    required String? uId,

  })
  {
    SocialUserModel model=SocialUserModel(
        name: '${name}',
        email: '${email}',
        phone: '${phone}',
        uId: '${uId}',
        bio: 'Write you bio...',
        cover: 'https://img.freepik.com/free-vector/night-desert-oasis-full-moon-starry-sky_107791-8599.jpg?w=740&t=st=1669046517~exp=1669047117~hmac=0d064876c54870b1fd4b30ef69c4870f1848854bb5a2d995d9a40b6da8b726b9',
        image: 'https://img.freepik.com/premium-photo/young-caucasian-man-celebrating-saint-patricks-day-showing-number-two-with-fingers_1187-83681.jpg?w=740',
        isEmailVerified: false
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .set(model.toMap())
        .then((value) {
      emit(SocialCreateUserSucessStates());

    }).catchError((error){
      print(error.toString());
      emit(SocialCreateUserErrorStates(error.toString()));
    });
  }
// to swap password hide password and visiable
  IconData suffix=Icons.visibility_outlined;
  bool ispassword=true;
  void changepassword(){

    ispassword=!ispassword;
    suffix= ispassword?Icons.visibility_outlined:Icons.visibility_off_outlined;
    emit(ChangePasswordVisibalityState());
  }
}