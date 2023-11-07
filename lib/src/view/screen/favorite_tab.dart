import 'package:screenshotsample/src/view/screen/component/favoritetab/favorite_scroll.dart';
import 'package:screenshotsample/src/viewmodel/product_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoriteTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var productProvider = Provider.of<ProductViewModel>(context,listen: false);
    for (var element in productProvider.listProduct!) {
     // print(element.isLike);
    }
    return SafeArea(
      child: FavoriteScroll(),
    );
  }
}
