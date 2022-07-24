import 'dart:async';

import 'package:advice_slip_test/favourites/data/repository/favourites-repository.dart';
import 'package:advice_slip_test/home/data/model/advice_model.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
part 'favourites_event.dart';
part 'favourites_state.dart';

class FavouritesBloc extends HydratedBloc<FavouritesEvent, FavouritesState> {
  final FavouritesRepository todoRepository;

  FavouritesBloc(this.todoRepository) : super(FavouritesLoaded(todoRepository.favouritesList)) {
    on<AddFavourites>((event, emit) async {
      emit(FavouritesLoading());
      final updatedFavouritesList = todoRepository.addFavouriteAdvice(event.adviceModel);
      emit(FavouritesLoaded(updatedFavouritesList));
    });
    on<RemoveFavourites>((event, emit) {
      emit(FavouritesLoading());
      final updatedFavouritesList = todoRepository.removeFavouriteAdvice(int.parse(event.id));
      emit(FavouritesLoaded(updatedFavouritesList));
    });

    on<UpdateFavouritesState>((event, emit) async {
      emit(FavouritesLoading());
      final updatedFavouritesList =
      todoRepository.updateFavouriteAdviceState(event.isCompleted, int.parse(event.id));
      emit(FavouritesLoaded(updatedFavouritesList));
    });
  }

  @override
  FavouritesState? fromJson(Map<String, dynamic> json) {
    try {
      final listOfFavourites = (json['todo'] as List)
          .map((e) => AdviceModel.fromJson(e as Map<String, dynamic>))
          .toList();

      todoRepository.favouritesList = listOfFavourites;
      return FavouritesLoaded(listOfFavourites);
    } catch (e) {
      return null;
    }
  }

  @override
  Map<String, dynamic>? toJson(FavouritesState state) {
    if (state is FavouritesLoaded) {
      return state.toJson();
    } else {
      return null;
    }
  }
}
