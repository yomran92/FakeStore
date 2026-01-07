part of 'category_bloc.dart';

abstract class CategoryState extends Equatable {
  const CategoryState();
  @override
  List<Object> get props => [];
}

class CategoryInitial extends CategoryState {}
class CategoryLoading extends CategoryState {}
class GetAllCategoryLoaded extends CategoryState {
  final GetAllCategoryEntity  getAllCategoryEntity;

  const GetAllCategoryLoaded({    required this.getAllCategoryEntity});
  
  @override
  List<Object> get props => [getAllCategoryEntity];
}
 class CategoryError extends CategoryState {
  final String message;
  const CategoryError(this.message);
  @override
  List<Object> get props => [message];
}
