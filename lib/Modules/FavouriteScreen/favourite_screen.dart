import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../Components/variableShared.dart';
import '../../Components/widget_shared.dart';
import '../../Model/home_model.dart';
import '../../Cubit/Shop/shop_cubit.dart';
import '../../Cubit/Shop/shop_states.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    ShopCubit myCubit=ShopCubit.get(context);
    return Scaffold(
      appBar: AppBar(
        title: myText(text: appName,color: Colors.black),
      ),
      body: BlocConsumer<ShopCubit,ShopStates>(
        listener: (context,state){},
        builder: (context,state){
          return ConditionalBuilder(
            condition: myCubit.homeModel!=null && myCubit.homeModel!.data.products.where((element) => element.inFavorites).isNotEmpty,
            builder: (context)=> Container(
              color: Colors.grey[300],
              child: ListView.separated(
                  itemBuilder: (context,index)=>favoritesDetails(
                      myCubit.homeModel!.data.products.where((element) => element.inFavorites).elementAt(index),
                      myCubit,
                  ),
                  separatorBuilder: (context,index)=>const SizedBox(height: 1,),
                  itemCount: myCubit.homeModel!.data.products.where((element) => element.inFavorites).length
              ),
            ),
            fallback: (context)=>Center(child: noFavourite()),
          );
        },
      ),
    );
  }
  Widget favoritesDetails(ProductModel data,ShopCubit shopCubit){
    return Padding(
      padding: const EdgeInsets.all(1.0),
      child: Container(
        decoration: BoxDecoration(
            //borderRadius: const BorderRadius.only(bottomRight: Radius.circular(30)),
            color: Colors.teal[100]
        ),
        child: Row(
          children: [
            Container(
              color: Colors.white,
              child: Stack(
                alignment: Alignment.bottomLeft,
                children: [
                  Image(
                    image: NetworkImage(data.image),
                    width: 120,
                    height: 120,
                    //fit: BoxFit.cover,
                  ),
                  if(data.discount!=0)Container(
                    decoration: BoxDecoration(
                        color: Colors.red[700],
                        borderRadius: BorderRadius.circular(10)

                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(5.0),
                      child: Text(
                        'Discount',
                        style:  TextStyle(
                          fontSize: 13,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 10,),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data.name,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 10,),
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 3.0),
                            child: Text(
                              'EGP ${data.price}',
                              style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                          ),
                          if(data.discount!=0)Row(
                            children: [
                              Text(
                                'EGP ${(data.oldPrice).round()}',
                                style: const TextStyle(
                                    fontSize: 14,
                                    decoration: TextDecoration.lineThrough
                                ),
                              ),
                              const SizedBox(width: 5,),
                              Container(
                                decoration: BoxDecoration(
                                    color: Colors.red[300],
                                    borderRadius: BorderRadius.circular(10)
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Text(
                                    '-${(((data.price /data.oldPrice)*100)-100).round()}%',
                                    style:  TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey[300],

                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const Spacer(),
                      CircleAvatar(
                        backgroundColor: Colors.yellow[400],
                        child: IconButton(
                          onPressed: (){
                            data.inFavorites=false;
                            shopCubit.deleteFavouriteProduct(productId: data.id);
                          },
                          icon: const Icon(Icons.favorite,color:Colors.red),
                        ),
                      ),
                      const SizedBox(width: 10,)
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget noFavourite(){
    return Container(
      color: Colors.red[400],
      width: double.infinity,
      height: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 200,
            height: 200,
            child: CircleAvatar(
              backgroundColor: Colors.white,
              child: Image(
                image: AssetImage(setImage(url: 'sad1.png')),
                width: 150,
                height: 150,
                fit: BoxFit.cover
              ),
            ),
          ),
          const SizedBox(height: 70,),
          const Text(
            "OOOh .... No Favourite Product yet 😥",
            style: TextStyle(
                color: Colors.white,
              fontSize: 19,
              fontWeight: FontWeight.bold
            ),
          ),
        ],
      ),
    );
  }
}
