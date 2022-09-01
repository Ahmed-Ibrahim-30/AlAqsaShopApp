class SearchModel{
  late bool status;
  late SearchData data;

  SearchModel.fromJson(Map<String,dynamic>model){
    status=model['status'];
    data=SearchData.fromJson(model['data']);
  }
}

class SearchData{
  late List<SearchProductModel>data=[];

  SearchData.fromJson(Map<String,dynamic>model){
    model['data'].forEach((element) {
      data.add(SearchProductModel.fromJson(element));
    });
  }
}

class SearchProductModel{
  late int id;
  late dynamic price;
  late dynamic oldPrice;
  late dynamic discount;
  late String image;
  late String name;
  late String description;
  late bool inFavorites;
  late bool inCart;

  SearchProductModel.fromJson(Map<String,dynamic> model){
    id=model['id'];
    image=model['image'];
    price=model['price'];
    oldPrice=price;
    discount=0;
    name=model['name'];
    description=model['description'];
    inFavorites=model['in_favorites']??false;
    inCart=model['in_cart']??false;
  }
}