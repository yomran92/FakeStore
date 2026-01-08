import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../injection_container.dart';
import '../../data/models/params/get_all_category.dart';
import '../../data/models/response/get_all_category_model.dart';
import '../../data/repositories/category_repository_impl.dart';
import '../../domain/entities/category.dart';
import '../../domain/usecases/get_all_categorys_use_case.dart';
part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  CategoryBloc() : super(CategoryInitial()) {
    on<GetCategoryEvent>(_onGetCategory);
    on<SelectCategoryEvent>(_onSelectCategory);
  }

  Future<void> _onGetCategory(
    GetCategoryEvent event,
    Emitter<CategoryState> emit,
  ) async {


    if (event.searchQuery != null && state is GetAllCategoryLoaded) {
      final currentState = state as GetAllCategoryLoaded;
      final allCategorys = currentState.getAllCategoryEntity.categoryList  ?? [];

      List<CategoryModel> filtered = allCategorys;

      if (event.searchQuery!.isNotEmpty) {
        filtered =
            filtered
                .where(
                  (p) => p.title.toLowerCase().contains(
                event.searchQuery!.toLowerCase(),
              ),
            )
                .toList();
      }

      emit(
        currentState.copyWith(
          searchQuery: event.searchQuery,
          filteredData: filtered,
        ),
      );
      return;
    }


    emit(CategoryLoading());





    final res = await GetAllCategorysUseCase(
      sl<CategoryRepository>(),
    ).call(event.getCategoryParams!);
    res.fold((failure) => emit(CategoryError(failure.details ?? '')), (
      categorys,
    ) {
      emit(
        GetAllCategoryLoaded(
          getAllCategoryEntity: categorys,
          selectedCategory: 'All',
        ),
      );
    });
  }

  void _onSelectCategory(
    SelectCategoryEvent event,
    Emitter<CategoryState> emit,
  ) {
    if (state is GetAllCategoryLoaded) {
      final currentState = state as GetAllCategoryLoaded;
      emit(currentState.copyWith(selectedCategory: event.selectedCategory));
    }
  }



 }
