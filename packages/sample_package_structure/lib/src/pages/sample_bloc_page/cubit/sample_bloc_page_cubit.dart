import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sample_package_structure/sample_package_structure.dart';

part 'sample_bloc_page_state.dart';

class SampleBlocPageCubit extends Cubit<SampleBlocPageState> {
  final ISampleService _sampleService;
  SampleBlocPageCubit({required ISampleService sampleService}) : _sampleService = sampleService, super(SampleBlocPageState.initial());

  List<SampleModel> _data = [];
  final int _currentPage = 1;
  int maxPages = 5;

  Future<void> loadData({bool loadMore = true}) async {
    emit(state.copyWith(loading: true));
    try {
      // Simulate a network call
      if (_currentPage >= maxPages) {
        emit(state.copyWith(error: 'No more data to load'));
        return;
      }

      final data = await _sampleService.fetchData(fromIndex: _data.length);
      if (loadMore) {
        _data = [..._data, ...data];
      } else {
        _data = data;
      }

      emit(state.copyWith(data: _data, hasMore: _currentPage < maxPages, loading: false));
    } catch (e) {
      emit(state.copyWith(error: 'Failed to fetch data'));
    }
  }
}
