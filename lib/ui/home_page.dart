import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:test_gql/ui/add_person/add_person_page.dart';
import 'package:test_gql/ui/home_view_model.dart';
import 'package:test_gql/util/constants.dart';

// ignore: must_be_immutable
class HomePage extends StatelessWidget {
  HomePage({super.key});

  BuildContext? mContext;

  @override
  Widget build(BuildContext context) =>
      ViewModelBuilder<HomeViewModel>.reactive(
          viewModelBuilder: HomeViewModel.new,
          onViewModelReady: (final viewModel) {
            mContext = context;
            viewModel.onCatchError = showError;
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
                        itemBuilder: (context, index) {
                          final item = viewModel.people[index];
                          return ListTile(
                            leading: item.image != null
                                ? SizedBox(
                                    width: 48,
                                    height: 48,
                                    child: Image.network(
                                      '$baseUrl/${item.image}',
                                      width: 48,
                                      height: 48,
                                    ),
                                  )
                                : const SizedBox(
                                    child: Icon(Icons.person),
                                  ),
                            title: Text('${item.name}'),
                          );
                        }),
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

  showError(final String message) {
    final ctx = mContext;
    if (ctx == null) {
      return;
    }
    ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(content: Text(message)));
  }
}
