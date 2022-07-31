import 'dart:async';

import 'package:advice_slip_test/favourites/data/repository/favourites-repository.dart';
import 'package:advice_slip_test/home/data/model/advice_model.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
part 'favourites_event.dart';
part 'favourites_state.dart';

class FavouritesBloc extends HydratedBloc<FavouritesEvent, FavouritesState> {
  final FavouritesRepository favouritesRepository;

  FavouritesBloc(this.favouritesRepository) : super(FavouritesLoaded(favouritesRepository.favouritesList)) {
    on<AddFavourites>((event, emit) async {
      emit(FavouritesLoading());
      final updatedFavouritesList = favouritesRepository.addFavouriteAdvice(event.adviceModel);
      emit(FavouritesLoaded(updatedFavouritesList));
    });
    on<RemoveFavourites>((event, emit) {
      emit(FavouritesLoading());
      final updatedFavouritesList = favouritesRepository.removeFavouriteAdvice(int.parse(event.id));
      emit(FavouritesLoaded(updatedFavouritesList));
    });

    on<UpdateFavouritesState>((event, emit) async {
      emit(FavouritesLoading());
      final updatedFavouritesList =
      favouritesRepository.updateFavouriteAdviceState(event.isCompleted, event.id);
      emit(FavouritesLoaded(updatedFavouritesList));
    });
  }

  //Every time the app requires data from the application directory, this method is invoked.
  @override
  FavouritesState? fromJson(Map<String, dynamic> json) {
    try {
      final listOfFavourites = (json['favourites'] as List)
          .map((e) => AdviceModel.fromJson(e as Map<String, dynamic>))
          .toList();

      favouritesRepository.favouritesList = listOfFavourites;
      return FavouritesLoaded(listOfFavourites);
    } catch (e) {
      return null;
    }
  }

  //Every state emitted by the FavouritesBloc is converted to JSON using this method before storing it to the local directory.
  @override
  Map<String, dynamic>? toJson(FavouritesState state) {
    if (state is FavouritesLoaded) {
      return state.toJson();
    } else {
      return null;
    }
  }
}
