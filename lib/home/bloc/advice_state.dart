part of 'advice_bloc.dart';

abstract class AdviceState extends Equatable {}

class AdviceLoadingState extends AdviceState {
  @override
  List<Object?> get props => [];
}

class AdviceLoadedState extends AdviceState {
  final AdviceModel advice;

  AdviceLoadedState(this.advice);

  @override
  List<Object?> get props => [advice];
}

class AdviceErrorState extends AdviceState {
  final String error;

  AdviceErrorState(this.error);

  @override
  List<Object?> get props => [error];
}