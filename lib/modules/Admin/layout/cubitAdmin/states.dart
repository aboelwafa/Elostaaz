abstract class AdminMotoStates{}

class AdminMotoInitialStates extends AdminMotoStates{}
class AdminMotoLoadingStates extends AdminMotoStates{}
class AdminMotoSuccessStates extends AdminMotoStates{}
class AdminMotoErrorStates extends AdminMotoStates{}

//change bottom nav bar
class AdminMotoChangeNavBarItemStates extends AdminMotoStates{}

//state get user data
class AdminMotoGetUserDataLoadingStates extends AdminMotoStates{}
class AdminMotoGetUserDataSuccessStates extends AdminMotoStates{}
class AdminMotoGetUserDataErrorStates extends AdminMotoStates{}

//state for createProduct
class AdminMotoCreateProductLoadingStates extends AdminMotoStates{}
class AdminMotoCreateProductSuccessStates extends AdminMotoStates{}
class AdminMotoCreateProductErrorStates extends AdminMotoStates{}

//state for image

class AdminMotoCreateImageProductLoadingStates extends AdminMotoStates{}
class AdminMotoCreateImageProductSuccessStates extends AdminMotoStates{}
class AdminMotoCreateImageProductErrorStates extends AdminMotoStates{}

class AdminMotoRemoveImageProductErrorStates extends AdminMotoStates{}

//state for getProduct
class AdminMotoGetProductLoadingStates extends AdminMotoStates{}
class AdminMotoGetProductSuccessStates extends AdminMotoStates{}
class AdminMotoGetProductErrorStates extends AdminMotoStates{}
//state for like product
class AdminMotoProductLikeLoadingState extends AdminMotoStates{}
class AdminMotoProductLikeSuccessState extends AdminMotoStates{}
class AdminMotoProductLikeErrorState extends AdminMotoStates{}

//pagePost

//state for imagePost

class AdminMotoCreateImagePostLoadingStates extends AdminMotoStates{}
class AdminMotoCreateImagePostSuccessStates extends AdminMotoStates{}
class AdminMotoCreateImagePostErrorStates extends AdminMotoStates{}

//state for createPost
class AdminMotoCreatePostLoadingStates extends AdminMotoStates{}
class AdminMotoCreatePostSuccessStates extends AdminMotoStates{}
class AdminMotoCreatePostErrorStates extends AdminMotoStates{}

//state for getPosts
class AdminMotoGetPostsLoadingStates extends AdminMotoStates{}
class AdminMotoGetPostsSuccessStates extends AdminMotoStates{}
class AdminMotoGetPostsErrorStates extends AdminMotoStates{}

//state for updatePosts




//image admin
class AdminMotoCreateImageProfileSuccessStates extends AdminMotoStates{}
class AdminMotoCreateImageProfileErrorStates extends AdminMotoStates{}

//post image
class SocialPostImagePickedSuccessState extends AdminMotoStates{}
class SocialPostImagePickedErrorState extends AdminMotoStates{}
class SocialRemovePostImageSuccessState extends AdminMotoStates{}

//uploadPostimage

class SocialCreatePostLoadingState extends AdminMotoStates{}
class SocialCreatePostSuccessState extends AdminMotoStates{}
class SocialCreatePostErrorState extends AdminMotoStates{}

//upload video
class SocialVIDEOPickedSuccessState extends AdminMotoStates{}
class SocialVIDEOPickedErrorState extends AdminMotoStates{}
//uploadPostvideo
class SocialUploadVideoLoadingState extends AdminMotoStates{}

class SocialUploadVideoSuccessState extends AdminMotoStates{}
class SocialUploadVideoErrorState extends AdminMotoStates{}

//getpost
class GetPostLoadingState extends AdminMotoStates{}
class GetPostSuccessState extends AdminMotoStates{}
class GetPostErrorState extends AdminMotoStates{}

//update product
class UpdatePostsLoadingStates extends AdminMotoStates{}
class UpdatePostsSuccessStates extends AdminMotoStates{}
class UpdatePostsErrorStates extends AdminMotoStates{}

//get product details
class GetProductDetailsSuccessStates extends AdminMotoStates{}

class SocialUpdateUserLoadingState extends  AdminMotoStates{}
class SocialUploadProfileImageErrorState extends  AdminMotoStates{}
//delete product by id
class deleteProductSuccessState extends  AdminMotoStates{}
class deleteProductErrorState extends  AdminMotoStates{}
//singout
class SingoutAdminSuccessState extends  AdminMotoStates{}
class SingoutAdminErrorState extends  AdminMotoStates{}
