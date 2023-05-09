part of 'add_category_cubit.dart';

@immutable
abstract class AddCategoryStates {}

class AddCategoryInitState extends AddCategoryStates {}

class AddCategoryLoadingState extends AddCategoryStates {}

class AddCategoryDoneState extends AddCategoryStates {}

class AddCategoryErrorState extends AddCategoryStates {
  final err;

  AddCategoryErrorState(this.err);
}
