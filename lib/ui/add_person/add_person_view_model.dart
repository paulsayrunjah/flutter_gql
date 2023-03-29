import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:test_gql/app/locator.dart';
import 'package:test_gql/models/person.dart';
import 'package:test_gql/services/api/user/request_models/add_person_request.dart';
import 'package:test_gql/services/api/user/user_api.dart';

class AddPersonViewModel extends BaseViewModel {
  bool isLoading = false;
  final nameTextController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final userApi = locator<UserApi>();

  Function(Person)? onAddSuccess;

  addPerson() {
    if (formKey.currentState != null && !formKey.currentState!.validate()) {
      return;
    }

    showLoader();
    final req = AddPersonRequest(nameTextController.text);
    userApi.addPerson(req).catchError((final value) {
      hideLoader();
    }).then((value) {
      hideLoader();
      if (value == null) {
        return;
      }
      onAddSuccess?.call(value);
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
