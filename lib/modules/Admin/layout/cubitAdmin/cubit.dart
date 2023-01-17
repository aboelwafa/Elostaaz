// igcodere_for_file: unnecessary_import

import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elostaaz/models/UserModel.dart';
import 'package:elostaaz/modules/Admin/layout/cubitAdmin/states.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import '../../../../models/ProductModel.dart';
import '../../../../shared/components/constants.dart';
import '../../../HomeScreen.dart';
import '../../../IinformationApp.dart';
import '../../AddProduct.dart';
import '../../DetailsProducts.dart';
import '../../EditProducts.dart';
import 'package:elostaaz/shared/network/cacheHelper.dart';

class AdminMotoCubit extends Cubit<AdminMotoStates> {
  AdminMotoCubit() : super(AdminMotoInitialStates());

  static AdminMotoCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<Widget> screens = [
    HomeScreen(),
    InformationApp(),
    AddProduct(),
    DetailsProduct(),
  ];
  List<String> titles = [
    'Elostaaz Home',
    'Info App ',
    'AddProduct',
    'DetailsProduct',
    'HomeAdmin',
    'EditProfile ',
  ];

  void ChangeBottom(index) {
    if (index == 3 || index == 0) getProducts();
    currentIndex = index;
    emit(AdminMotoChangeNavBarItemStates());
  }

  //get userdata
  SocialUserModel? userModel;

  //singout
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future singOut() async {
    return await _auth.signOut().then((value) {
      emit(SingoutAdminSuccessState());
    }).catchError((error) {
      emit(SingoutAdminErrorState());
    });
  }

  void getUserData() {
    emit(AdminMotoGetUserDataLoadingStates());
    FirebaseFirestore.instance.collection('users').doc(uId).get().then((value) {
      userModel = SocialUserModel.fromJson(value.data());
      print(userModel?.name);
      print(userModel?.uId);
      print(userModel?.email);

      emit(AdminMotoGetUserDataSuccessStates());
    }).catchError((error) {
      print(error.toString());
      emit(AdminMotoGetUserDataErrorStates());
    });
  }

  void CreatePost({
    required String dateTime,
    required String data,
    required String price,
    String? postImage,
    String? postvideo,
    required String? code,
  }) {
    emit(AdminMotoCreateProductLoadingStates());

    PostModel model = PostModel(
      postVideo: postvideo ?? '',
      code: code,
      dateTime: dateTime,
      data: data,
      price: price,
      postImage: postImage ?? '',
    );
    FirebaseFirestore.instance
        .collection('posts')
        .doc(code)
        .set(model.toMap())
        .then((value) {
      emit(AdminMotoCreateProductSuccessStates());
    }).catchError((error) {
      print(error.toString());
      emit(AdminMotoCreateProductErrorStates());
    });
  }

//  file image
  final picker = ImagePicker();

//  FILE POSTimage
  File? postImage;

  Future getPostImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      postImage = File(pickedFile.path);
      emit(SocialPostImagePickedSuccessState());
    } else {
      print('code image selected');
      emit(SocialPostImagePickedErrorState());
    }
  }

  //from camera
  Future getPostImageCamera() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      postImage = File(pickedFile.path);
      emit(SocialPostImagePickedSuccessState());
    } else {
      print('code image selected');
      emit(SocialPostImagePickedErrorState());
    }
  }

  void removeImage() {
    postImage = null;
    emit(SocialRemovePostImageSuccessState());
  }

//  uploadPostImage
  void UploadPostImage({
    required String dateTime,
    required String data,
    required String price,
    required String code,
  }) {
    emit(SocialCreatePostLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('postsImage/${Uri.file(postImage!.path).pathSegments}')
        .putFile(postImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        print(value);
        CreatePost(
          code: code,
          data: data,
          dateTime: dateTime,
          postImage: value,
          price: price,
        );
        emit(SocialCreatePostSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(SocialCreatePostErrorState());
      });
    }).catchError((error) {
      print(error.toString());
      emit(SocialCreatePostErrorState());
    });
  }

