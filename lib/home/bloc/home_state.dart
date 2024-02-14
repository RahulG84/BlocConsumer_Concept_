part of 'home_bloc.dart';

@immutable
sealed class HomeState {}

class HomeActionState extends HomeState {}

final class HomeInitial extends HomeState {}

class HomeLoadingState extends HomeState {}

class HomeSccuessSate extends HomeState {
  List<Product>? products;

  HomeSccuessSate({
    this.products,
  });
}

class HomeErrorState extends HomeState {}
