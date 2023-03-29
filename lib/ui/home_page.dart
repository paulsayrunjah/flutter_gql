import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:test_gql/ui/add_person/add_person_page.dart';
import 'package:test_gql/ui/home_view_model.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) =>
      ViewModelBuilder<HomeViewModel>.reactive(
          viewModelBuilder: HomeViewModel.new,
          onViewModelReady: (final viewModel) {
            viewModel.getPeople();
          },
          builder: ((context, viewModel, child) => Scaffold(
                appBar: AppBar(
                  title: const Text('Users'),
                  centerTitle: true,
                ),
                body: viewModel.isLoading
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : ListView.builder(
                        itemCount: viewModel.people.length,
                        itemBuilder: ((context, index) => ListTile(
                              title: Text('${viewModel.people[index].name}'),
                            ))),
                floatingActionButton: FloatingActionButton(
                    child: const Icon(Icons.add),
                    onPressed: () async {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AddPersonPage()),
                      ).then((value) {
                        if (value != null) {
                          viewModel.getPeople();
                        }
                      });
                    }),
              )));
}
