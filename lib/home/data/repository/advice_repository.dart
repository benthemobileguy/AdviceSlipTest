import 'package:advice_slip_test/home/data/model/advice_model.dart';
import 'package:http/http.dart' as http;

class AdviceRepository {
  final String _baseUrl = "https://api.adviceslip.com/advice";

  Future<AdviceModel> getAdvice() async {
    final response = await http.get(Uri.parse(_baseUrl));
    if (response.statusCode == 200) {
      return adviceModelFromJson(response.body);
    } else {
      throw Exception("Failed to load Advice");
    }
  }
}