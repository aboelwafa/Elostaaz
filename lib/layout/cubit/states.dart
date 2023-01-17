abstract class MotoStates{}

class MotoInitialStates extends MotoStates{}
class MotoLoadingStates extends MotoStates{}
class MotoSuccessStates extends MotoStates{}
class MotoErrorStates extends MotoStates{}

//change bottom nav bar
class MotoChangeNavBarItemStates extends MotoStates{}


//getpost
class GetPostLoadingState extends MotoStates{}
class GetPostSuccessState extends MotoStates{}
class GetPostErrorState extends MotoStates{}
//get product details
class GetProductDetailsSuccessStates extends MotoStates{}

//delete product
class deleteProductSuccessState extends  MotoStates{}
class deleteProductErrorState extends  MotoStates{}

// create user request
class CreateRequestUserLoadingState extends  MotoStates{}
class CreateRequestUserSuccessState extends  MotoStates{}
class CreateRequestUserErrorState extends  MotoStates{}

