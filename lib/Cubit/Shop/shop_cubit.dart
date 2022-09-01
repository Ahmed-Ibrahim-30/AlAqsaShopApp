import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import '../../Model/search_model.dart';
import '../../Components/widget_shared.dart';
import '../../Modules/profile_screen/register_login_screen.dart';
import '../../Components/SharedPreference.dart';
import '../../Components/variableShared.dart';
import '../../Cubit/Shop/shop_states.dart';
import '../../Model/categories_model.dart';
import '../../Model/home_model.dart';
import '../../Network/dio_helper.dart';

class ShopCubit extends Cubit<ShopStates>{
  ShopCubit():super(ShopInitState());
  static ShopCubit get(context)=>BlocProvider.of(context);
  HomeModel ?homeModel;
  SearchModel ?searchModel;
  CategoriesModel ?categoriesModel;
  PersistentTabController persistentTabController=PersistentTabController();
  bool showTabBar=false;


  void getHomeData(){
    emit(HomeLoadingState());
    DioHelper.getData(
        url: homeUrl,
      token: myToken
    ).then((value) {
      homeModel=HomeModel.fromJson(value.data);
      emit(HomeSuccessState());
    }).catchError((onError){
      //print(onError.toString());
      emit(HomeErrorState());
    }
    );
  }
  void getCategoriesData(){
    emit(CategoriesLoadingState());
    DioHelper.getData(
      url: categoriesUrl,
    ).then((value) {
      //print(value.data['status']);
      categoriesModel=CategoriesModel.fromJson(value.data);
      emit(CategoriesSuccessState());
    }).catchError((onError){
      //print(onError.toString());
      emit(CategoriesErrorState());
    }
    );
  }

  void addFavouriteProduct({required ProductModel product}){
    emit(AddFavouriteLoadingState());
    DioHelper.postData(
        url: favoritesUrl,
        token: myToken,
        data: {
          'product_id':product.id,
        }
    ).then((value) {
      emit(AddFavouriteSuccessState());
    }).catchError((error){
      //print(error.toString());
      emit(AddFavouriteErrorState());
    });
  }

  void deleteFavouriteProduct({required int productId}){
    emit(DeleteFavouriteLoadingState());
    DioHelper.postData(
        url: favoritesUrl,
        token: myToken,
        data: {
          'product_id':productId
        }
    ).then((value) {
      emit(DeleteFavouriteSuccessState());
    }).catchError((error){
      //print(error.toString());
      emit(DeleteFavouriteErrorState());
    });
  }

  void goToHomePage(){
    persistentTabController.index=0;
    showTabBar=false;
    emit(GoToHomeState());
  }
  void goToSettingsPage(){
    persistentTabController.jumpToTab(4);
    showTabBar=true;
    emit(GoToSettingsState());
  }

  void disableTabBar(){
    showTabBar=true;
    emit(DisableTabBarState());
  }
  void enableTabBar(){
    showTabBar=false;
    emit(DisableTabBarState());
  }

  void logout({required context}){
    emit(LogoutLoadingState());
    DioHelper.postData(
        url: logoutUrl,
        token: myToken,
        data: {}
    ).then((value) {
      ShopCache.removeData(key: 'token');
      ShopCache.removeData(key: 'userImage');
      ShopCache.removeData(key: 'userName');
      ShopCache.removeData(key: 'userEmail');
      ShopCache.removeData(key: 'userPhone');
      ShopCache.removeData(key: 'userPassword');
      myToken='';
      goToAnotherScreen(context, const RegisterLoginScreen());
      emit(LogoutSuccessState(value.data['status'],value.data['message']));
    }).catchError((onError){
      //print(onError.toString());
      emit(LogoutErrorState());
    }
    );
  }

  void search(String text){
    emit(SearchLoadingState());
    DioHelper.postData(
        url: searchUrl,
        token: myToken,
        data: {
          'text':text
        }
    ).then((value) {
      searchModel=SearchModel.fromJson(value.data);
      emit(SearchSuccessState());
    }).catchError((onError){
      //print(onError.toString());
      emit(SearchErrorState());
    }
    );
  }


}