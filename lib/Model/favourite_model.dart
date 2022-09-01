import 'home_model.dart';

class FavouriteModel{
  late bool status;
  late FavouriteDataModel data;
  FavouriteModel.fromJson(Map<String,dynamic>model){
    status=model['status'];
    data=FavouriteDataModel.fromJson(model['data']);

  }
}
class FavouriteDataModel{
  List<FavouriteData>data=[];
  FavouriteDataModel.fromJson(Map<String,dynamic>model){
    model['data'].forEach((element){
      data.add(FavouriteData.fromJson(element));
    });
  }

}
class FavouriteData{
  late int id;
  late ProductModel product;

  FavouriteData.copy(ProductModel productModel,int i){
    id=i;
    product=ProductModel.copy(productModel);
  }

  FavouriteData.fromJson(Map<String,dynamic>model){
    id=model['id'];
    product=ProductModel.fromJson(model['product']);
  }
}

class FavProductModel{
  late int id;
  late dynamic price;
  late dynamic oldPrice;
  late dynamic discount;
  late String image;
  late String name;
  late String description;
  FavProductModel.fromJson(Map<String,dynamic> model){
    id=model['id'];
    image=model['image'];
    price=model['price'];
    oldPrice=model['old_price'];
    discount=model['discount'];
    name=model['name'];
    description=model['description'];
  }
}
