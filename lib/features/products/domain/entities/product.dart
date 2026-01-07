import 'package:fakestore/features/products/data/models/response/get_all_product_model.dart';

import '../../../../core/feature/domain/entities/entity.dart';




class GetAllProductEntity extends Entity {
  GetAllProductEntity({

      this.productList,
  });

  late List<ProductModel>? productList;

  @override
  List<Object?> get props => [productList];
}
