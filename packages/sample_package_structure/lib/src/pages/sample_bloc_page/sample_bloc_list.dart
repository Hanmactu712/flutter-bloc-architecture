import 'package:app_core/app_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sample_package_structure/src/pages/sample_bloc_page/cubit/sample_bloc_page_cubit.dart';
import 'package:sample_package_structure/src/services/sample_service/abstract_sample_service.dart';

class SampleBlocList extends StatelessWidget {
  const SampleBlocList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SampleBlocPageCubit(sampleService: context.read<ISampleService>())..loadData(),
      child: BlocBuilder<SampleBlocPageCubit, SampleBlocPageState>(
        builder: (context, state) {
          return RefreshIndicator(
            onRefresh: () async {
              context.read<SampleBlocPageCubit>().loadData();
            },
            child: ResponsiveWidget(
              compactScreen: AppListView(
                children: [
                  ...state.data.map(
                    (item) => Column(
                      spacing: 6.0,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppText(
                          text: item.name,
                          textAlign: TextAlign.start,
                          style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Theme.of(context).colorScheme.primary, fontWeight: FontWeight.bold),
                        ),
                        AppText(
                          text: item.description,
                          maxLines: 3,
                          style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Theme.of(context).colorScheme.onSurface),
                        ),
                        Divider(),
                      ],
                    ),
                  ),
                  //load more button
                  state.loading
                      ? Center(child: const CircularProgressIndicator())
                      : state.hasMore
                      ? TextButton(
                        onPressed: () {
                          context.read<SampleBlocPageCubit>().loadData(loadMore: true);
                        },
                        child: const Text('Load More'),
                      )
                      : const SizedBox(),
                ],
              ),
              expandedScreen: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 2),
                cacheExtent: 100,
                itemCount: state.hasMore ? state.data.length + 1 : state.data.length,
                itemBuilder: (context, index) {
                  if (state.data.isEmpty) {
                    return const SizedBox();
                  }
                  //if has more
                  if (state.hasMore && index == state.data.length) {
                    context.read<SampleBlocPageCubit>().loadData(loadMore: true);
                    return const Center(child: CircularProgressIndicator());
                  }
                  final item = state.data[index];
                  return Card(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
                    child: SizedBox(
                      height: 200,
                      child: Column(
                        spacing: 6.0,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(12.0),
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.primaryContainer,
                              borderRadius: const BorderRadius.only(topLeft: Radius.circular(8.0), topRight: Radius.circular(8.0)),
                            ),
                            child: AppText(
                              text: item.name,
                              textAlign: TextAlign.start,
                              style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Theme.of(context).colorScheme.primary, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: AppText(
                              text: item.description,
                              maxLines: 3,
                              style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Theme.of(context).colorScheme.onSurface),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
