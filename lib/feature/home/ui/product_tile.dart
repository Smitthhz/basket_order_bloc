import 'package:bloc_app/feature/home/bloc/home_bloc.dart';
import 'package:bloc_app/feature/home/model/home_product_model.dart';
import 'package:flutter/material.dart';

class ProductTileWidget extends StatelessWidget {
  final ProductDataModel productDataModel;
  final HomeBloc homeBloc;
  const ProductTileWidget({super.key, required this.productDataModel, required this.homeBloc});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(12)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Container(
          height: 200,
          width: double.infinity,
          decoration: BoxDecoration(
            // Check if imageUrl is not null and not empty
            image: productDataModel.imageUrl.isNotEmpty
                ? DecorationImage(
                    image: NetworkImage(productDataModel.imageUrl),
                    fit: BoxFit.cover,
                  )
                : const DecorationImage(
                    // Placeholder image or alternative design
                    image: NetworkImage(
                        'https://thumbs.dreamstime.com/b/vector-illustration-avatar-dummy-logo-collection-image-icon-stock-isolated-object-set-symbol-web-137160339.jpg'),
                    fit: BoxFit.cover,
                  ),
          ),
        ),
        const SizedBox(height: 15),
        Text(
          productDataModel.name,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        Text(productDataModel.description),
        const SizedBox(
          height: 15,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              " \$${productDataModel.price}",
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            Row(
              children: [
                IconButton(
                    onPressed: () {
                    homeBloc.add(HomeProductWishlistButtonClickEvent(clickedProduct: productDataModel));
                    },
                    icon: const Icon(
                      Icons.favorite_border,
                      color: Colors.black,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      homeBloc.add(HomeProductCartButtonClickEvent(clickedProduct: productDataModel));
                    },
                    icon: const Icon(
                      Icons.shopping_bag_outlined,
                      color: Colors.black,
                    ),
                  ),
              ],
            )
          ],
        ),
      ]),
    );
  }
}
