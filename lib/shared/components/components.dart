// ignore_for_file: sort_child_properties_last, prefer_const_constructors, non_constant_identifier_names, avoid_types_as_parameter_names

import 'package:flutter/material.dart';

void navigateTo(context,Widget)=> Navigator.push(
  context,
  MaterialPageRoute(builder: (context) => Widget,
  ),
);
void navigatePop(context,Widget)=> Navigator.pop(
  context,
  MaterialPageRoute(builder: (context) => Widget,
  ),
);

// component to go name widget screen and not back
void navigateAndFinish
    (context,Widget)=>
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => Widget,
      ),
          (route) {
        return false;
      },
    );

    // defaultButton
Widget defaultButton({
  double width=double.infinity,
    Color background =Colors.blue,
  required void Function()? function, // Good
  required String text,
   String? fontfamily,
  double height=35.0,
  bool isUpperCase=true,
  double radius=10.0,
})=>
    Container(
      width: width,
      height: height,
      child: MaterialButton(
        onPressed:function,
        child:
        Text(
          isUpperCase?text.toUpperCase():text,
          style: TextStyle(
            color: Colors.white,
            fontSize: 20.0,
              fontFamily: fontfamily
          ),),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        color:background,


      ),

    );

//default IconButton
Widget defaultIconButton({
  double width=double.minPositive,
  Color background =Colors.blue,
  required void Function()? function, // Good
  required IconData icon,
  String? fontfamily,
  double height=35.0,
  double? sizeIcon,
  bool isUpperCase=true,
  double radius=10.0,
  Color? IconColor,
})=>
    Container(
      width: width,
      height: height,
      child: MaterialButton(
        onPressed:function,
        child:Icon(icon,size: sizeIcon,color: IconColor,),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        color:background,


      ),

    );

Widget defaultText(context
,{
 required String text,
})=>Text(text,style: Theme.of(context).textTheme.bodyText1,);
//
Widget DefaultFormField({
  required TextEditingController controller,
  String? Function(String?)? onSubmit,
  String? Function(String?)? onChanged,
  required String? Function(String?)? validate,
  required TextInputType type,
  required String label,
  required IconData prefix,
  IconData? suffix,
  Function()? SuffixPress,
  bool IsPassword=false,
  Color suffixIconColor=Colors.blue,
})=>

    TextFormField(
      controller: controller,
      onFieldSubmitted:onSubmit,
      onChanged: onChanged,
      validator: validate,
      keyboardType: type,
      obscureText: IsPassword,
      decoration: InputDecoration(
        // enabledBorder: OutlineInputBorder(
        //   borderSide: BorderSide(
        //     width: 5.0,
        //     color: Colors.teal
        //   ),
        // ),
        suffixIconColor: suffixIconColor,
        labelText: label ,
        prefixIcon: Icon(prefix),
        suffixIcon: suffix!=null? IconButton(
          onPressed: SuffixPress,
          icon: Icon(
              Icons.remove_red_eye),
        )
            :null,
        border: OutlineInputBorder(),
        fillColor: Colors.grey[500],
        filled: true,
        labelStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        )
      ),
    );

// defaultButton
// Widget defaultButton({
//   double width=double.infinity,
//   Color background =Colors.blue,
//   required void Function()? function, // Good
//   required String text,
//   double height=35.0,
//   bool isUpperCase=true,
//   double radius=10.0,
// })=>
//     Container(
//       width: width,
//       height: height,
//       child: MaterialButton(
//         onPressed:function,
//         child:
//         Text(
//           isUpperCase?text.toUpperCase():text,
//           style: TextStyle(
//             color: Colors.white,
//           ),),
//       ),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(radius),
//         color:background,
//
//
//       ),
//
//     );

Widget defaultFormField({
  required TextEditingController controller,
  String? Function(String?)? onSubmit,
  String? Function(String?)? onChanged,
  required String? Function(String?)? validate,
  required TextInputType type,
  required String label,
  IconData? prefix,
  IconData? suffix,
  bool IsPassword=false,
  Color suffixIconColor=Colors.blue,
  Color fill=Colors.grey,
  String?hintText,
  Color labelText=Colors.blue
})=>

    TextFormField(

      textDirection: TextDirection.ltr,
      controller: controller,
      onFieldSubmitted:onSubmit,
      onChanged: onChanged,
      validator: validate,
      keyboardType: type,
      obscureText: IsPassword,
      decoration: InputDecoration(
        filled: true,
        fillColor:fill,
        hintText:hintText,
        labelStyle: TextStyle(
          color: labelText,
          fontSize: 25,
          fontWeight: FontWeight.bold,
        ),
        suffixIconColor: suffixIconColor,
        labelText: label ,
        suffixIcon: Icon(suffix),

        border: OutlineInputBorder(),
      ),
      maxLines: 4,
      minLines: 1,
    );
