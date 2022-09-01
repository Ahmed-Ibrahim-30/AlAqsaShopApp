class CategoriesModel{
  late bool status;
  late CategoriesData data;

  CategoriesModel.fromJson(Map<String,dynamic>model){
    status=model['status'];
    data=CategoriesData.fromJson(model['data']);
  }
}

class CategoriesData{
  late List<Data>data=[];

  CategoriesData.fromJson(Map<String,dynamic>model){
    model['data'].forEach((element) {
      data.add(Data.fromJson(element));
    });
  }
}
class Data{
  late int id;
  late String name;
  late String image;
  Data.fromJson(Map<String,dynamic>model){
    id=model['id'];
    name=model['name'];
    image=model['image'];
  }
}