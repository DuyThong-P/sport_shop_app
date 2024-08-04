import 'package:flutter/material.dart';

import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../utils/contants/sizes.dart';
import '../../controllers/dummy_data.dart';
import 'widgets/rating_progress_indicator.dart';
import 'widgets/rating_star.dart';
import 'widgets/user_review_card.dart';

class ProductReviewsScreen extends StatelessWidget {
  const ProductReviewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /// -- Appbar
      appBar: const MAppBar(
          title: Text('Đánh giá & Xếp hạng'), showBackArrow: true),

      /// -- Body
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(MSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// -- Reviews List
              const Text(
                  "Xếp hạng và đánh giá được xác minh đến từ những người đã mua hàng"),
              const SizedBox(height: MSizes.spaceBtwItems),

              /// Overall Product Ratings
              const MOverallProductRating(),
              const MRatingBarIndicator(rating: 3.5),
              const Text("12,611"),
              const SizedBox(height: MSizes.spaceBtwSections),

              /// User Reviews List
              ListView.separated(
                shrinkWrap: true,
                itemCount: MDummyData.productReviews.length,
                physics: const NeverScrollableScrollPhysics(),
                separatorBuilder: (_, __) =>
                    const SizedBox(height: MSizes.spaceBtwSections),
                itemBuilder: (_, index) => UserReviewCard(
                    productReview: MDummyData.productReviews[index]),
              )
            ],
          ),
        ),
      ),
    );
  }
}
