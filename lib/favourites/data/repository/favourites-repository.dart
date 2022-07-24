import 'package:advice_slip_test/home/data/model/advice_model.dart';

class FavouritesRepository {
  List<AdviceModel> favouritesList = [];

  List<AdviceModel> addFavouriteAdvice(AdviceModel adviceModel) {
    final todo = AdviceModel(slip: Slip(advice: adviceModel.slip?.advice, id: adviceModel.slip?.id));
    favouritesList.add(todo);
    return favouritesList;
  }

  List<AdviceModel> removeFavouriteAdvice(int id) {
    favouritesList.removeWhere((element) => element.slip!.id == id);
    return favouritesList;
  }

  List<AdviceModel> updateFavouriteAdviceState(bool isCompleted, int id) {
    for (AdviceModel element in favouritesList) {
      if (element.slip!.id == id) {
        element.slip!.isCompleted = isCompleted;
      }
    }
    return favouritesList;
  }
}
