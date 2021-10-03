import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'food_card.dart';
import '../models/category.dart';
import '../services/api_service.dart';
import '../widgets/food_category.dart';
// DAta
//import '../data/category_data.dart';

// Model
import '../models/category.dart';

class FoodCategory extends StatelessWidget {
  ApiService api = ApiService();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<CategoryModel>>(
      future: api.getCategories(),
      builder: (context, snapshot) {
        if (!snapshot.hasData)
          return Center(child: CircularProgressIndicator());

        return Container(
            height: 80.0,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: snapshot.data
                  .map(
                    (data) => GestureDetector(
                        onTap: () {},
                        child: FoodCard(
                          name: data.name,
                          imagePath: data.imagePath,
                          numberOfItems: 3,
                        )),
                  )
                  .toList(),
            ));
      },
    );
  }
}
