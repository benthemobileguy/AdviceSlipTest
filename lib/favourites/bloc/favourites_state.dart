part of 'favourites_bloc.dart';

abstract class FavouritesState extends Equatable {
  const FavouritesState();

  @override
  List<Object> get props => [];

  Map<String, dynamic>? toJson() {}
}

class FavouritesLoading extends FavouritesState {}

class FavouritesLoaded extends FavouritesState {
  final List<AdviceModel> listOfFavourites;

  const FavouritesLoaded(this.listOfFavourites);

  @override
  List<Object> get props => [listOfFavourites];

  @override
  Map<String, dynamic> toJson() {
    return {'favourites': listOfFavourites};
  }
}

