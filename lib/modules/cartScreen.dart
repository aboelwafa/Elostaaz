import 'dart:io';

import 'package:elostaaz/modules/Admin/DetailsProducts.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_player/video_player.dart';
import '../../models/ProductModel.dart';
import '../../shared/components/components.dart';
import '../../shared/network/Style/colors.dart';
import '../layout/cubit/cubit.dart';
import '../layout/cubit/states.dart';
import 'Admin/layout/cubitAdmin/cubit.dart';
import 'Admin/layout/cubitAdmin/states.dart';

class CartScreen extends StatelessWidget {
  PostModel? postModel;

  CartScreen({Key? key, required this.postModel}) : super(key: key);

  var nameController = TextEditingController();

  var phoneController = TextEditingController();

  var formkey = GlobalKey<FormState>();

  String? name;
  String? phone;

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      MotoCubit.get(context).getDetailClient(data: '${postModel?.data}');
      return BlocConsumer<MotoCubit, MotoStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = MotoCubit.get(context);
          // listen coverImage
          return Scaffold(
            appBar: AppBar(
              title: Text('products'),
              actions: [
                // IconButton(
                //     onPressed: () {
                //       AdminMotoCubit.get(context).deleteProduct(no: '${postModel?.no}');
                //     },
                //     icon: Icon(
                //       Icons.delete_forever,
                //       size: 32,
                //       color: Colors.red,
                //     ))
              ],
            ),
            body: Column(
              children: [
                ListView(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.only(
                        top: 5.0,
                      ),
                      child: Container(
                        height: 400.0,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            image: DecorationImage(
                                image: NetworkImage('${postModel?.postImage}'),
                                fit: BoxFit.fill)),
                      ),
                    ),

                    const SizedBox(
                      height: 25,
                    ),

                    const Divider(),
                    //product number
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //number product
                          Row(
                            children: [
                              Text('code:'),
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Text(
                                  '${postModel?.code}',
                                  style: Theme.of(context).textTheme.bodyText1,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text('Product_Name:'),
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Text(
                                  '${postModel?.data}',
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
                                child: Text(
                                  '${postModel?.price}',
                                  style: Theme.of(context).textTheme.bodyText1,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Icon(
                                  Icons.paid_outlined,
                                  size: 25,
                                  color: Colors.green,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text('Date:'),
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Text(
                                  '${postModel?.dateTime}',
                                  style: Theme.of(context).textTheme.bodyText1,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Spacer(),

                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0,left: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          'To buy the order, please contact us on WhatsApp',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText2!
                              .copyWith(fontSize: 16),
                        ),
                      ),
                      Expanded(

                        child: IconButton(
                            onPressed: () {
                              launchWhatsapp();
                            },
                            icon: const Icon(
                              Icons.whatsapp,
                              size: 45,
                              color: Colors.green,
                            )),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      );
    });
  }

  Widget buildBottom(context) => Container(
        height: MediaQuery.of(context).size.height * 0.49,
        decoration: const BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25.0),
            topRight: Radius.circular(25.0),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(
            top: 10,
            left: 35.0,
            right: 35.0,
          ),
          child: Center(
            child: Form(
              key: formkey,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 60.0),
                child: ListView(
                  children: [
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10.0),
                          child: Text(
                            "write personal information",
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(fontSize: 20, color: Colors.white),
                          ),
                        ),
                        TextFormField(
                          controller: nameController,
                          validator: (String? value) {
                            String patttern = r'(^[a-zA-Z ا-ي]*$)';
                            RegExp regExp = RegExp(patttern);
                            if (value!.isEmpty) {
                              return 'يرجي ادخال الاسم ';
                            } else if (!regExp.hasMatch(value)) {
                              return "يجب ان يحتوي الاسم على حروف فقط";
                            } else if (value.length < 5) {
                              return 'يرجي ادخال اسمك بالكامل';
                            }
                            return null;
                          },
                          onChanged: (data) {
                            name = data;
                          },
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                              prefixIcon: Icon(Icons.person),
                              hintText: 'Name',
                              errorStyle: TextStyle(fontSize: 20),
                              hintStyle: TextStyle(fontFamily: 'ChivoMono'),
                              fillColor: HexColor('#d2b48c'),
                              filled: true,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              )),
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        TextFormField(
                          controller: phoneController,
                          validator: (String? value) {
                            String patttern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
                            RegExp regExp = RegExp(patttern);
                            if (value!.isEmpty) {
                              return 'يرجي ادخال رقم هاتفك';
                            } else if (!regExp.hasMatch(value)) {
                              return 'رقم الهاتف غير صحيح';
                            }
                            return null;
                          },
                          onChanged: (data) {
                            phone = data;
                          },
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.phone_android),
                              hintText: '011******39',
                              hintStyle:
                                  const TextStyle(fontFamily: 'ChivoMono'),
                              errorStyle: TextStyle(fontSize: 20),
                              fillColor: HexColor('#d2b48c'),
                              filled: true,
                              helperText: 'ادخل رقم هاتفك لتاكيد الطلب',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              )),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        //loginButton

                        InkWell(
                          child: Container(
                            height: 65,
                            width: 200,
                            decoration: BoxDecoration(
                              color: defaultColor,
                              borderRadius: BorderRadius.circular(50.0),
                            ),
                            child: Center(
                              child: Text(
                                'confirm',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2!
                                    .copyWith(color: Colors.white),
                              ),
                            ),
                          ),
                          onTap: () async {
                            if (formkey.currentState!.validate()) {
                              String cdate = DateFormat("yyyy-MM-dd")
                                  .format(DateTime.now());
                            }
                          },
                        ),
                        SizedBox(
                          height: 190.0,
                        ),
                        // Row(
                        //   children: [
                        //     Text(
                        //       'Sing In',
                        //       style: Theme.of(context)
                        //           .textTheme
                        //           .bodyLarge!
                        //           .copyWith(
                        //               color: HexColor('#3A434D'),
                        //               fontSize: 20.0,
                        //               fontFamily: 'ChivoMono'),
                        //     ),
                        //     Spacer(),
                        //     CircleAvatar(
                        //       radius: 30.0,
                        //       backgroundColor: HexColor('#3A434D'),
                        //       child: IconButton(
                        //         onPressed: () {
                        //           navigateTo(context, SocialRegisterScreen());
                        //         },
                        //         icon: Icon(
                        //           Icons.arrow_forward_rounded,
                        //           color: Colors.blue,
                        //         ),
                        //       ),
                        //     ),
                        //   ],
                        // )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      );

  launchWhatsapp() {
    String whatsapp = '+201114868868';
    String whatsappURlAndroid = "whatsapp://send?phone=$whatsapp&text=hello";

    launchUrl(Uri.parse(whatsappURlAndroid));
  }
}
