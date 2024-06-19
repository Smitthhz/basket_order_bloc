import 'package:bloc_app/feature/home/bloc/home_bloc.dart';
import 'package:bloc_app/feature/home/ui/product_tile.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cart/ui/cart.dart';
import '../../wishlist/ui/wishlist.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    homeBloc.add(HomeInitialEvent());
    super.initState();
  }

  final HomeBloc homeBloc = HomeBloc();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      bloc: homeBloc,
      listenWhen: (previous, current) => current is HomeActionState,
      buildWhen: (previous, current) => current is! HomeActionState,
      listener: (context, state) {
        if (state is HomeNavigateToCartPageActionState) {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => const Cart()));
        } else if (state is HomeNavigateToWishListPageActionState) {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const Wishlist()));
        } else if (state is HomeProductWishlistedActionState) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Added to wishlist'),
              backgroundColor: Colors.teal,
              duration: Duration(seconds: 1),
              dismissDirection: DismissDirection.up,
            ),
          );
        } else if (state is HomeProductCartedActionState) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Added to Cart'),
               backgroundColor: Colors.teal,
               duration: Duration(seconds: 1),
            ),
          );
        }
      },
      builder: (context, state) {
        switch (state.runtimeType) {
          case HomeLoadingState:
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(
                  color: Colors.teal,
                ),
              ),
            );

          case HomeLoadedSuccessState:
            final successState = state as HomeLoadedSuccessState;
            return Scaffold(
              appBar: AppBar(
                centerTitle: true,
                backgroundColor: Colors.teal,
                title: const Text(
                  "Gaurav Grocery App",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                actions: [
                  IconButton(
                    onPressed: () {
                      homeBloc.add(HomeWishlistButtonNavigateEvent());
                    },
                    icon: const Icon(
                      Icons.favorite_border,
                      color: Colors.white,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      homeBloc.add(HomeCartButtonNavigateEvent());
                    },
                    icon: const Icon(
                      Icons.shopping_bag_outlined,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              body: ListView.builder(
                  itemCount: successState.products.length,
                  itemBuilder: (context, index) {
                    return ProductTileWidget(
                        homeBloc: homeBloc,
                        productDataModel: successState.products[index]);
                  }),
            );

          case HomeErrorState:
            return const Scaffold(
              body: Center(
                child: Text(
                  'Error',
                  style: TextStyle(color: Colors.red),
                ),
              ),
            );

          default:
            return const Scaffold(
              body: Center(
                child: Text(
                  "Something went wrong unusually",
                  style: TextStyle(color: Colors.red),
                ),
              ),
            );
        }
      },
    );
  }
}



// return Scaffold(
//           appBar: AppBar(
//             centerTitle: true,
//             backgroundColor: Colors.teal,
//             title: const Text(
//               "Gaurav Grocery App",
//               style:
//                   TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
//             ),
//             actions: [
//               IconButton(
//                 onPressed: () {
//                   homeBloc.add(HomeWishlistButtonNavigateEvent());
//                 },
//                 icon: const Icon(
//                   Icons.favorite_border,
//                   color: Colors.white,
//                 ),
//               ),
//               IconButton(
//                 onPressed: () {
//                    homeBloc.add(HomeCartButtonNavigateEvent());
//                 },
//                 icon: const Icon(
//                   Icons.shopping_bag_outlined,
//                   color: Colors.white,
//                 ),
//               ),
//             ],
//           ),
//         );