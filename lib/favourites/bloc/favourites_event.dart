part of 'favourites_bloc.dart';

abstract class FavouritesEvent extends Equatable {
  const FavouritesEvent();

  @override
  List<Object> get props => [];
}

class AddFavourites extends FavouritesEvent {
  final AdviceModel adviceModel;

  const AddFavourites(this.adviceModel);

  @override
  List<Object> get props => [adviceModel];
}

class RemoveFavourites extends FavouritesEvent {
  final String id;

  const RemoveFavourites(this.id);

  @override
  List<Object> get props => [id];
}

class UpdateFavouritesState extends FavouritesEvent {
  final bool isCompleted;
  final String id;

  const UpdateFavouritesState(this.isCompleted, this.id);

  @override
  List<Object> get props => [isCompleted];
}
