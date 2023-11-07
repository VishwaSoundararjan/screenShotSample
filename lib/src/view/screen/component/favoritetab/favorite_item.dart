import 'package:screenshotsample/src/const/app_colors.dart';
import 'package:screenshotsample/src/const/app_font.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FavoriteItem extends StatelessWidget {
  const FavoriteItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 15,
          ),
          Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 6, right: 2),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    'https://vcdn1-giaitri.vnecdn.net/2015/04/23/1-4854-1429761605.jpg?w=0&h=0&q=100&dpr=2&fit=crop&s=Bp8MxcmkYfVaR4Hvlg9qAg',
                    fit: BoxFit.cover,
                    width: 160,
                    height: 200,
                  ),
                ),
              ),
              Positioned(
                  top: 5,
                  left: 7,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                    decoration: BoxDecoration(
                      color: AppColors.primaryColorRed,
                      borderRadius: BorderRadius.circular(90),
                    ),
                    child: const Text(
                      '20%',
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  )),
              const Positioned(
                  top: 5,
                  right: 7,
                  child: Icon(
                    Icons.delete_forever,
                    color: Colors.white,
                  )),
              Positioned(
                  right: 0,
                  bottom: 0,
                  width: 40,
                  height: 40,
                  child: Container(
                      padding: const EdgeInsets.all(9),
                      decoration: BoxDecoration(
                        color: AppColors.primaryColorRed,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey.withOpacity(.2),
                              offset: const Offset(1, 1),
                              spreadRadius: 3,
                              blurRadius: 3),
                        ],
                      ),
                      child: SvgPicture.asset(
                        'assets/images/bag_active.svg',
                        fit: BoxFit.scaleDown,
                        color: Colors.white,
                      ))),
            ],
          ),
          Row(
            children: [
              RatingBar.builder(
                initialRating: 5,
                direction: Axis.horizontal,
                itemSize: 15,
                itemCount: 5,
                ignoreGestures: true,
                itemBuilder: (context, _) => const Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                onRatingUpdate: (rating) {
                  // print(rating);
                },
              ),
              const SizedBox(
                width: 5,
              ),
              const Text('(10)')
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            'Heartloom',
            style: AppFont.regular.copyWith(
              fontSize: 13,
              color: Colors.grey,
              fontWeight: FontWeight.normal,
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            'Summer Wear',
            style: AppFont.bold.copyWith(
              fontSize: 17,
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            '1000',
            style: AppFont.bold
                .copyWith(fontSize: 14, color: AppColors.primaryColorRed),
          ),
        ],
      ),
    );
  }
}
