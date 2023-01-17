class PostModel
{

  String? data;
  String? price;
  String? code;
  String? dateTime;
  String? postImage;
  String? postVideo;

  PostModel({

    this.code,
    this.price,
    this.data,
    this.dateTime,
    this.postImage,
     this.postVideo
  });

  PostModel.fromJson(Map<String,dynamic>?json)
  {
    code= json?['code'];
    price= json?['price'];
    data= json?['data'];
    dateTime= json?['dataTime'];
    postImage= json?['PostImage'];
    postVideo= json?['postVideo'];




  }
  Map <String,dynamic> toMap(){
    return
      {
        'code':code,
        'data':data,
        'price':price,
        'dataTime':dateTime,
        'PostImage':postImage,
        'postVideo':postVideo,



      };
  }
}

// class PostModel
// {
//   String? name;
//   String? phone;
//   String? data;
//   String? price;
//   String? code;
//   String? dateTime;
//   String? postImage;
//   String? postVideo;
//
//   PostModel({
//     this.name,
//     this.phone,
//     this.code,
//     this.price,
//     this.data,
//     this.dateTime,
//     this.postImage,
//     this.postVideo
//   });
//
//   PostModel.fromJson(Map<String,dynamic>?json)
//   {
//     name= json?['name'];
//     phone= json?['phone'];
//     price= json?['price'];
//     data= json?['data'];
//     price= json?['price'];
//     dateTime= json?['dataTime'];
//     postImage= json?['PostImage'];
//     postVideo= json?['postVideo'];
//
//
//
//
//   }
//   Map <String,dynamic> toMap(){
//     return
//       {
//         'name':name,
//         'phone':phone,
//         'code':code,
//         'data':data,
//         'price':price,
//         'dataTime':dateTime,
//         'PostImage':postImage,
//         'postVideo':postVideo,
//
//
//
//       };
//   }
// }