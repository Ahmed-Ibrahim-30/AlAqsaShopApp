class HomeModel{
  late bool status;
  late DataModel data;

  HomeModel.fromJson(Map<String,dynamic> model){
    status=model['status'];
    data=DataModel.fromJson(model['data']);
  }
}

class DataModel{
  List<BannerModel>banners=[];
  List<ProductModel>products=[];

  DataModel.fromJson(Map<String,dynamic> model){

    model['banners'].forEach((element) {
      banners.add(BannerModel.fromJson(element));
    });

    model['products'].forEach((element) {
      products.add(ProductModel.fromJson(element));
    });
  }
}

class BannerModel{
  late int id;
  late String image;
  BannerModel.fromJson(Map<String,dynamic> model){
    id=model['id'];
    image=model['image'];
  }
}

class ProductModel{
  late int id;
  late dynamic price;
  late dynamic oldPrice;
  late dynamic discount;
  late String image;
  late String name;
  late String description;
  late bool inFavorites;
  late bool inCart;

  ProductModel.copy(ProductModel productModel){
    id=productModel.id;
    image=productModel.image;
    price=productModel.price;
    oldPrice=productModel.oldPrice;
    discount=productModel.discount;
    name=productModel.name;
    description=productModel.description;
    inFavorites=productModel.inFavorites;
    inCart=productModel.inCart;
  }
  ProductModel.fromJson(Map<String,dynamic> model){
    id=model['id'];
    image=model['image'];
    price=model['price'];
    oldPrice=model['old_price'];
    discount=model['discount'];
    name=model['name'];
    description=model['description'];
    inFavorites=model['in_favorites']??false;
    inCart=model['in_cart']??false;
  }
}