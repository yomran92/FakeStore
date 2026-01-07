
part of 'category_bloc.dart';
abstract class CategoryEvent extends Equatable {
  const CategoryEvent();

}

 class GetCategoryEvent extends CategoryEvent {
  const GetCategoryEvent({this.getCategoryParams});
  final GetAllCategoryParams? getCategoryParams;
  @override
  List<Object?> get props => [getCategoryParams];
 }

