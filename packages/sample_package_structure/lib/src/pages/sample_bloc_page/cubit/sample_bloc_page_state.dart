part of 'sample_bloc_page_cubit.dart';

sealed class SampleBlocPageState extends Equatable {
  const SampleBlocPageState();

  @override
  List<Object> get props => [];
}

final class SampleBlocPageInitial extends SampleBlocPageState {}

final class SampleBlocPageLoading extends SampleBlocPageState {}

final class SampleBlocPageLoaded extends SampleBlocPageState {
  final String data;

  const SampleBlocPageLoaded(this.data);

  @override
  List<Object> get props => [data];
}

final class SampleBlocPageError extends SampleBlocPageState {
  final String message;

  const SampleBlocPageError(this.message);

  @override
  List<Object> get props => [message];
}
