
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../models/ProductModel.dart';
import '../../shared/components/components.dart';
import '../../shared/network/Style/colors.dart';
import 'layout/cubitAdmin/cubit.dart';
import 'layout/cubitAdmin/states.dart';

class EditProduct extends StatelessWidget {
  PostModel? postModel;

  EditProduct({Key? key, required this.postModel}) : super(key: key);

  var dataController = TextEditingController();

  var numberController = TextEditingController();

  var priceController = TextEditingController();

  var DateController = TextEditingController();

  var formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      AdminMotoCubit.get(context).getDetailClient(code: '${postModel?.code}');
      return BlocConsumer<AdminMotoCubit, AdminMotoStates>(
        listener: (context, state) {
          if (state is UpdatePostsSuccessStates) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                backgroundColor: Colors.white,
                content: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 150, bottom: 10),
                      child: Image(
                        image: AssetImage('assets/images/ok.gif'),
                      ),
                    ),
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 25),
                      child: Text(
                        'Data has been modified to succeed. Thank you ',
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                              color: Colors.green,
                              fontSize: 30,
                            ),
                      ),
                    ),
                  ],
                )));
            Navigator.pop(context);
          }
          if(state is deleteProductSuccessState) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                backgroundColor: Colors.white,
                content: Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(top: 150, bottom: 10),
                      child: Image(
                        image: AssetImage('assets/images/delete.gif'),
                      ),
                    ),
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 50),
                      child: Text(
                        'Delete Product Successfully ',
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          color: Colors.green,
                          fontSize: 28,
                        ),
                      ),
                    ),
                  ],
                )));

            Navigator.pop(context);
            AdminMotoCubit.get(context).getProducts();
          }

          },
        builder: (context, state) {
          numberController.text = '${postModel?.code}';
          dataController.text = '${postModel?.data}';
          priceController.text = '${postModel?.price}';
          DateController.text='${postModel?.dateTime}';

          var cubit = AdminMotoCubit.get(context);
          var postImage = AdminMotoCubit.get(context).postImage;
          var mi = AdminMotoCubit.get(context).PRODUCT;
          // listen coverImage
          return Scaffold(
            appBar: AppBar(
              title: const Text('EditProdcut'),
              actions: [
                IconButton(
                    onPressed: () {
                      AdminMotoCubit.get(context).deleteProduct(code: '${postModel?.code}');
                    },
                    icon: const Icon(
                      Icons.delete_forever,
                      size: 32,
                      color: Colors.red,
                    ))
              ],
            ),
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
                        Text('select from camera', style: Theme
                            .of(context)
                            .textTheme
                            .bodyText1,),
                        const SizedBox(height: 7,),
                        defaultIconButton(
                            function: () {
                              cubit.getPostImageCamera();
                            },
                            icon: Icons.camera_alt_outlined,
                            width: 69,
                            height: 50,
                            IconColor: Colors.blue,
                            background: Colors.white,
                            sizeIcon: 50
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 50,
                ),
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
                            image: postImage == null
                                ? NetworkImage('${postModel?.postImage}')
                                : FileImage(postImage) as ImageProvider,
                            fit: BoxFit.fill)),
                  ),
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
                        //number product
                        const Text('Num_Product'),
                        TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'must codet be empty';
                            }
                            return null;
                          },
                          keyboardType: TextInputType.number,
                          cursorColor: Colors.black,
                          controller: numberController,
                          textInputAction: TextInputAction.search,
                          onFieldSubmitted: (String value) {
                            numberController.text = value;
                          },
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            fillColor: Colors.grey,
                            focusColor: Colors.grey,
                            hintText: 'Enter description product ex name...',
                          ),
                          style: const TextStyle(color: Colors.blue),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Text('Description'),
                        //name product
                        TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'must codet be empty';
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
                            hintText: 'Enter description product ex name...',
                          ),
                          style: TextStyle(color: Colors.blue),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        //price product
                        Text('price'),
                        TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'must codet be empty';
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
                        if (state is UpdatePostsLoadingStates)
                          const LinearProgressIndicator(),
                        const SizedBox(
                          height: 20,
                        ),

                        if (state is SocialPostImagePickedSuccessState)
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 20, bottom: 10, left: 100, right: 100),
                            child: defaultButton(
                                function: () {
                                  String cdate =
                                  DateFormat("yyyy-MM-dd").format(DateTime.now());
                                  cubit.UploadProductImage(
                                      price: priceController.text,
                                      data: dataController.text,
                                      dateTime: cdate,
                                      code: numberController.text);
                                },
                                text: 'update',
                                background: defaultColor,
                                fontfamily: 'Prompt-Bold',
                                radius: 50,
                                height: 60,
                                isUpperCase: false),
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
    });
  }
}
