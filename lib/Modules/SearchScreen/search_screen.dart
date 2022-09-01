import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/Cubit/Shop/shop_cubit.dart';
import 'package:shopapp/Cubit/Shop/shop_states.dart';

import '../../Components/widget_shared.dart';


class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context,state){
        //print("state = $state");

      },
      builder: (context,state){
        ShopCubit myCubit=ShopCubit.get(context);
        //print(myCubit.searchModel!.data.data.length);
        return SafeArea(
          child: Scaffold(
            body: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: TextField(
                      decoration: InputDecoration(
                          hintText: "Search",
                          prefixIcon: const Icon(Icons.search),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                          )
                      ),
                      onChanged: (value){
                         if(myCubit.searchModel!=null)myCubit.searchModel!.data.data.clear();
                         myCubit.search(value);
                      },
                    ),
                  ),
                  const SizedBox(height: 10,),
                  ConditionalBuilder(
                    condition: myCubit.searchModel != null,
                    builder: (context)=>Container(
                      color: Colors.grey[300], //
                      child: GridView.count(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        crossAxisCount: 2,
                        mainAxisSpacing: 1.0,
                        crossAxisSpacing: 1.0,
                        childAspectRatio: 1 / 1.60,
                        children: List.generate(
                            myCubit.searchModel!.data.data.length,
                                (index) {
                              return productDetails(myCubit.searchModel!.data.data[index],myCubit,index);
                            }
                        ),
                      ),
                    ),
                    fallback: (context)=>const Center(child: CircularProgressIndicator(),),
                  ),

                ],
              ),
            ),
          ),
        );
      },
    );
  }
}