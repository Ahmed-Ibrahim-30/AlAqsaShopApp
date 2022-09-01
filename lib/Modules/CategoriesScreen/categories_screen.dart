import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../Components/variableShared.dart';
import '../../Components/widget_shared.dart';
import '../../Cubit/Shop/shop_cubit.dart';
import '../../Cubit/Shop/shop_states.dart';
import '../../Model/categories_model.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ShopCubit myCubit=ShopCubit.get(context);
    // myCubit.getBusinessNews();
    return Scaffold(
      appBar: AppBar(
        title: myText(text: appName,color: Colors.black),
      ),
      body: BlocConsumer<ShopCubit,ShopStates>(
        listener: (context,state){},
        builder: (context,state){
          return ConditionalBuilder(
            condition: myCubit.categoriesModel!=null,
            builder: (context)=> ListView.separated(
                itemBuilder: (context,index)=>categoriesDetails(myCubit.categoriesModel!.data.data[index],index),
                separatorBuilder: (context,index)=>const SizedBox(height: 1,),
                itemCount: myCubit.categoriesModel!.data.data.length
            ),
            fallback: (context)=>const Center(child: CircularProgressIndicator(),),
          );
        },
      ),
    );
  }
  Widget categoriesDetails(Data data,int index){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(bottomRight: Radius.circular(30)),
          color: Colors.teal[100]
        ),
        child: Row(
          children: [
            Image(
              image:index==0?AssetImage(setImage(url: 'category1.png')):
              index==1?AssetImage(setImage(url: 'category2.png')):
              index==2?AssetImage(setImage(url: 'category3.png')):
              index==3?AssetImage(setImage(url: 'category4.png')):
              AssetImage(setImage(url: 'category5.png')),
              width: 90,
              height: 90,
              fit: BoxFit.cover,
            ),
            const SizedBox(width: 10,),
            Text(
              data.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.black
              ),
            ),
            const Spacer(),
            IconButton(onPressed: (){}, icon: const Icon(Icons.arrow_forward_ios))
          ],
        ),
      ),
    );
  }
}
