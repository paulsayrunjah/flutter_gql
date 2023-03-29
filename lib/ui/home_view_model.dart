import 'package:stacked/stacked.dart';
import 'package:test_gql/app/locator.dart';
import 'package:test_gql/models/person.dart';
import 'package:test_gql/services/api/user/user_api.dart';

class HomeViewModel extends BaseViewModel {
  List<Person> people = [];
  bool isLoading = true;
  final userApi = locator<UserApi>();

  Function(String)? onCatchError;

  getPeople() {
    showLoader();
    userApi.getPeople().catchError((final error) {
      onCatchError?.call(error);
      hideLoader();
    }).then((final value) {
      hideLoader();
      if (value == null) {
        return;
      }
      people = value;
    });
  }

  showLoader() {
    isLoading = true;
    notifyListeners();
  }

  hideLoader() {
    isLoading = false;
    notifyListeners();
  }
}
