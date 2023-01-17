import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:elostaaz/shared/components/components.dart';
import 'package:elostaaz/shared/network/Style/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'layout/cubitAdmin/cubit.dart';
import 'layout/cubitAdmin/states.dart';
import 'package:video_player/video_player.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({Key? key}) : super(key: key);

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  var dataController = TextEditingController();
  var numberController = TextEditingController();
  var priceController = TextEditingController();
  var DateController = TextEditingController();
  var formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AdminMotoCubit, AdminMotoStates>(
      listener: (context, state) {
        if (state is AdminMotoCreateProductSuccessStates ||
            state is SocialUploadVideoSuccessState) {
          numberController.clear();
          priceController.clear();
          dataController.clear();
          DateController.clear();
          // AdminMotoCubit.get(context).removeVideo();
          AdminMotoCubit.get(context).removeImage();

          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: Colors.white,
              content: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 150, bottom: 10),
                    child: Image(
                      image: AssetImage('assets/images/ok.gif'),
                    ),
                  ),
                  const Spacer(),
                  Text(
                    'Successfully Add product ',
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          color: Colors.green,
                          fontSize: 30,
                        ),
                  ),
                ],
              )));
        }
      },
      builder: (context, state) {
        var cubit = AdminMotoCubit.get(context);
        // listen profile image
        var postImage = AdminMotoCubit.get(context).postImage;
        var postVideo = AdminMotoCubit.get(context).postVideo;

        // listen coverImage
        return Scaffold(
          body: ListView(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Text(
                        'select from gallery',
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                      const SizedBox(
                        height: 7,
                      ),
                      defaultIconButton(
                          function: () {
                            cubit.getPostImage();
                          },
                          icon: Icons.add_photo_alternate_outlined,
                          width: 69,
                          height: 50,
                          IconColor: Colors.blue,
                          background: Colors.white,
                          sizeIcon: 50),
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        'select from camera',
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                      const SizedBox(
                        height: 7,
                      ),
                      defaultIconButton(
                          function: () {
                            cubit.getPostImageCamera();
                          },
                          icon: Icons.camera_alt_outlined,
                          width: 69,
                          height: 50,
                          IconColor: Colors.blue,
                          background: Colors.white,
                          sizeIcon: 50),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 50,
              ),
              if (postImage != null)
                Stack(
                  children: [
                    Card(
                      child: Image(
                        image: postImage == null
                            ? const AssetImage('assets/images/logo.png')
                            : FileImage(postImage) as ImageProvider,
                      ),
                    ),
                    Positioned(
                        right: 10,
                        bottom: 10,
                        child: IconButton(
                          onPressed: () {
                            cubit.removeImage();
                          },
                          icon: const Icon(
                            Icons.delete,
                            size: 50,
                            color: Colors.blue,
                          ),
                        ))
                  ],
                ),
              if (postVideo != null)
                Stack(
                  alignment: AlignmentDirectional.topEnd,
                  children: [
                    Container(
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 20, horizontal: 20),
                        child: FlickVideoPlayer(
                          flickManager: FlickManager(
                            videoPlayerController:
                                VideoPlayerController.file(postVideo),
                            autoPlay: false,
                            autoInitialize: true,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              const SizedBox(
                height: 25,
              ),

              const Divider(),
              //product number
              Form(
                key: formkey,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // number product
                      Text('Num_Product'),
                      TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'must not be empty';
                          }
                          return null;
                        },

                        keyboardType: TextInputType.phone,
                        cursorColor: Colors.blue,
                        controller: numberController,
                        textInputAction: TextInputAction.search,
                        onFieldSubmitted: (String value) {
                          numberController.text = value;
                        },

                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          fillColor: Colors.grey,
                          focusColor: Colors.grey,
                          hintText: 'Enter unique number ',
                        ),
                        style: TextStyle(color: Colors.blue),
                      ),
                      const Text('Description'),
                      //name product
                      TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'must not be empty';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.text,
                        cursorColor: Colors.black,
                        controller: dataController,
                        textInputAction: TextInputAction.search,
                        onFieldSubmitted: (String value) {
                          dataController.text = value;
                        },
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          fillColor: Colors.grey,
                          focusColor: Colors.grey,
                          hintText: 'Enter description product ex uniqu name...',
                        ),
                        style: const TextStyle(color: Colors.blue),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      //price product
                      const Text('price'),
                      TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'must not be empty';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.phone,
                        cursorColor: Colors.black,
                        controller: priceController,
                        textInputAction: TextInputAction.search,
                        onFieldSubmitted: (String value) {
                          priceController.text = value;
                        },
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          fillColor: Colors.grey,
                          focusColor: Colors.grey,
                          hintText: 'Enter price',
                        ),
                        style: const TextStyle(color: Colors.blue),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      //date product
                      const Text('Date'),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 10, right: 10, top: 10, bottom: 20),
                        child: TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              'please Enter Date';
                            }
                            return null;
                          },
                          controller: DateController,
                          //editing controller of this TextField
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            fillColor: Colors.grey,
                            focusColor: Colors.grey,
                            hintText: 'Enter Date please',
                          ),
                          readOnly: true,
                          style: const TextStyle(color: Colors.blue),
                          //set it true, so that user will not able to edit text
                          onTap: () async {
                            DateTime? pickedDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(2022),
                                //DateTime.now() - not to allow to choose before today.
                                lastDate: DateTime(2101));

                            if (pickedDate != null) {
                              String formattedDate =
                                  DateFormat('dd-MM-yyyy').format(pickedDate);
                              setState(() {
                                DateController.text =
                                    formattedDate; //set output date to TextField value.
                              });
                            } else {
                              print("Date is not selected");
                            }
                          },
                          onFieldSubmitted: (String value) {
                            DateController.text = value;
                          },
                        ),
                      ),
                      // TextButton(onPressed: (){
                      //   print(numberController.text);
                      //   print(dataController.text);
                      //   print(priceController.text);
                      //   print(DateController.text);
                      // }, child: Text('sssssssss'))
                      const SizedBox(
                        height: 20,
                      ),
                      if (state is SocialCreatePostLoadingState)
                        const LinearProgressIndicator(),
                      const SizedBox(
                        height: 20,
                      ),
                      ConditionalBuilder(
                        condition: state is! SocialCreatePostLoadingState,
                        builder: (context) => Padding(
                          padding: const EdgeInsets.only(
                              top: 20, bottom: 10, left: 100, right: 100),
                          child: defaultButton(
                              function: () {
                                if (formkey.currentState!.validate()) {
                                  if (state
                                      is SocialPostImagePickedSuccessState) {
                                    cubit.UploadPostImage(
                                      dateTime: DateController.text,
                                      data: dataController.text,
                                      price: priceController.text,
                                      code: numberController.text,
                                    );
                                  } else if (state
                                      is SocialVIDEOPickedSuccessState) {
                                    cubit.UploadNewVideo(
                                        dateTime: DateController.text,
                                        data: dataController.text,
                                        price: priceController.text,
                                        code: numberController.text);
                                  }
                                }
                              },
                              text: 'Add_Product',
                              background: defaultColor,
                              fontfamily: 'Prompt-Bold',
                              radius: 50,
                              height: 60,
                              isUpperCase: false),
                        ),
                        fallback: (context) =>
                            const Center(child: CircularProgressIndicator()),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
