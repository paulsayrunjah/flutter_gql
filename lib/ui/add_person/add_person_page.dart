import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:test_gql/models/person.dart';
import 'package:test_gql/ui/add_person/add_person_view_model.dart';
import 'package:test_gql/util/widgets.dart';

// ignore: must_be_immutable
class AddPersonPage extends StatelessWidget {
  AddPersonPage({super.key});

  BuildContext? mContext;

  @override
  Widget build(BuildContext context) =>
      ViewModelBuilder<AddPersonViewModel>.reactive(
          viewModelBuilder: AddPersonViewModel.new,
          onViewModelReady: (final viewModel) {
            mContext = context;
            viewModel.onAddSuccess = successAddition;
          },
          builder: ((context, viewModel, child) => Scaffold(
                appBar: AppBar(
                  title: const Text('Add person'),
                ),
                body: Container(
                  padding: const EdgeInsets.all(16),
                  child: Form(
                    key: viewModel.formKey,
                    child: Column(
                      children: [
                        textFieldInput(
                            hintText: 'Name',
                            controller: viewModel.nameTextController,
                            validator: (final value) {
                              if (value == null ||
                                  (value is String && value.isEmpty)) {
                                return 'Field is required';
                              }
                            }),
                        Container(
                          child: viewModel.isLoading
                              ? const Center(
                                  child: CircularProgressIndicator(),
                                )
                              : ElevatedButton(
                                  onPressed: () {
                                    viewModel.addPerson();
                                  },
                                  child: const Text('Save')),
                        )
                      ],
                    ),
                  ),
                ),
              )));

  successAddition(Person person) {
    final ctx = mContext;
    if (ctx == null) {
      return;
    }
    Navigator.of(ctx).pop(person);
  }
}
