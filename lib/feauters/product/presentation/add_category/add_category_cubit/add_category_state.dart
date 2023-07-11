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

// Update Category States:
class UpdateCategoryLoadingState extends AddCategoryStates {}

class UpdateCategoryDoneState extends AddCategoryStates {}

class UpdateCategoryErrorState extends AddCategoryStates {
  final String err;

  UpdateCategoryErrorState(this.err);
}

// Delete Category States:
class DeleteCategoryLoadingState extends AddCategoryStates {}

class DeleteCategoryDoneState extends AddCategoryStates {}

class DeleteCategoryErrorState extends AddCategoryStates {
  final String err;

  DeleteCategoryErrorState(this.err);
}
