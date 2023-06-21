import 'package:merchant_app/feauters/dispute/domin/response/delet_dispute_response.dart';
import 'package:meta/meta.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/config/urls.dart';
import '../../../../core/data/network/remote/dio_helper.dart';
import '../../../../core/resources/constants_manager.dart';
import '../../domin/request/add_dispute_request.dart';
import '../../domin/response/get_all_dispute_response.dart';
import 'package:dio/dio.dart';

part 'dispute_state.dart';

class DisputeCubit extends Cubit<DisputeState> {
  DisputeCubit() : super(DisputeInitial());

  static DisputeCubit get(context) => BlocProvider.of(context);

  List<Data> disputeList = [];

  GetAllDisputedResponse getAllDisputed = GetAllDisputedResponse();
  Data getDisputedById = Data();

  DeleteDisputeResponse deleteDisputeResponse = DeleteDisputeResponse();
  DeleteDisputeResponse convertProcessingDisputeResponse =
      DeleteDisputeResponse();
  DeleteDisputeResponse convertResolveDisputeResponse = DeleteDisputeResponse();
  DeleteDisputeResponse sendCommentDisputeResponse = DeleteDisputeResponse();
  DeleteDisputeResponse addDisputeResponse = DeleteDisputeResponse();

  getDisputes({required String merchant_id}) {
    emit(DisputeLoadingState());
    DioHelper.getData(
      url: Urls.getAllDispute,
      query: {
        'page': '1',
        'merchant_id': merchant_id,
      },
      token: Constants.bearer + Constants.token,
    ).then((value) {
      if (value.data['status']) {
        getAllDisputed = GetAllDisputedResponse.fromJson(value.data);
        disputeList = getAllDisputed.data!;
        emit(DisputeDoneState(getAllDisputed));
      }
    }).catchError((error) {
      print(error.toString());
      emit(DisputeErrorState(error.toString()));
    });
  }

  getDisputesById({required String dispute_id}) {
    emit(GetDisputeByIdLoadState());
    DioHelper.getData(
      url: Urls.getDisputeById + dispute_id,
      token: Constants.bearer + Constants.token,
    ).then((value) {
      if (value.data['status']) {
        getDisputedById = Data.fromJson(value.data['data']);
        emit(GetDisputeByIdDoneState(getDisputedById));
      }
    }).catchError((error) {
      print(error.toString());
      emit(DisputeErrorState(error.toString()));
    });
  }

  deleteDispute({required String dispute_id}) {
    emit(DeleteDisputeLoadingState());
    DioHelper.deleteData(
      url: Urls.deleteDispute + dispute_id,
      token: Constants.bearer + Constants.token,
    ).then((value) {
      if (value.data['status']) {
        deleteDisputeResponse = DeleteDisputeResponse.fromJson(value.data);
        emit(DeleteDisputeDoneState(deleteDisputeResponse));
      } else {
        emit(DeleteDisputeErrorState(value.data['message']));
      }
    }).catchError((error) {
      emit(DeleteDisputeErrorState(error));
    });
  }

  convertProcessDispute({required String dispute_id}) {
    emit(ConvertProcessingDisputeLoadingState());
    DioHelper.putData(
      url: Urls.convertProcessDispute + dispute_id,
      token: Constants.bearer + Constants.token,
    ).then((value) {
      if (value.data['status']) {
        convertProcessingDisputeResponse =
            DeleteDisputeResponse.fromJson(value.data);
        emit(ConvertProcessingDisputeDoneState(
            convertProcessingDisputeResponse));
      }
    }).catchError((error) {
      emit(ConvertProcessingDisputeErrorState(error.toString()));
    });
  }

  convertResolveDispute({required String dispute_id}) {
    emit(ConvertResolveDisputeLoadState());
    DioHelper.putData(
      url: Urls.convertResolveDispute + dispute_id,
      token: Constants.bearer + Constants.token,
    ).then((value) {
      if (value.data['status']) {
        convertResolveDisputeResponse =
            DeleteDisputeResponse.fromJson(value.data);
        emit(ConvertResolveDisputeDoneState(convertResolveDisputeResponse));
      }
    }).catchError((error) {
      emit(ConvertResolveDisputeErrorState(error.toString()));
    });
  }

  sendComment(
      {required String dispute_id,
      required String comment,
      bool isadmin = false}) {
    emit(SendCommentDisputeLoadState());
    DioHelper.postData(
      url: Urls.sendCommentDispute + dispute_id,
      data: {"message": comment, "admin": isadmin},
      token: Constants.bearer + Constants.token,
    ).then((value) {
      if (value.data['status']) {
        sendCommentDisputeResponse = DeleteDisputeResponse.fromJson(value.data);
        emit(SendCommentDisputeDoneState(sendCommentDisputeResponse));
      } else {
        emit(SendCommentDisputeErrorState(value.data['message']));
      }
    }).catchError((error) {
      emit(SendCommentDisputeErrorState(error.toString()));
    });
  }

  addDispute({required AddDisputeRequest addDisputeRequest}) async {
    emit(AddDisputeLoadState());
    DioHelper.postData(
      url: Urls.addDispute,
      data: FormData.fromMap(await addDisputeRequest.toJson(
          disputeImage: addDisputeRequest.disputeImage!)),
      token: Constants.bearer + Constants.token,
    ).then((value) {
      if (value.data['status']) {
        addDisputeResponse = DeleteDisputeResponse.fromJson(value.data);
        emit(AddDisputeDoneState(addDisputeResponse));
      } else {
        emit(AddDisputeErrorState(value.data['message']));
      }
    }).catchError((error) {
      emit(AddDisputeErrorState(error.toString()));
    });
  }
}
