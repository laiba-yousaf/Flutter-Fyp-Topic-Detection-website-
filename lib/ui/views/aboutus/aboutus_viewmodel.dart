import 'package:stacked/stacked.dart';

class AboutusViewModel extends BaseViewModel {
  bool isHovered = false;
  void sethovered(bool state) {
    isHovered = state;
    notifyListeners();
  }
}
