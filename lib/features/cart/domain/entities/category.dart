
import '../../../../core/feature/domain/entities/entity.dart';
import '../../data/models/response/cart_item_model.dart';

class GetCartItemsEntity extends Entity {
  GetCartItemsEntity({

required this.items,
  });

  late List<CartItemModel>? items;

  @override
  List<Object?> get props => [items];
}
