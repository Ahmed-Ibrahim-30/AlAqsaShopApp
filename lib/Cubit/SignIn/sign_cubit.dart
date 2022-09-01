import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../Cubit/Shop/shop_cubit.dart';
import '../../Components/widget_shared.dart';
import '../../Model/login.dart';
import '../../Components/SharedPreference.dart';
import '../../Modules/SettingsScreen/settings_screen.dart';
import '../../Network/dio_helper.dart';
import 'signStates.dart';
import '../../Components/variableShared.dart';

class SignCubit extends Cubit<SignStates>{
  SignCubit():super(InitSignState());
  static SignCubit get (context)=>BlocProvider.of(context);

  IconData passwordIcon=Icons.visibility_off;
  bool passwordVisibility=true;


  bool skipOnBoardingScreen=ShopCache.getData(key: 'skipOnBoardingScreen') ?? false;




  void changeFormDetails(){
    emit(ChangeFormState());
  }

  void changePasswordVisibility(){
    passwordVisibility=!passwordVisibility;
    emit(ChangePasswordVisibilityState());
  }

  void login({
  required String email,
  required String password,
}){
    emit(LoginLoadingState());
    DioHelper.postData(url: loginUrl, data: {
      'email':email,
      'password':password,
    }).then((value) {
      ShopCache.saveData(key: 'token', value: value.data['data']['token']);
      myToken= value.data['data']['token'];
      userDetails=SignInModel.fromJson(value.data);

      ShopCache.saveData(key: 'userImage', value: userDetails!.date!.image);
      ShopCache.saveData(key: 'userName', value: userDetails!.date!.name);
      ShopCache.saveData(key: 'userEmail', value: userDetails!.date!.email);
      ShopCache.saveData(key: 'userPhone', value: userDetails!.date!.phone);
      ShopCache.saveData(key: 'userPassword', value: password);
      emit(LoginSuccessState(SignInModel.fromJson(value.data)));
    }).catchError((onError){
      //print(onError.toString());
      emit(LoginErrorState());
      }
      );
  }


  void register({
    required String name,
    required String email,
    required String password,
    required String phone,
  }){
    emit(RegisterLoadingState());
    DioHelper.postData(url: registerUrl, data: {
      'email':email,
      'password':password,
      'name':name,
      'phone':phone
    }).then((value) {
      userDetails=SignInModel.fromJson(value.data);
      ShopCache.saveData(key: 'token', value: userDetails!.date!.token);
      myToken= value.data['data']['token'];
      ShopCache.saveData(key: 'userImage', value: userDetails!.date!.image);
      ShopCache.saveData(key: 'userName', value: userDetails!.date!.name);
      ShopCache.saveData(key: 'userEmail', value: userDetails!.date!.email);
      ShopCache.saveData(key: 'userPhone', value: userDetails!.date!.phone);
      ShopCache.saveData(key: 'userPassword', value: password);
      emit(RegisterSuccessState(SignInModel.fromJson(value.data)));
    }).catchError((onError){
      print(onError.toString());
      emit(RegisterErrorState());
    }
    );
  }

  void editProfile({
    required String name,
    required String email,
    required String password,
    required String phone,
    required String image,
    required context,
  }){
    emit(UpdateLoadingState());
    DioHelper.putData(
        url: updateProfileUrl,
        token:  ShopCache.getData(key: 'token'),
        data: {
          'name':name,
          'phone':phone,
          'email':email,
          'password':password,
          'image':image
    }).then((value) {
      userDetails=SignInModel.fromJson(value.data);
      ShopCache.saveData(key: 'token', value: userDetails!.date!.token);
      myToken= value.data['data']['token'];

      ShopCache.saveData(key: 'userName', value: userDetails!.date!.name);
      ShopCache.saveData(key: 'userEmail', value: userDetails!.date!.email);
      ShopCache.saveData(key: 'userPhone', value: userDetails!.date!.phone);
      ShopCache.saveData(key: 'userPassword', value: password);
      emit(UpdateSuccessState(value.data['status'],value.data['message']));
      ShopCubit.get(context).goToSettingsPage();
      goToAnotherScreen(context,const SettingsScreen());
    }).catchError((onError){
      //print(onError.toString());
      emit(UpdateErrorState('Update Failed'));
    }
    );
  }

  void changeImage(){
    emit(ChangeImageState());
  }



}