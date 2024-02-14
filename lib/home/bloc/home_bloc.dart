import 'dart:async';
import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:rest_api_with_bloc/home/model/home_data.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<HomeInitialEvent>(homeInitialEvent);
  }

  FutureOr<void> homeInitialEvent(
      HomeInitialEvent event, Emitter<HomeState> emit) async {
    List<Product> dataList = [];
    var client = http.Client();
    emit(HomeLoadingState());
    await Future.delayed(
      const Duration(seconds: 2),
    );
    try {
      var resp = await client.get(Uri.parse('https://dummyjson.com/products'));
      Map<String, dynamic> jsonData = jsonDecode(resp.body.toString());
      List<dynamic> productsData = jsonData["products"];
      if (resp.statusCode == 200) {
        for (Map<String, dynamic> items in productsData) {
          dataList.add(
            Product.fromJson(items),
          );
        }
      }
      emit(
        HomeSccuessSate(products: dataList),
      );
    } catch (r) {
      print('Error occurred: $r');
      //emit(HomeErrorState());
    }
  }
}
