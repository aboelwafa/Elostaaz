import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shared/components/components.dart';
import '../Login/Moto_Login_Screen.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

class SocialRegisterScreen extends StatelessWidget {
  var formkey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SocialRegisterCubit(),
      child: BlocConsumer<SocialRegisterCubit, SocialRegisterStates>(
        listener: (context, state) {
          if (state is SocialCreateUserSucessStates) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 100, bottom: 30),
                  child: Image(
                    image: AssetImage('assets/images/ok.gif'),
                  ),
                ),
                Text(
                  'creat User Success now can you login',
                  style: TextStyle(
                      color: Colors.green,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ],
            )));
            nameController.clear();
            emailController.clear();
            passwordController.clear();
            phoneController.clear();
            navigateAndFinish(context, FristLogin());
          } else if (state is SocialRegisterErrorStates) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 50, bottom: 10),
                  child: Image(
                    image: AssetImage('assets/images/faild.gif'),
                  ),
                ),
                Text(
                  'Verify that the data entered has not been used before. Enter a new email',
                  style: TextStyle(fontSize: 20, color: Colors.red),
                ),
              ],
            )));
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formkey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Text(
                            'Register',
                            style: Theme.of(context)
                                .textTheme
                                .headline4!
                                .copyWith(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.w600),
                          ),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Text('Register now To Add and edit your App',
                            style: Theme.of(context).textTheme.bodyText1!),
                        SizedBox(
                          height: 30.0,
                        ),
                        DefaultFormField(
                          controller: nameController,
                          type: TextInputType.name,
                          label: 'User Name',
                          prefix: Icons.person,
                          validate: (value) {
                            if (value!.isEmpty) {
                              return ' pleasr Enter your Name ';
                            }
                          },
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        DefaultFormField(
                          controller: emailController,
                          type: TextInputType.emailAddress,
                          label: 'Email',
                          prefix: Icons.email,
                          validate: (value) {
                            if (value!.isEmpty) {
                              return ' pleasr Enter your Email ';
                            }
                          },
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        DefaultFormField(
                          controller: passwordController,
                          type: TextInputType.visiblePassword,
                          label: 'Password',
                          prefix: Icons.lock,
                          suffix: SocialRegisterCubit.get(context).suffix,
                          SuffixPress: () {
                            SocialRegisterCubit.get(context).changepassword();
                          },
                          onSubmit: (value) {},
                          validate: (value) {
                            if (value!.isEmpty) {
                              return ' pleasr Enter your Password ';
                            }
                          },
                          IsPassword:
                              SocialRegisterCubit.get(context).ispassword,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        DefaultFormField(
                          controller: phoneController,
                          type: TextInputType.phone,
                          label: 'Phone',
                          prefix: Icons.phone,
                          validate: (value) {
                            if (value!.isEmpty) {
                              return ' pleasr Enter your Phone ';
                            }
                          },
                        ),
                        SizedBox(
                          height: 40.0,
                        ),
                        ConditionalBuilder(
                          condition: state is! SocialRegisterLoadingStates,
                          builder: (context) => Center(
                            child: defaultButton(
                                width: 250.0,
                                height: 50.0,
                                radius: 40.0,
                                function: () {
                                  if (formkey.currentState!.validate()) {
                                    SocialRegisterCubit.get(context)
                                        .userRegister(
                                      name: nameController.text,
                                      email: emailController.text,
                                      password: passwordController.text,
                                      phone: phoneController.text,
                                    );
                                  }
                                },
                                text: 'register'),
                          ),
                          fallback: (context) =>
                              Center(child: CircularProgressIndicator()),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Row(
                          children: [
                            Text('Already have an account?'),
                            TextButton(
                                onPressed: () {
                                  navigateTo(context, FristLogin());
                                },
                                child: Text(
                                  'Login',
                                  style: TextStyle(fontSize: 18.0),
                                )),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
