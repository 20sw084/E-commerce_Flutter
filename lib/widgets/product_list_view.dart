import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:tri_karo_2/widgets/product_carousel_card.dart';

class ProductListView extends StatelessWidget {
  final ScrollPhysics physics;
  const ProductListView({Key? key, this.physics = const BouncingScrollPhysics()}) : super(key: key);

  @override
  Widget build(BuildContext context) => Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: MasonryGridView.count(
          shrinkWrap: true,
          itemCount: 12,
          crossAxisCount: 2,
          mainAxisSpacing: 16,
          crossAxisSpacing: 0,
          padding: EdgeInsets.zero,
          physics: physics,
          // TODO Call Product Carousel Card with proper values
          itemBuilder: (context, index) => const ProductCarouselCard(image: 'https://static.nike.com/a/images/c_limit,w_400,f_auto/t_product_v1/11298ad9-be3f-4fb1-b69b-f8e0f2776074/image.jpg', name: '', description: '', price: '',)));
}
