// ignore_for_file: unused_local_variable

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:url_launcher/url_launcher.dart';

class InformationApp extends StatefulWidget {
  const InformationApp({Key? key}) : super(key: key);

  @override
  State<InformationApp> createState() => _InformationAppState();
}

class _InformationAppState extends State<InformationApp> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Center(
                child: CircleAvatar(
                  radius: 64,
                  child: CircleAvatar(
                    radius: 60.0,
                    backgroundImage: AssetImage('assets/images/logo.png'),
                  ),
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Center(
                  child: Text(
                    ' Elostaaz',
                    style: Theme
                        .of(context)
                        .textTheme
                        .bodyText2!
                        .copyWith(
                      fontWeight: FontWeight.w700,
                      fontSize: 25.0,
                    ),
                  )),
              SizedBox(
                height: 25.0,
              ),
              Padding(
                padding:
                const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    CircleAvatar(
                      radius: 30.0,
                      backgroundImage: AssetImage('assets/images/logo.png'),
                    ),
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 50),
                            child: Text(
                              '  Mohamed Fathy',
                              style: Theme
                                  .of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                          Text(
                              'The Elostaaz Store provides all spare parts and accessories for motorcycles To order anything, please contact the following number',
                              style: Theme
                                  .of(context)
                                  .textTheme
                                  .bodyText2!
                                  .copyWith(fontSize: 18)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 15.0,
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Text(
                        '  phone number::',
                        style: Theme
                            .of(context)
                            .textTheme
                            .bodyText1!
                            .copyWith(
                            fontSize: 20, fontWeight: FontWeight.w700),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        right: 20,
                      ),
                      child: Text(
                        ' +201114868868 ',
                        style: Theme
                            .of(context)
                            .textTheme
                            .bodyText1!
                            .copyWith(
                            fontSize: 20, fontWeight: FontWeight.w700),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text('whatsApp',style: Theme.of(context).textTheme.bodyText1),
                    IconButton(
                        onPressed: () {
                          launchWhatsapp();
                        },
                        icon: const Icon(
                          Icons.whatsapp,
                          size: 45,
                          color: Colors.green,
                        )),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text('call',style: Theme.of(context).textTheme.bodyText1,),
                    IconButton(
                        onPressed: () {
                          callNumber();
                        },
                        icon: Icon(
                          Icons.call,
                          size: 45,
                          color: Colors.blue,
                        )),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // openWhatsApp() async {
  //   var whatsapp = '+201114868868';
  //   var whatsUrl_android = 'whatsapp://send?phone=' + whatsapp + "&text=hello";
  //   var whatsUrl_ios = 'https://wa.me/$whatsapp?text=${Uri.parse('hello')}';
  //
  //   if (Platform.isIOS) {
  //     if (await canLaunch(whatsUrl_ios)) {
  //       await launch(whatsUrl_ios);
  //     }
  //     else {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //           SnackBar(content: const Text('whatsapp not installed')));
  //     }
  //   }
  //   else {
  //     if (await canLaunch(whatsUrl_android)) {
  //       await launch(whatsUrl_android);
  //     }
  //     else {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //           SnackBar(content: const Text('whatsapp not installed')));
  //     }
  //   }
  // }
  //
  // openWhatsapp() async {
  //   String whatsapp = '+201114868868';
  //   String whatsappURlAndroid = "whatsapp://send?phone=$whatsapp&text=hello";
  //   String whatsappURLIos =
  //       "https://wa.me/$whatsapp?text=${Uri.parse("hello")}";
  //   if (Platform.isIOS) {
  //     if (await canLaunchUrl(Uri.parse(whatsappURLIos))) {
  //       await launchUrl(Uri.parse(whatsappURLIos));
  //     } else {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //           SnackBar(content: const Text('whatsapp not installed')));
  //     }
  //   } else {
  //     if (await canLaunchUrl(Uri.parse(whatsappURlAndroid))) {
  //       await launchUrl(Uri.parse(whatsappURlAndroid));
  //     } else {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //           SnackBar(content: const Text('whatsapp not installed')));
  //     }
  //   }
  // }

  launchWhatsapp() {
    String whatsapp = '+201114868868';
    String whatsappURlAndroid = "whatsapp://send?phone=$whatsapp&text=hello";

    launchUrl(Uri.parse(whatsappURlAndroid));
  }
  callNumber() async {
    const number = '+201114868868';
    bool? res = await FlutterPhoneDirectCaller.callNumber(number);
  }
}
