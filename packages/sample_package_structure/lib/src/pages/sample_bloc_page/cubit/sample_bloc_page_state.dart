part of 'sample_bloc_page_cubit.dart';

class SampleBlocPageState extends Equatable {
  final List<SampleModel> data;
  final bool hasMore;
  final bool loading;
  final String error;

  const SampleBlocPageState({required this.data, required this.hasMore, required this.loading, this.error = ''});

  //copyWith
  SampleBlocPageState copyWith({List<SampleModel>? data, bool? hasMore, bool? loading, String? error}) {
    return SampleBlocPageState(data: data ?? this.data, hasMore: hasMore ?? this.hasMore, loading: loading ?? this.loading, error: error ?? this.error);
  }

  SampleBlocPageState.initial() : data = [], hasMore = true, loading = false, error = '';

  SampleBlocPageState.loading() : data = [], hasMore = true, loading = true, error = '';

  const SampleBlocPageState.loaded(this.data, this.hasMore) : loading = false, error = '';

  SampleBlocPageState.error(this.error) : data = [], hasMore = false, loading = false;

  @override
  List<Object> get props => [data, hasMore, loading, error];
}