// upload video firestorge
  File? postVideo;

  Future getVideo() async {
    final pickedFile = await picker.pickVideo(source: ImageSource.gallery);
    if (pickedFile != null) {
      postVideo = File(pickedFile.path);
      print(postVideo);
      emit(SocialVIDEOPickedSuccessState());
    } else {
      print('code Video selected');
      emit(SocialVIDEOPickedErrorState());
    }
  }

  void removeVideo() {
    postVideo = null;
  }

// upload post video
  void UploadNewVideo({
    required String dateTime,
    required String data,
    required String price,
    required String code,
  }) {
    emit(SocialUploadVideoLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('postsVideo/${Uri.file(postVideo!.path).pathSegments.last}')
        .putFile(postVideo!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        CreatePost(
          code: code,
          price: price,
          data: data,
          dateTime: dateTime,
          postvideo: value,
        );
      }).catchError((error) {});
      print(value);
      print('omar video');
      emit(SocialUploadVideoSuccessState());
    }).catchError((error) {
      emit(SocialUploadVideoErrorState());
    });
  }

  List<PostModel> posts = [];

  // get post stream
  // void getStreamPost()
  // {
  //
  //   emit(SocialGetPostLoadingState());
  //   FirebaseFirestore.instance.collection('posts')
  //       .snapshots()
  //       .listen((event) {
  //     event.docs.forEach((element) {
  //       element.reference.collection('posts')
  //           .get()
  //           .then((value) {
  //             print(element.data());
  //         posts.add(PostModel.fromJson(element.data()));
  //         emit(SocialGetPostSuccessState());
  //       })
  //           .catchError((error){});
  //
  //       //CommentId.add(element.id);
  //
  //     });
  //   });
  //
  // }
  PostModel? postModel;

  void UpdateProduct({
    required String price,
    required String data,
    required String dateTime,
    required String code,
    String? postImage,
  }) {
    emit(UpdatePostsLoadingStates());
    PostModel model = PostModel(
      postImage: postImage ?? postModel?.postImage,
      // postVideo: postmodel?.postVideo,
      dateTime: dateTime,
      price: price,
      data: data,
      code: code,
    );
    FirebaseFirestore.instance
        .collection('posts')
        .doc(code)
        .update(model.toMap())
        .then((value) {
      print(code);
      getProducts();
      emit(UpdatePostsSuccessStates());
    }).catchError((error) {
      print(error.toString());
      emit(UpdatePostsErrorStates());
    });
  }

  //  getproduct
//  get product from firebase
  List<PostModel> PRODUCT = [];
  List<String> postId = [];

  void getProducts() {
    {
      emit(GetPostLoadingState());
      PRODUCT = [];

      FirebaseFirestore.instance.collection('posts').get().then((value) {
        value.docs.forEach((element) {
          postId.add(element.id);
          // if (element.data()['uId'] == userModel?.uId)
          PRODUCT.add(PostModel.fromJson(element.data()));
        });
        print(postId[0]);
        emit(GetPostSuccessState());
      }).catchError((error) {
        emit(GetPostErrorState());
      });
    }
  }

  //get details product only
  List<PostModel> detailsProduct = [];

  void getDetailClient({
    String? code,
  }) {
    FirebaseFirestore.instance
        .collection('posts')
        .orderBy('dateTime')
        .snapshots()
        .listen((event) {
      //detailsClients=[];
      event.docs.forEach((element) {
        detailsProduct.add(PostModel.fromJson(element.data()));
      });
      emit(GetProductDetailsSuccessStates());
    });
  }

  void UploadProductImage(
      {required String price,
      required String data,
      required String dateTime,
      required String code}) {
    emit(SocialUpdateUserLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('posts/${Uri.file(postImage!.path).pathSegments}')
        .putFile(postImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        print(value);
        UpdateProduct(
          price: price,
          data: data,
          dateTime: dateTime,
          code: code,
          postImage: value,
        );
        // emit(SocialUploadpostImageSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(SocialUploadProfileImageErrorState());
      });
    }).catchError((error) {
      print(error.toString());
      emit(SocialUploadProfileImageErrorState());
    });
  }

//aboHamza
  CollectionReference productRef =
      FirebaseFirestore.instance.collection('posts');

  void deleteProduct({required String code}) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(code)
        .delete()
        .then((value) {
      emit(deleteProductSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(deleteProductErrorState());
    });
  }
}
