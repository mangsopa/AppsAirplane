import 'package:airplaneapps/models/destination_model.dart';
import 'package:airplaneapps/services/destination_service.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'destination_state.dart';

class DestinationCubit extends Cubit<DestinationState> {
  DestinationCubit() : super(DestinationInitial());

  void fecthDestinations() async {
    try {
      emit(DestinationLoading());
      List<DestinationModel> destinations =
          await DestinationService().fetchDestinations();
      emit(DestinationSuccess(destinations));
    } catch (e) {
      emit(DestinationFailed(e.toString()));
    }
  }
}
