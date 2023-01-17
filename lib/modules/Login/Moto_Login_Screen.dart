import 'package:elostaaz/shared/components/components.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:elostaaz/shared/network/cacheHelper.dart';

import '../Admin/EditProducts.dart';
import '../Admin/layout/AdminMotoLayoutScreen.dart';
import '../Register/Moto_Register_Screen.dart';

class FristLogin extends StatefulWidget {
  const FristLogin({Key? key}) : super(key: key);
  static String id = 'FristLogin';

  @override
  State<FristLogin> createState() => _FristLoginState();
}

class _FristLoginState extends State<FristLogin> {
  bool obscureText = true;
  Icon fab = Icon(
    Icons.remove_red_eye_outlined,
  );
  String? email;

  String? password;
  bool isLoading = false;
  int fabIconNumber = 0;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/logo.png'),
            fit: BoxFit.fill,
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.blueAccent,
            onPressed: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                backgroundColor: Colors.transparent,
                builder: (context) => buildBottom(context),
              );
            },
            tooltip: 'Increment',
            child: const Icon(Icons.add),
          ), // This trailing comma makes auto-formatting nicer for build methods.
        ),
      ),
    );
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
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 60.0),
                child: ListView(
                  children: [
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 20.0),
                          child: Text(
                            "Sing in with your email and password",
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(fontSize: 20,color: Colors.white),
                          ),
                        ),
                        TextFormField(
                          controller: emailController,
                          validator: (String? value) {
                            if (value!.isEmpty || !value.contains('@')) {
                              return 'please enter a valid email';
                            }
                            return null;
                          },
                          onChanged: (data) {
                            email = data;
                          },
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                              prefixIcon: Icon(Icons.email_outlined),
                              hintText: 'Email',
                              hintStyle: TextStyle(fontFamily: 'ChivoMono'),
                              fillColor: HexColor('#d2b48c'),
                              filled: true,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              )),
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        TextFormField(
                          controller: passwordController,
                          obscureText: obscureText,
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return 'please enter your password';
                            } else if (value.length < 5) {
                              return 'please enter strong password';
                            }

                            return null;
                          },
                          onChanged: (data) {
                            password = data;
                          },
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.lock_outline),
                            suffixIcon: IconButton(
                              onPressed: () {
                                obscureText = !obscureText;
                                setState(() {
                                  if (fabIconNumber == 0) {
                                    fab = Icon(
                                      Icons.remove_red_eye_outlined,
                                    );
                                    fabIconNumber = 1;
                                  } else {
                                    fab = Icon(Icons.visibility_off_outlined);
                                    fabIconNumber = 0;
                                  }
                                });
                              },
                              icon: fab,
                            ),
                            hintText: 'Password',
                            hintStyle: TextStyle(fontFamily: 'ChivoMono'),
                            fillColor: HexColor('#d2b48c'),
                            filled: true,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 40.0,
                        ),
                        //loginButton

                        InkWell(
                          child: Container(
                            height: 65,
                            width: 200,
                            decoration: BoxDecoration(
                              color: HexColor('#3A434D'),
                              borderRadius: BorderRadius.circular(50.0),
                            ),
                            child: Center(
                              child: Text(
                                'Login',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(color: Colors.white),
                              ),
                            ),
                          ),
                          onTap: () async {
                            if (formKey.currentState!.validate()) {
                              isLoading = true;
                              setState(() {});
                              try {
                                await loginUser();
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                    content: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(top: 50,bottom: 10),
                                          child: Image(image: AssetImage('assets/images/ok.gif'),),
                                        ),
                                        Text('Welcome Back Mr Mohamed Fathy',style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                            color: Colors.green
                                        ),),
                                      ],
                                    )));
                                cacheHelper.saveData(key: 'uId', value: user!.user!.uid);
                                //    navigator to anthorScreen
                                navigateAndFinish(context, const AdminMotoLayout());
                              } on FirebaseAuthException catch (e) {
                                if (e.code == 'user-not-found') {

                                  ScaffoldMessenger.of(context).showSnackBar(

                                      SnackBar(
                                          backgroundColor: Colors.white,
                                          content: Column(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(top: 150, bottom: 30),
                                                child: Image(image: AssetImage('assets/images/faild.gif'),),
                                              ),
                                              Text('user-not-found ', style: Theme
                                                  .of(context)
                                                  .textTheme
                                                  .bodyText1!
                                                  .copyWith(
                                                color: Colors.red,
                                                fontSize: 30,
                                              ),),
                                            ],
                                          )));
                                } else if (e.code == 'wrong-password') {

                                  ScaffoldMessenger.of(context).showSnackBar(

                                      SnackBar(
                                          duration: Duration(seconds: 6),
                                          backgroundColor: Colors.white,
                                          content: Column(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(top: 50, bottom: 30),
                                                child: Image(image: AssetImage('assets/images/faild.gif'),),
                                              ),
                                              Text('wrong-password ', style: Theme
                                                  .of(context)
                                                  .textTheme
                                                  .bodyText1!
                                                  .copyWith(
                                                color: Colors.red,
                                                fontSize: 30,
                                              ),),
                                            ],
                                          )));
                                }
                              }
                              isLoading = false;
                              setState(() {});
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
  UserCredential? user;
  Future<void> loginUser() async {
     user =
        await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: '$email',
      password: '$password',
    );
    print(user!.user!.email);
  }
}
