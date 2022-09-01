import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../Components/variableShared.dart';
import '../../Components/widget_shared.dart';
import '../../Model/home_model.dart';
import '../../Cubit/Shop/shop_cubit.dart';
import '../../Cubit/Shop/shop_states.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: myText(text: appName,color: Colors.black),
      ),
      body: BlocConsumer<ShopCubit, ShopStates>(
          listener: (context, state) {

          },
          builder: (context, state) {
            ShopCubit myCubit = ShopCubit.get(context);
            return ConditionalBuilder(
              condition: myCubit.homeModel != null,
              builder: (context) =>
                  SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        myCarousel(myCubit.homeModel!),
                        const SizedBox(height: 5,),
                        Container(
                          color: Colors.grey[300], //
                          child: GridView.count(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            crossAxisCount: 2,
                            mainAxisSpacing: 1.0,
                            crossAxisSpacing: 1.0,
                            childAspectRatio: 1 / 1.60,
                            children: List.generate(
                                myCubit.homeModel!.data.products.length,
                                    (index) {
                                  return productDetails(myCubit.homeModel!.data.products[index],myCubit,index);
                                }
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
              fallback: (context) =>
              const Center(child: CircularProgressIndicator(),),
            );
          }
      ),
    );
  }

  Widget myCarousel(HomeModel homeModel){
    return CarouselSlider(
      items: homeModel.data.banners.map((e) => Image(
        image: NetworkImage(e.image),
        width:double.infinity,
        fit: BoxFit.fill,
      )).toList(),
      options: CarouselOptions(
          viewportFraction: 1.0,
          initialPage: 0,
          height: 220,
          scrollDirection: Axis.horizontal,
          autoPlayCurve: Curves.fastOutSlowIn,
          autoPlayInterval: const Duration(seconds: 3),
          autoPlayAnimationDuration: const Duration(seconds: 3),
          autoPlay: true,
          enableInfiniteScroll: true,
          reverse: false
      ),
    );
  }



}
