import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rest_api_with_bloc/home/bloc/home_bloc.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  HomeBloc homeBloc = HomeBloc();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    homeBloc.add(HomeInitialEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Home',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
      body: BlocConsumer<HomeBloc, HomeState>(
        listener: (context, state) {},
        bloc: homeBloc,
        listenWhen: (previous, current) => current is HomeActionState,
        buildWhen: (previous, current) => current is! HomeActionState,
        builder: (context, state) {
          switch (state.runtimeType) {
            case HomeLoadingState:
              return const Center(
                child: CircularProgressIndicator(),
              );
            case HomeSccuessSate:
              final successState = state as HomeSccuessSate;
              return ListView.builder(
                itemCount: successState.products?.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Image(
                        image: NetworkImage(
                          successState.products![index].images[0],
                        ),
                      ),
                      Text(successState.products![index].title),
                    ],
                  );
                },
              );
            case HomeErrorState:
              return const Text('Something Wrong');
            default:
              return const SizedBox();
          }
        },
      ),
    );
  }
}
