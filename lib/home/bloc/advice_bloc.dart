import 'package:advice_slip_test/home/data/model/advice_model.dart';
import 'package:advice_slip_test/home/data/repository/advice_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'advice_event.dart';
part 'advice_state.dart';

class AdviceBloc extends Bloc<AdviceEvent, AdviceState> {
  final AdviceRepository _adviceRepository;

  AdviceBloc(this._adviceRepository) : super(AdviceLoadingState()) {
    on<LoadAdviceEvent>((event, emit) async {
      emit(AdviceLoadingState());
      try {
        final advice = await _adviceRepository.getAdvice();
        emit(AdviceLoadedState(advice));
      } catch (e) {
        emit(AdviceErrorState(e.toString()));
      }
    });
  }
}