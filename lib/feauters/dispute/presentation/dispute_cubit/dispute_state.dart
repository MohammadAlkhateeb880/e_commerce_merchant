part of 'dispute_cubit.dart';

@immutable
abstract class DisputeState {}
//get all disputes states
class DisputeInitial extends DisputeState {}

class DisputeLoadingState extends DisputeState {}

class DisputeDoneState extends DisputeState {
  final GetAllDisputedResponse getDisputedById;

  DisputeDoneState(this.getDisputedById);
}

class DisputeErrorState extends DisputeState {
  final error;

  DisputeErrorState(this.error);
}

//get dispute by id
class GetDisputeByIdLoadState extends DisputeState {}

class GetDisputeByIdDoneState extends DisputeState {
  final Data getDisputeByIdResponse;
  GetDisputeByIdDoneState(this.getDisputeByIdResponse);
}

class GetDisputeByIdErrorState extends DisputeState {
  final error;
  GetDisputeByIdErrorState(this.error);
}


//delete dispute states

class DeleteDisputeLoadingState extends DisputeState {}

class DeleteDisputeDoneState extends DisputeState {
  final DeleteDisputeResponse deleteDisputeResponse;
  DeleteDisputeDoneState(this.deleteDisputeResponse);
}

class DeleteDisputeErrorState extends DisputeState {
  final error;
  DeleteDisputeErrorState(this.error);
}

//convert status of dispute to processing

class ConvertProcessingDisputeLoadingState extends DisputeState {}

class ConvertProcessingDisputeDoneState extends DisputeState {
  final DeleteDisputeResponse convertProcessingDisputeResponse;
  ConvertProcessingDisputeDoneState(this.convertProcessingDisputeResponse);
}

class ConvertProcessingDisputeErrorState extends DisputeState {
  final error;
  ConvertProcessingDisputeErrorState(this.error);
}

//convert status of dispute to resolve

class ConvertResolveDisputeLoadState extends DisputeState {}

class ConvertResolveDisputeDoneState extends DisputeState {
  final DeleteDisputeResponse convertResolveDisputeResponse;
  ConvertResolveDisputeDoneState(this.convertResolveDisputeResponse);
}

class ConvertResolveDisputeErrorState extends DisputeState {
  final error;
  ConvertResolveDisputeErrorState(this.error);
}


//add comment to dispute
class SendCommentDisputeLoadState extends DisputeState {}

class SendCommentDisputeDoneState extends DisputeState {
  final DeleteDisputeResponse sendCommentDisputeResponse;
  SendCommentDisputeDoneState(this.sendCommentDisputeResponse);
}

class SendCommentDisputeErrorState extends DisputeState {
  final error;
  SendCommentDisputeErrorState(this.error);
}


//add dispute

class AddDisputeLoadState extends DisputeState {}

class AddDisputeDoneState extends DisputeState {
  final DeleteDisputeResponse addDisputeResponse;
  AddDisputeDoneState(this.addDisputeResponse);
}

class AddDisputeErrorState extends DisputeState {
  final error;
  AddDisputeErrorState(this.error);
}
